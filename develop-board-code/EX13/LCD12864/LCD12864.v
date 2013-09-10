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

module LCD12864 (clk, rs, rw, en,dat);  
input clk;  
 output [7:0] dat; 
 output  rs,rw,en; 
 //tri en; 
 reg e; 
 reg [7:0] dat; 
 reg rs;   
 reg  [15:0] counter; 
 reg [5:0] current,next; 
 reg clkr; 
 reg [1:0] cnt; 
 parameter  set0=6'h0; 
 parameter  set1=6'h1; 
 parameter  set2=6'h2; 
 parameter  set3=6'h3; 
 parameter  set4=6'h4; 
 parameter  set5=6'h5;
 parameter  set6=6'h6;  

 parameter  dat0=6'h7; 
 parameter  dat1=6'h8; 
 parameter  dat2=6'h9; 
 parameter  dat3=6'hA; 
 parameter  dat4=6'hB; 
 parameter  dat5=6'hC;
 parameter  dat6=6'hD; 
 parameter  dat7=6'hE; 
 parameter  dat8=6'hF; 
 parameter  dat9=6'h10;

 parameter  dat10=6'h12; 
 parameter  dat11=6'h13; 
 parameter  dat12=6'h14; 
 parameter  dat13=6'h15; 
 parameter  dat14=6'h16; 
 parameter  dat15=6'h17;
 parameter  dat16=6'h18; 
 parameter  dat17=6'h19; 
 parameter  dat18=6'h1A; 
 parameter  dat19=6'h1B; 
 parameter  dat20=6'h1C;
 parameter  dat21=6'h1D; 
 parameter  dat22=6'h1E; 
 parameter  dat23=6'h1F; 
 parameter  dat24=6'h20; 
 parameter  dat25=6'h21; 
 parameter  dat26=6'h22; 
 parameter  dat27=6'h23; 
 parameter  dat28=6'h24; 
 parameter  dat29=6'h25; 
 parameter  dat30=6'h26; 
 parameter  dat31=6'h27; 
 parameter  dat32=6'h28; 
 parameter  dat33=6'h29; 
 parameter  dat34=6'h2A; 
 parameter  dat35=6'h2B;
 parameter  dat36=6'h2C; 
 parameter  dat37=6'h2E; 
 parameter  dat38=6'h2F; 
 parameter  dat39=6'h30;
 parameter  dat40=6'h31; 
 parameter  dat41=6'h32; 
 parameter  dat42=6'h33;  
 parameter  dat43=6'h34; 
 parameter  dat44=6'h35;     
  
 parameter  nul=6'h36; 
always @(posedge clk)         //da de shi zhong pinlv 
 begin 
  counter=counter+1; 
  if(counter==16'h000f)  
  clkr=~clkr; 
end 
always @(posedge clkr) 
begin 
 current=next; 
  case(current) 
    set0:   begin  rs<=0; dat<=8'h30; next<=set1; end 
    set1:   begin  rs<=0; dat<=8'h0c; next<=set2; end 
    set2:   begin  rs<=0; dat<=8'h6; next<=set3; end 
    set3:   begin  rs<=0; dat<=8'h1; next<=dat0; end 
    dat0:   begin  rs<=1; dat<=8'h4D; next<=dat1; end //显示第一行
    dat1:   begin  rs<=1; dat<="A"; next<=dat2; end 
    dat2:   begin  rs<=1; dat<="X"; next<=dat3; end 
    dat3:   begin  rs<=1; dat<="I";next<=dat4; end 
    dat4:   begin  rs<=1; dat<="I"; next<=dat5; end 
    dat5:   begin  rs<=1; dat<="2"; next<=dat6; end 
    dat6:   begin  rs<=1; dat<="4"; next<=dat7; end 
    dat7:   begin  rs<=1; dat<="0";next<=dat8; end 
    dat8:   begin  rs<=1; dat<=" "; next<=dat9; end 
    dat9:   begin  rs<=1; dat<="S";next<= dat10 ; end 
    dat10:   begin  rs<=1; dat<="t"; next<=dat11; end 
    dat11:   begin  rs<=1; dat<="u"; next<=dat12; end 
    dat12:   begin  rs<=1; dat<="d";next<= dat13 ; end 
    dat13:   begin  rs<=1; dat<="y"; next<=set4; end 

    set4:   begin  rs<=0; dat<=8'h90; next<=dat14; end //显示第二行

    dat14:   begin  rs<=1; dat<="L"; next<=dat15; end 
    dat15:   begin  rs<=1; dat<="C";next<=dat16; end 
    dat16:   begin  rs<=1; dat<="D"; next<=dat17; end 
    dat17:   begin  rs<=1; dat<="1"; next<=dat18; end 
    dat18:   begin  rs<=1; dat<="2"; next<=dat19; end 
    dat19:   begin  rs<=1; dat<="8"; next<=dat20; end 
    dat20:   begin  rs<=1; dat<="6"; next<=dat21; end 
    dat21:   begin  rs<=1; dat<="4"; next<=dat22; end 
    dat22:   begin  rs<=1; dat<=" "; next<=dat23; end 
    dat23:   begin  rs<=1; dat<="T"; next<=dat24; end 
    dat24:   begin  rs<=1; dat<="E"; next<=dat25 ; end
    dat25:   begin  rs<=1; dat<="S"; next<=dat26; end 
    dat26:   begin  rs<=1; dat<="T"; next<=set5; end  

    set5:   begin  rs<=0; dat<=8'h88; next<=dat27; end //显示第三行

    dat27:   begin  rs<=1; dat<=8'hd3; next<=dat28; end 
    dat28:   begin  rs<=1; dat<=8'hce; next<=dat29; end 
    
    dat29:   begin  rs<=1; dat<=8'hd6; next<=dat30 ; end 
    dat30:   begin  rs<=1; dat<=8'hbe; next<=dat31; end 
    
    dat31:   begin  rs<=1; dat<=8'hd3; next<=dat32; end 
    dat32:   begin  rs<=1; dat<=8'hee; next<=dat33; end 

    dat33:   begin  rs<=1; dat<=8'hb7; next<=dat34; end 
    dat34:   begin  rs<=1; dat<=8'ha0; next<=dat35; end 

    dat35:   begin  rs<=1; dat<=8'hc9; next<=dat36;   end 
    dat36:   begin  rs<=1; dat<=8'he8; next<=dat37;   end 

    dat37:   begin  rs<=1; dat<=8'hbc; next<=dat38;   end 
    dat38:   begin  rs<=1; dat<=8'hc6; next<=set6;   end 

    set6:   begin  rs<=0; dat<=8'h9C; next<=dat39; end //显示第四行

    dat39:   begin  rs<=1; dat<="G"; next<=dat40; end 
    dat40:   begin  rs<=1; dat<="O"; next<=dat41; end 
    dat41:   begin  rs<=1; dat<="O"; next<=dat42; end 
    dat42:   begin  rs<=1; dat<="D"; next<=dat43;   end 
    dat43:   begin  rs<=1; dat<="!"; next<=dat44;   end 
    dat44:   begin  rs<=1; dat<="!"; next<=nul;   end 

     nul:   begin 
              rs<=0; 
              dat<=8'h00;                    // 把液晶的E 脚 拉高 
              if(cnt!=2'h2)  
                  begin  
                       e<=0;next<=set0;cnt<=cnt+1;  
                  end  
               else  
                     begin next<=nul; e<=1; 
                    end    
              end 
     default:   next=set0; 
    endcase 
 end 
assign en=clkr|e; 
assign rw=0; 
endmodule  