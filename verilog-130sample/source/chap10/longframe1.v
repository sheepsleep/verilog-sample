module longframe1(clk,strb);
parameter delay=8;
input clk;
output strb;
reg strb;
reg[7:0] counter;

always@(posedge clk)
begin
    	if(counter==255)  	counter=0;
          else 			counter=counter+1;
  	end

always@(counter)
  	begin
     if(counter<=(delay-1))  	strb=1;
     else  			strb=0;
end
endmodule
