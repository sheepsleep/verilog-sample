/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			KeyToBeep
** Last modified Date:	2012-10-30
** Last Version:		1.0
** Descriptions:		add note for RTL code
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
module KeyToBeep( 
              //input 
              key,
              //output 
              beep
              );

//input ports
input               key;

//output ports
output              beep;

//reg define 

//wire define 
wire                key;
wire                beep;

//parameter define 

/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

// when key is pressed , key input low level, else key input high level
// so key need reverse to ctrl beep, because beep need high level for beeping 
assign beep = ~ key;              

endmodule
//end of RTL code                       