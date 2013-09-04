`timescale 10ns/1ns
module wave1;
reg wave;
parameter cycle=10;
initial
  begin
            wave=0;
#(cycle/2)  wave=1;
#(cycle/2)  wave=0;
#(cycle/2)  wave=1;
#(cycle/2)  wave=0;
#(cycle/2)  wave=1;
#(cycle/2)  $finish ;
end
initial $monitor($time,,,"wave=%b",wave);
endmodule
