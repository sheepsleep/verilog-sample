module code_83(din,dout);
input[7:0] din;
output[2:0] dout;

function[2:0] code;
input[7:0] din;
casex (din)
8'b1xxx_xxxx : code = 3'h7;
8'b01xx_xxxx : code = 3'h6;
8'b001x_xxxx : code = 3'h5;
8'b0001_xxxx : code = 3'h4;
8'b0000_1xxx : code = 3'h3;
8'b0000_01xx : code = 3'h2;
8'b0000_001x : code = 3'h1;
8'b0000_000x : code = 3'h0;
default: code = 3'hx;
endcase
endfunction

assign dout = code(din) ;
endmodule
