module rom(addr,data);
input[3:0] addr;
output[7:0] data;

function[7:0] romout;
input[3:0] addr;
case(addr)
0 : romout = 0;
1 : romout = 1;
2 : romout = 4;
3 : romout = 9;
4 : romout = 16;
5 : romout = 25;
6 : romout = 36;
7 : romout = 49;
8 : romout = 64;
9 : romout = 81;
10 : romout = 100;
11 : romout = 121;
12 : romout = 144;
13 : romout = 169;
14 : romout = 196;
15 : romout = 225;
default : romout = 8'hxx;
endcase
endfunction
assign data = romout(addr);
endmodule
