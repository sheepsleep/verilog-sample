module loop1;
integer i;
initial
for(i=0;i<4;i=i+1)
begin
$display("i=%h",i);
end
endmodule
