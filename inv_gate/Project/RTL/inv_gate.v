/************************Copyright (c)*****************************
**                    @ Dongdong   Studio 
**                                     
**---------------------------------------File Info-----------------
** File name:           inv_gate
** Last modified Date:  2011-11-06
** Last Version:        1.0
** Descriptions:        inv_gate
**-----------------------------------------------------------------
** Created by:          dongdong
** Created date:        2011-11-06
** Version:             1.0
** Descriptions:        The original version
**
*******************************************************************/
module inv_gate ( 
//input 
input                    a        ,
//output 
output wire              y
              );

/*******************************************************************
**                       Main Program    
**  
*******************************************************************/

assign y = ~a ;

endmodule

//end of RTL code                       
