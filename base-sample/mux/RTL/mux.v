/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			mux
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		mux
**------------------------------------------------------------------------------------------------------
** Created by:		    dongdong
** Created date:		2009-10-18
** Version:				1.0
** Descriptions:		The original version
**
**------------------------------------------------------------------------------------------------------
** Modified by:			
** Modified date:		
** Version:				
** Descriptions:		
**
**------------------------------------------------------------------------------------------------------
********************************************************************************************************/

module mux (//input 
            EN ,
            IN0 ,
            IN1 ,
            IN2 ,
            IN3 ,
            SEL ,
            //output 
            OUT 
            );

//input ports
input              EN     ; 
input  [7:0]       IN0    ;
input  [7:0]       IN1    ;
input  [7:0]       IN2    ;
input  [7:0]       IN3    ;
input  [1:0]       SEL    ;

//output ports
output [7:0]       OUT    ;     

//reg define 
reg    [7:0]       OUT    ;

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

always @(SEL  or EN  or IN0  or IN1  or IN2  or IN3 ) begin
    if (EN  == 0)
       OUT  = {8{1'b0}};
	  else
		   case (SEL )
			     0 : OUT  = IN0 ;
			     1 : OUT  = IN1 ;
			     2 : OUT  = IN2 ;
			     3 : OUT  = IN3 ;
			     default : OUT  = {8{1'b0}};
		   endcase
end

endmodule
//end of RTL code                       