/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:           TB_divide
** Last modified Date:  2009-12-18
** Last Version:        1.0
** Descriptions:        TB_divide
**------------------------------------------------------------------------------------------------------
** Created by:          dongdong
** Created date:        2009-12-18
** Version:             1.0
** Descriptions:        The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/
module TB_divide;

//parameter define 
parameter WIDTH = 10;
parameter SIZE  = 8;

// input 
//input                    sys_clk              ; 
//input                    sys_rst_n            ; 

// output 

//output                   clkout              ;   

reg                      sys_clk             ; 
reg                      sys_rst_n           ;


//wire define 

wire                     data_in             ;
wire                     clkout              ;                  
                
                
                


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
initial begin
    sys_clk   = 'b0;
    sys_rst_n = 'b1;
    #23  sys_rst_n = 'b0;
    #33  sys_rst_n = 'b1;
end

always #10 sys_clk = ~ sys_clk;

divider4_5 U_DIVIDE_0 ( 
                        //input 
                       .sys_clk    (sys_clk    )  ,
                       .sys_rst_n  (sys_rst_n  )  ,
                       .data_in    (data_in    )  ,
                                  
                       //output   
                       .clkout     (clkout     )
                       );

endmodule
//end of RTL code                       
