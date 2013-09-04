'timescale 1ns/1ns
module test1;
reg A,B,C;
initial
begin 
     A = 0; B = 1; C = 0;
#100 C = 1;
#100 A = 1; B = 0;
#100 A = 0;
#100 C = 0;
#100 $finish;
end
initial $monitor($time,,,"A=%d B=%d C=%d",A,B,C);
endmodule
