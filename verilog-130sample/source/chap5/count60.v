module count60(qout,cout,data,load,cin,reset,clk);
output[7:0] qout;
output cout;
input[7:0] data;
input load,cin,clk,reset;
reg[7:0] qout;

always @(posedge clk)
  begin
  if (reset)		qout<=0;
  else  if(load)	qout<=data;
  else  if(cin)
    begin
    if(qout[3:0]==9)
    begin
    qout[3:0]<=0;
    if (qout[7:4]==5)  qout[7:4]<=0;
    else
    qout[7:4]<=qout[7:4]+1;
    end
    else
    qout[3:0]<=qout[3:0]+1;
    end
  end

assign cout=((qout==8'h59)&cin)?1:0;
endmodule
