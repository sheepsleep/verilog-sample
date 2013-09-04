module loop2;
integer i;
initial begin
i=0;
while(i<4)
begin
$display ("i=%h",i);
i=i+1;
end
end
endmodule
