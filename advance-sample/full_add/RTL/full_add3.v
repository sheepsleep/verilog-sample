/****************************************Copyright (c)**************************************************
**                                      Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------------------------------------------
** File name:			key_debounce
** Last modified Date:	2009-10-18
** Last Version:		1.0
** Descriptions:		key to debounce
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
module full_add( 
					//input 
					a,
					b,
					cin,
				    //output 
					sum,
					count
                    );

//input ports

input                    a;     
input                    b;    
input                    cin;

//output ports
output                   sum;
output                   count;
//reg define 

//wire define 
wire                     sum;
wire                     count;
wire                     s1;
wire                     t1;
wire                     t2;
wire                     t3;
//parameter define 


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/

assign sum = a^b^cin;

assign cout = (a&b)|(b&cin)|(cin&a);
endmodule
//end of RTL code                       