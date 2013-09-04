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
module char_rom(addr, data);
  input [8:0] addr;
  output [15:0] data;
  reg [15:0] data;
  
  // A memory is implemented
  // using a case statement 
  
  always @(addr)
    begin
      case (addr)      
        9'h000 : data = 16'H0210; //
        9'h001 : data = 16'H2110; 
        9'h002 : data = 16'H1110;
        9'h003 : data = 16'H17BE;
        9'h004 : data = 16'H8220;
        9'h005 : data = 16'H4240;
        9'h006 : data = 16'H43BC;
        9'h007 : data = 16'H1284;
                                
        9'h008 : data = 16'H1288;
        9'h009 : data = 16'H2288;
        9'h00a : data = 16'HE2BE;
        9'h00b : data = 16'H2288;
        9'h00c : data = 16'H2488;
        9'h00d : data = 16'H2488;
        9'h00e : data = 16'H29A8;
        9'h00f : data = 16'H1010;

        9'h010 : data = 16'H0100; //
        9'h011 : data = 16'H0100;
        9'h012 : data = 16'H0100;
        9'h013 : data = 16'HFFFE;
        9'h014 : data = 16'H0100;
        9'h015 : data = 16'H0100;
        9'h016 : data = 16'H0100;
        9'h017 : data = 16'H3FF8;
                                
        9'h018 : data = 16'H0000;
        9'h019 : data = 16'H0100;
        9'h01a : data = 16'H0888;
        9'h01b : data = 16'H4884;
        9'h01c : data = 16'H4812;
        9'h01d : data = 16'H4812;
        9'h01e : data = 16'H87F0;
        9'h01f : data = 16'H0000; 

        9'h020 : data = 16'h0200; //
        9'h021 : data = 16'h0100;
        9'h022 : data = 16'h7FFE;
        9'h023 : data = 16'h4002;
        9'h024 : data = 16'h8004;
        9'h025 : data = 16'h3FF8;
        9'h026 : data = 16'h0100;
        9'h027 : data = 16'h0100;
                                
        9'h028 : data = 16'h0100;
        9'h029 : data = 16'hFFFE;
        9'h02a : data = 16'h0100;
        9'h02b : data = 16'h0100;
        9'h02c : data = 16'h0100;
        9'h02d : data = 16'h0100;
        9'h02e : data = 16'h0500;
        9'h02f : data = 16'h0200;

        9'h030 : data = 16'h0000; // 
        9'h031 : data = 16'h0000;
        9'h032 : data = 16'h0000;
        9'h033 : data = 16'h0000;
        9'h034 : data = 16'h0000;
        9'h035 : data = 16'h0000;
        9'h036 : data = 16'h0000;
        9'h037 : data = 16'h0000;
                            
        9'h038 : data = 16'h0000;
        9'h039 : data = 16'h0000;
        9'h03a : data = 16'h0000;
        9'h03b : data = 16'h0000;
        9'h03c : data = 16'h0000;
        9'h03d : data = 16'h0000;
        9'h03e : data = 16'h0000;
        9'h03f : data = 16'h0000;

        9'h040 : data = 16'h0000; // C
        9'h041 : data = 16'h0000;
        9'h042 : data = 16'h0000;
        9'h043 : data = 16'h03E0;
        9'h044 : data = 16'h0420;
        9'h045 : data = 16'h0420;
        9'h046 : data = 16'h0800;
        9'h047 : data = 16'h0800;

        9'h048 : data = 16'h0800;
        9'h049 : data = 16'h0800;
        9'h04a : data = 16'h0800;
        9'h04b : data = 16'h0420;
        9'h04c : data = 16'h0440;
        9'h04d : data = 16'h0380;
        9'h04e : data = 16'h0000;
        9'h04f : data = 16'h0000;

        9'h050 : data = 16'h0000; // P
        9'h051 : data = 16'h0000;
        9'h052 : data = 16'h0000;
        9'h053 : data = 16'hFC00;
        9'h054 : data = 16'h4200;
        9'h055 : data = 16'h4200;
        9'h056 : data = 16'h4200;
        9'h057 : data = 16'h4200;

        9'h058 : data = 16'h7C00;
        9'h059 : data = 16'h4000;
        9'h05a : data = 16'h4000;
        9'h05b : data = 16'h4000;
        9'h05c : data = 16'h4000;
        9'h05d : data = 16'hE000;
        9'h05e : data = 16'h0000;
        9'h05f : data = 16'h0000;

        9'h060 : data = 16'h0000; // L
        9'h061 : data = 16'h0000;
        9'h062 : data = 16'h0000;
        9'h063 : data = 16'h0E00;
        9'h064 : data = 16'h0400;
        9'h065 : data = 16'h0400;
        9'h066 : data = 16'h0400;
        9'h067 : data = 16'h0400;
            
        9'h068 : data = 16'h0400;
        9'h069 : data = 16'h0400;
        9'h06a : data = 16'h0400;
        9'h06b : data = 16'h0400;
        9'h06c : data = 16'h0420;
        9'h06d : data = 16'h0FE0;
        9'h06e : data = 16'h0000;
        9'h06f : data = 16'h0000;

        9'h070 : data = 16'h0000; // D
        9'h071 : data = 16'h0000;
        9'h072 : data = 16'h0000;
        9'h073 : data = 16'h0F80;
        9'h074 : data = 16'h0440;
        9'h075 : data = 16'h0420;
        9'h076 : data = 16'h0420;
        9'h077 : data = 16'h0420;
            
        9'h078 : data = 16'h0420;
        9'h079 : data = 16'h0420;
        9'h07a : data = 16'h0420;
        9'h07b : data = 16'h0420;
        9'h07c : data = 16'h0420;
        9'h07d : data = 16'h0440;
        9'h07e : data = 16'h0F80;
        9'h07f : data = 16'h0000;
        default: data = 16'h0000;
      endcase
    end

endmodule
