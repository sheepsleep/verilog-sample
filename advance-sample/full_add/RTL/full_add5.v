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

reg                       cout;
reg                       t1;
reg                       t2;
reg                       t3;

//wire define 
wire                       s1;

//parameter define 


/*******************************************************************************************************
**                              Main Program    
**  
********************************************************************************************************/
xor x1(s1,a,b);

always @ (*) begin

    t1 =  a&cin;
    t2 =  b&cin;
    t3 =  a&b;
    cout = t1 | t2 |t3;
end

assign sum = s1^cin;

endmodule
//end of RTL code                       