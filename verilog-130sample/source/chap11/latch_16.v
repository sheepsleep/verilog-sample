module latch_16(qo,din,load);
output[15:0] qo;
input[15:0] din;
input load;
reg[15:0] qo;

always @(posedge load)
begin  qo=din;  end

endmodule
