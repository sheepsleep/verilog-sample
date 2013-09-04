module fifo(data_out,fifo_full,fifo_he,fifo_hf,fifo_empty,clk,reset,write,read,data_in);
parameter FIFO_WIDTH=8;
parameter FIFO_DEPTH=8;
parameter FIFO_PTR_WDTH=3;

output    [FIFO_WIDTH-1:0]      data_out;//The output data
output                          fifo_full;//The fifo full flag
output                          fifo_he;//The fifo half empty flag
output                          fifo_hf;//The fifo half full flag
output                          fifo_empty;//The fifo empty flag

input                           clk;//The input flag
input                           reset;//The fifo reset
input                           write;//The syncronous write strobe
input                           read;//The syncronous read strobe
input     [FIFO_WIDTH-1:0]      data_in;//The input data

reg       [FIFO_WIDTH-1:0]      fifo_ram       [0:FIFO_DEPTH-1];
reg       [FIFO_PTR_WDTH-1:0]   wr_ptr,rd_ptr;
reg       [FIFO_PTR_WDTH-1:0]   fifo_count;
wire                            fifo_full,fifo_enpty;
wire                            fifo_he,fifo_hf;
reg       [FIFO_WIDTH-1:0]      data_out;

/***************************************************************************
If this is a read get the data that is in the location pointed to by the
 tead pointer,and put it onto the output bus
****************************************************************************/
always@(posedge clk)
   if(read)
      data_out<=fifo_ram[rd_ptr];
   else if(write)
      fifo_ram[wr_ptr]=data_in;

/****************************************************************************
Increment the write pointer on every write and the read pointer on every read
*****************************************************************************/
        
always@(posedge clk)
   if(reset)
      wr_ptr<=0;
   else
      wr_ptr<=(write)?wr_ptr+1:wr_ptr;
   

always@(posedge clk)
   if(reset)
      rd_ptr<=0;
   else
      rd_ptr<=(read)?rd_ptr+1:rd_ptr;
      
/*****************************************************************************
The fifo counter increment on every write and decerment on every read .those 
code is used to provide flags to the other module,the other module check 
those flags,then know the state of fifo and decide whether write or read fifo
*****************************************************************************/

always@(posedge clk)
begin
     if(reset)
           begin
               fifo_count<=0;
           end
      else begin
            case({write,read}) 
            2'b00:fifo_count<=fifo_count; 
            2'b01:fifo_count<=(fifo_count==0)?FIFO_DEPTH:fifo_count-1;
            2'b10:fifo_count<=(fifo_count==FIFO_DEPTH)?0:fifo_count+1;
            2'b11:fifo_count<=fifo_count;
            endcase
            end
end

assign fifo_hf=(fifo_count>=4);
assign fifo_he=(fifo_count<=4);
assign fifo_empty=(fifo_count==0);
assign fifo_full=(fifo_count>=FIFO_DEPTH);

endmodule