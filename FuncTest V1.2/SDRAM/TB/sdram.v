
module sdr (
  sdr_DQ,        // sdr data
  sdr_A,         // sdr address
  sdr_BA,        // sdr bank address
  sdr_CK,        // sdr clock
  sdr_CKE,       // sdr clock enable
  sdr_CSn,       // sdr chip select
  sdr_RASn,      // sdr row address
  sdr_CASn,      // sdr column select
  sdr_WEn,       // sdr write enable
  sdr_DQM        // sdr write data mask
);

//---------------------------------------------------------------------
// parameters of 8 Meg x 4 x 4 banks
//
parameter Num_Meg    =  8; //  8 Mb
parameter Data_Width =  4; //  4 bits
parameter Num_Bank   =  4; //  4 banks

parameter tAC = 5.4;
parameter tOH = 2.7;

parameter SDR_A_WIDTH  =  12; // 12 bits
parameter SDR_BA_WIDTH =  2;  // 2 bits (4 banks)

parameter MEG = 21'h100000;
parameter MEM_SIZE = Num_Meg * MEG * Num_Bank;
parameter ROW_WIDTH = 12;
parameter COL_WIDTH = (Data_Width ==  4) ? 11 :
                      (Data_Width ==  8) ? 10 :
                      (Data_Width == 16) ?  9 : 0;

//---------------------------------------------------------------------
// ports
//
input [SDR_A_WIDTH-1:0]  sdr_A;
input [SDR_BA_WIDTH-1:0] sdr_BA;
input                    sdr_CK;
input                    sdr_CKE;
input                    sdr_CSn;
input                    sdr_RASn;
input                    sdr_CASn;
input                    sdr_WEn;
input                    sdr_DQM;
inout [Data_Width-1:0]   sdr_DQ;

//---------------------------------------------------------------------
// registers
//
reg [Data_Width-1:0] Memory [0:MEM_SIZE-1];

reg [2:0]              casLatency;
reg [2:0]              burstLength;

reg [SDR_BA_WIDTH-1:0] bank;
reg [ROW_WIDTH-1:0]    row;
reg [COL_WIDTH-1:0]    column;

reg [3:0] counter;

reg [Data_Width-1:0]   dataOut;
reg enableSdrDQ;

reg write;
reg latency;
reg read;

//---------------------------------------------------------------------
// code 
//
initial begin
  casLatency = 0;
  burstLength = 0;
  bank = 0;
  row = 0;
  column = 0;
  counter = 0;
  dataOut = 0;
  enableSdrDQ = 0;
  write = 0;
  latency = 0;
  read = 0;
end

assign sdr_DQ =
         (Data_Width ==  4) ? (enableSdrDQ ? dataOut :  4'hz) :
         (Data_Width ==  8) ? (enableSdrDQ ? dataOut :  8'hzz) :
         (Data_Width == 16) ? (enableSdrDQ ? dataOut : 16'hzzzz) : 0;

always @(posedge sdr_CK)
  case ({sdr_CSn,sdr_RASn,sdr_CASn,sdr_WEn})
    4'b0000: begin
               $display($time,"ns : Load Mode Register %h",sdr_A);
               casLatency = sdr_A[6:4];
               burstLength = (sdr_A[2:0] == 3'b000) ? 1 :
                             (sdr_A[2:0] == 3'b001) ? 2 :
                             (sdr_A[2:0] == 3'b010) ? 4 :
                             (sdr_A[2:0] == 3'b011) ? 8 : 0;
               $display($time,
                     "ns : mode: CAS Latency=%d,Burst Length=%d",
                     casLatency, burstLength);
             end
    4'b0001: $display($time,"ns : Auto Refresh Command");
    4'b0010: $display($time,"ns : Precharge Command");
    4'b0011: begin
               $display($time,"ns : Activate Command");
               row = sdr_A;
             end
    4'b0100: begin
               $display($time,"ns : Write Command");
               column = (Data_Width ==  4) ? {sdr_A[11],sdr_A[9:0]} :
                        (Data_Width ==  8) ? {sdr_A[9:0]} :
                        (Data_Width == 16) ? {sdr_A[8:0]} : 0;
               bank = sdr_BA;
               write = 1;
               counter = burstLength;
               Memory[{row,column,bank}] = sdr_DQ;
               $display($time,
                     "ns :write: Bank=%d,Row=%d,Column=%d,Data=%d",
                     bank, row, column, sdr_DQ);
             end
    4'b0101: begin
               $display($time,"ns : Read Command");
               column = (Data_Width ==  4) ? {sdr_A[11],sdr_A[9:0]} :
                        (Data_Width ==  8) ? {sdr_A[9:0]} :
                        (Data_Width == 16) ? {sdr_A[8:0]} : 0;
               bank = sdr_BA;
               counter = {1'b0,casLatency} - 1;
               latency = 1;
             end
    4'b0110: $display($time,"ns : Burst Terminate");
    4'b0111: begin
//               $display($time,"ns : Nop Command");
               if ((write == 1) && (counter != 0))
                 begin
                   counter = counter - 1;
                   if (counter == 0) write = 0;
                   else
                     begin
                       column = column + 1;
                       Memory[{row,column,bank}] = sdr_DQ;
                       $display($time,
                         "ns :write: Bank=%d,Row=%d,Column=%d,Data=%d",
                         bank, row, column, sdr_DQ);
                     end
                 end
               else if ((read == 1) && (counter != 0))
                 begin
                   counter = counter - 1;
                   if (counter == 0)
                     begin
                       read = 0;
                       enableSdrDQ = #tOH 0;
                     end
                   else
                     begin
                       column = column + 1;
                       dataOut = #tAC Memory[{row,column,bank}];
                       $display($time,
                         "ns : read: Bank=%d,Row=%d,Column=%d,Data=%d",
                         bank, row, column, dataOut);
                     end
                 end
               else if ((latency == 1) && (counter != 0))
                 begin
                   counter = counter - 1;
                   if (counter == 0)
                     begin
                       latency = 0;
                       read = 1;
                       counter = burstLength;
                       dataOut = #tAC Memory[{row,column,bank}];
                       enableSdrDQ = 1;
                       $display($time,
                         "ns : read: Bank=%d,Row=%d,Column=%d,Data=%d",
                         bank, row, column, dataOut);
                     end
                 end
             end
  endcase
                
endmodule    
              
