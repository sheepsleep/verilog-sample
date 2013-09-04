//-----------------------------------------------------------------------------------
// DESCRIPTION   :   BIN to seven segments converter
//                   segment encoding
//                        a
//                      +---+ 
//                    f |   | b
//                      +---+  <- g
//                    e |   | c
//                      +---+
//                        d
//                  Enable (EN) active                : high
//                  Outputs (data_out) active         : low
// 
//-----------------------------------------------------------------------------------

module bin27seg ( data_in ,
                  EN ,
                  data_out
                 );

input [3:0]  data_in  ;
input        EN       ;

output [6:0] data_out ;

reg    [6:0] data_out ;


always @(*) begin
	data_out = 7'b1111111;
	if ( EN == 1 )
		case (data_in )
			4'b0000: data_out = 7'b1000000; // 0
			4'b0001: data_out = 7'b1111001; // 1
			4'b0010: data_out = 7'b0100100; // 2
			4'b0011: data_out = 7'b0110000; // 3
			4'b0100: data_out = 7'b0011001; // 4
			4'b0101: data_out = 7'b0010010; // 5
			4'b0110: data_out = 7'b0000011; // 6
			4'b0111: data_out = 7'b1111000; // 7
			4'b1000: data_out = 7'b0000000; // 8
			4'b1001: data_out = 7'b0011000; // 9
			4'b1010: data_out = 7'b0001000; // A
			4'b1011: data_out = 7'b0000011; // b
			4'b1100: data_out = 7'b0100111; // c
			4'b1101: data_out = 7'b0100001; // d
			4'b1110: data_out = 7'b0000110; // E
			4'b1111: data_out = 7'b0001110; // F
			default: data_out = 7'b1111111;
		endcase
end

endmodule

