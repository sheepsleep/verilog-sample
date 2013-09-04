module decode4_7(decodeout,indec);
output[6:0] decodeout;
input[3:0] indec;
reg[6:0] decodeout;

always @(indec)
  begin
   	case(indec)
     4'd0:decodeout=7'b1111110;
     4'd1:decodeout=7'b0110000;
     4'd2:decodeout=7'b1101101;
     4'd3:decodeout=7'b1111001;
     4'd4:decodeout=7'b0110011;
     4'd5:decodeout=7'b1011011;
     4'd6:decodeout=7'b1011111;
     4'd7:decodeout=7'b1110000;
     4'd8:decodeout=7'b1111111; 
     4'd9:decodeout=7'b1111011;
     default: decodeout=7'bx;
   	endcase
  end
endmodule
