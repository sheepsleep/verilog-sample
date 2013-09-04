module test2;
reg clk1,clk2;
parameter CYCLE = 100;

always
begin
            {clk1,clk2} = 2'b10;
#(CYCLE/4)  {clk1,clk2} = 2'b01;
#(CYCLE/4)  {clk1,clk2} = 2'b11;
#(CYCLE/4)  {clk1,clk2} = 2'b00;
#(CYCLE/4)  {clk1,clk2} = 2'b10;
end
initial $monitor($time,,,"clk1=%b clk2=%b",clk1,clk2);
endmodule
