module longframe2(clk,strb);
parameter delay=8; 
input clk;
output strb;
reg[7:0] counter;
reg temp;
reg strb;

always@(posedge clk)  
begin
    	if(counter==255) 	counter=0;
        else 			counter=counter+1;
  	end

always@(posedge clk)
   	begin
   	strb=temp;
   	end

always@(counter)
  	begin 
     	if(counter<=(delay-1))  temp=1;
     	else  			temp=0;
	end
endmodule
