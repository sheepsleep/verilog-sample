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
					cout
                    );

//input ports

input                    a;     
input                    b;    
input                    cin;

//output ports
output                   sum;
output                   cout;
//reg define 
reg                       sum;
reg                       cout;
reg                       t1;
reg                       t2;
reg                       t3;

//wire define 

//parameter define 


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
always @ (*) begin
    sum = (a^b)^cin;
    t1 =  a&cin;
    t2 =  b&cin;
    t3 =  a&b;
    cout = t1 | t2 |t3;
end


endmodule
//end of RTL code                       