module code_83(din, dout);
input[7:0] din;
output[2:0] dout;

function[2:0] code;
input[7:0] din;
if (din[7])  		code = 3'd7;
else if (din[6]) 	code = 3'd6;
else if (din[5]) 	code = 3'd5;
else if (din[4]) 	code = 3'd4;
else if (din[3]) 	code = 3'd3;
else if (din[2]) 	code = 3'd2;
else if (din[1]) 	code = 3'd1;
else 			code = 3'd0;
endfunction

assign  dout = code(din);
endmodule
