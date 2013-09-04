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

and (t1,a,cin),
    (t2,b,cin),
    (t3,a,b);

xor (s1,a,b),
    (sum,s1,cin),
    (t3,a,b);

or (cout,t1,t2,t3);

endmodule
//end of RTL code                       