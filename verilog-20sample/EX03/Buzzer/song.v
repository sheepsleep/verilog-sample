////////////////////////////////////////////////////////////////////////////////
//  Company: 成都锐创智能科技 Ruichuang Smart Technology                      //
//           http://ruicstech.taobao.com                                      // 
//  Engineer:      Youzhiyu                                                   //
//  QQ      :      4016682                                                    //
//  Target Device: MAXII240T100C5N                                            //
//  Tool versions: Quartus II 7.2                                             //
//  Create Date:   2011-09-06 10:09                                           //
//  Description:                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// 	   Copyright (C) 2011-2012  Youzhiyu   All rights reserved                //
//----------------------------------------------------------------------------//
////////////////////////////////////////////////////////////////////////////////
//Spealer                用于激励扬声器的输出信号，本例为方波信号
//High ,med ,low         分别用于显示高音.中音和低音音符。


module song  (clk_6mhz, clk_4hz ,sp,high ,med,low);
  input clk_6mhz,clk_4hz;
  output sp;
  output[3:0]high,med,low;
  reg[3:0]high,med,low;
  reg[13:0]divider,origin;
  reg[7:0]counter;
  reg sp;
  wire carry;

  assign carry=(divider==16383);
  
  always @(posedge clk_6mhz)
    begin  
         if(carry)//当divider为16383时，将origin的值赋给divider
            divider=origin;
         else     
             divider=divider+1;
    end
  
  always@(posedge carry)
    begin
       sp =~sp;//随着carry值的改变而改变输出控制，也就是carry改变频率决定了输出频率
    end
    
  always@(posedge clk_4hz)
   begin
     case({high ,med ,low})//用查表方式来控制音调的预置数
     'b000000000011:   origin=7281;//origin 的值决定了divider的初始值，从而决定了carry值的改变频率
     'b000000000101:   origin=8730;
     'b000000000110:   origin=9565;
     'b000000000111:   origin=10310;
     'b000000010000:   origin=10647;
     'b000000100000:   origin=11272;
     'b000000110000:   origin=11831;
     'b000001010000:   origin=12556;
     'b000001100000:   origin=12974;
     'b000100000000:   origin=13516;
     'b000000000000:   origin=16383;
     endcase
  end
  
  
  always@(posedge clk_4hz)
     begin
       if(counter==50)      counter=0;
       else  counter=counter+1;
       case(counter)             
         0:  {high,med,low}='b000000000011;//乐曲开始
         1:  {high,med,low}='b000000000011; 
         2:  {high,med,low}='b000000000011;   
         3:  {high,med,low}='b000000000011;
         4:  {high,med,low}='b000000000101;
         5:  {high,med,low}='b000000000101;
         6:  {high,med,low}='b000000000101;
         7:  {high,med,low}='b000000000110;
         8:  {high,med,low}='b000000010000;
         9:  {high,med,low}='b000000010000;
        10:  {high,med,low}='b000000010000;
        11:  {high,med,low}='b000000100000;
        12:  {high,med,low}='b000000000110;
        13:  {high,med,low}='b000000010000;
        14:  {high,med,low}='b000000000101;
        15:  {high,med,low}='b000000000101; 
         
        16:  {high,med,low}='b000001010000; 
        17:  {high,med,low}='b000001010000;   
        18:  {high,med,low}='b000001010000;
        19:  {high,med,low}='b000100000000;
        20:  {high,med,low}='b000001100000;
        21:  {high,med,low}='b000001010000;
        22:  {high,med,low}='b000000110000;
        23:  {high,med,low}='b000001010000;
        24:  {high,med,low}='b000000100000;
        25:  {high,med,low}='b000000100000;
        26:  {high,med,low}='b000000100000;
        27:  {high,med,low}='b000000100000;
        28:  {high,med,low}='b000000100000;
        29:  {high,med,low}='b000000100000;
        30:  {high,med,low}='b000000100000;     
        31:  {high,med,low}='b000000100000; 
        
        
        32:  {high,med,low}='b000000100000;   
        33:  {high,med,low}='b000000100000;
        34:  {high,med,low}='b000000100000;
        35:  {high,med,low}='b000000110000;
        36:  {high,med,low}='b000000000111;
        37:  {high,med,low}='b000000000111;
        38:  {high,med,low}='b000000000110;
        39:  {high,med,low}='b000000000110;
        40:  {high,med,low}='b000000000101;
        41:  {high,med,low}='b000000000101;
        42:  {high,med,low}='b000000000101;
        43:  {high,med,low}='b000000000110;
        44:  {high,med,low}='b000000010000;
        45:  {high,med,low}='b000000010000;
        46:  {high,med,low}='b000000100000;
        47:  {high,med,low}='b000000100000;
   default:  {high,med,low}='d0;
 
 //后边乐曲片断此处省略
   endcase
end
endmodule        