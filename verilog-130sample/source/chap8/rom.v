module ROM(addr,data,oe);
output[7:0] data;
input[14:0] addr;
input oe;

reg[7:0] mem[0:255];
parameter DELAY = 100;
assign #DELAY data=(oe==0) ? mem[addr] : 8'hzz;

initial $readmemh("rom.hex",mem);
endmodule
