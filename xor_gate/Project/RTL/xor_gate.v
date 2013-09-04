/************************Copyright (c)*****************************
**                    @ Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------
** File name:           xor_gate
** Last modified Date:  2011-11-06
** Last Version:        1.0
** Descriptions:        xor_gate
**-----------------------------------------------------------------
** Created by:          dongdong
** Created date:        2011-11-06
** Version:             1.0
** Descriptions:        The xoriginal version
**
*******************************************************************/
module xor_gate ( 
//input 
input                    a        ,
input                    b        ,
//output 
output wire              y
              );

/*******************************************************************
**                       Main Program    
**  
*******************************************************************/

assign y = a ^ b;

endmodule

//end of RTL code  

