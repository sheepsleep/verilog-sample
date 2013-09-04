module BFM (



input                   sys_clk      ,
input                   sys_rst_n    ,


input                   sys_CYC_END  ,
input                   sys_INIT_DONE,

output  reg   [23:1]    sys_A        ,
output  reg             sys_ADSn     ,
output  reg             sys_R_Wn     , 
output  reg   [15:0]    sys_D        ,
  
output     reg          sys_DLY_100US,
output     reg          sys_CLK      ,
output     reg          sys_RESET    ,

output     wire         sys_REF_REQ  
);

`include "sdr_par.v"
`define U_DLY 1

//---------------------------------------------------------------------

// PARAMETER DEFINE 

// REG DEFINE 
reg       [15:0]        delay_cnt        ;

reg       [6:0]         wr_rd_cnt        ;

reg       [6:0]         init_delay_cnt   ;

wire                    bfm_clk          ;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

// delay for sys clk is OK
always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)  
            delay_cnt <= #`U_DLY 16'h0;
        else if ( delay_cnt < 16'hffff )
            delay_cnt <= #`U_DLY delay_cnt + 16'h1;
        else ;
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
        if (sys_rst_n ==1'b0)  
            sys_DLY_100US <= #`U_DLY 1'b0;
        else if ( delay_cnt == 16'hffff )
            sys_DLY_100US <= #`U_DLY 1'b1;
        else ;
end

// SDRAM CLK GEN, SYS_CLK/2
always @(posedge sys_clk or negedge sys_rst_n) begin
        if (sys_rst_n ==1'b0) 
            sys_CLK <= #`U_DLY 1'b0;
        else
            sys_CLK <= #`U_DLY ~sys_CLK;
end

// GEN SDRAM SYS RST
always @(posedge sys_clk or negedge sys_rst_n) begin
        if (sys_rst_n == 1'b0) 
            sys_RESET <= #`U_DLY 1'b1;
        else if ( delay_cnt == 16'h00ff )
            sys_RESET <= #`U_DLY 1'b0;
        else ; 
end

assign bfm_clk = ~sys_CLK ;

// WRITE CNT 0

always @(posedge bfm_clk or negedge sys_rst_n) begin 
        if (sys_rst_n == 1'b0)  
            init_delay_cnt <= #`U_DLY 7'h0;
        else if ( sys_INIT_DONE == 1'b1 && init_delay_cnt < 127 )
            init_delay_cnt <= #`U_DLY init_delay_cnt + 7'h1;
        else ;
end

always @(posedge bfm_clk or negedge sys_rst_n) begin 
        if (sys_rst_n == 1'b0)  
            wr_rd_cnt <= #`U_DLY 7'h0;
        else if ( init_delay_cnt == 127 && wr_rd_cnt < 127 )
            wr_rd_cnt <= #`U_DLY wr_rd_cnt + 7'h1;
        else ;
end


always @(*) begin
	if ( wr_rd_cnt == 7'b0 ) begin 
	    sys_A     =          1 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =      16'h0 ;
        end
	//WR
        else if ( wr_rd_cnt == 7'b1 ) begin 
	    sys_A     =          0 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =      16'h0 ;
        end
	else if ( wr_rd_cnt >= 7'h2 && wr_rd_cnt <= 9 ) begin 
	    sys_A     =          0 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'h1234 ;
        end
	else if ( wr_rd_cnt == 10 ) begin 
	    sys_A     =        512 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'h5678 ;
	end        
	else if ( wr_rd_cnt >= 11 && wr_rd_cnt <= ( 11+7 )) begin 
	    sys_A     =        512 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'h5678 ;
        end
	else if ( wr_rd_cnt ==  ( 11+7+1 )) begin 
	    sys_A     =        1024 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'h9abc ;
	end        
	else if ( wr_rd_cnt >=  ( 11+7+1 +1) && wr_rd_cnt <= ( 11+7+1 +1+7)) begin 
	    sys_A     =        1024 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'h9abc ;
        end
	else if ( wr_rd_cnt ==  ( 11+7+1 +1+7 +1 )) begin 
	    sys_A     =       1536 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'hdef0 ;
	end        
	else if ( wr_rd_cnt >=  ( 11+7+1 +1+7 +1+1) && wr_rd_cnt <= ( 11+7+1 +1+7 +1+1+7)) begin 
	    sys_A     =       1536 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          0 ;
	    sys_D     =   16'hdef0 ;
        end
        // RD cnt =  11+7+1 +1+7 +1+1+7+1 = 37
	else if ( wr_rd_cnt == 37) begin 
	    sys_A     =          0 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
	end        
	else if ( wr_rd_cnt >=  ( 37+1 ) && wr_rd_cnt <= ( 37+1+9)) begin 
	    sys_A     =          0 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
        end        
	else if ( wr_rd_cnt == 48 ) begin 
	    sys_A     =        512 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
	end        
	else if ( wr_rd_cnt >=  (48 +1 ) && wr_rd_cnt <= (48+1+9)) begin 
	    sys_A     =        512 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
        end        
	else if ( wr_rd_cnt == 59 ) begin 
	    sys_A     =       1024 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
	end        
	else if ( wr_rd_cnt >=  ( 59 +1 ) && wr_rd_cnt <= ( 59 +1+9)) begin 
	    sys_A     =       1024 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
        end       
	else if ( wr_rd_cnt == 70 ) begin 
	    sys_A     =       1536 ;
	    sys_ADSn  =          0 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
	end        
	else if ( wr_rd_cnt >=  ( 70 +1 ) && wr_rd_cnt <= ( 70 +9)) begin 
	    sys_A     =       1536 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =          0 ;
        end       
	else begin
	    sys_A     =          0 ;
	    sys_ADSn  =          1 ;
	    sys_R_Wn  =          1 ;
	    sys_D     =      16'h0 ;
        end
end

assign  sys_REF_REQ = 0 ;

endmodule

