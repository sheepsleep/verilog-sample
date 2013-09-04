module loop3;
integer i;
initial begin
i=0;
repeat(4)
begin
$display ("i=%h",i);
i=i+1;
end
end
endmodule
