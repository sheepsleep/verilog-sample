module pipeline(cout,sum,ina,inb,cin,clk);
output[7:0] sum;
output cout;
input[7:0] ina,inb;
input cin,clk;
reg[7:0] tempa,tempb,sum;
reg tempci,firstco,secondco,thirdco,cout;
reg[1:0] firsts,thirda,thirdb;
reg[3:0] seconda,secondb,seconds;
reg[5:0] firsta,firstb,thirds;

always @(posedge clk)
begin
tempa=ina;  tempb=inb;  tempci=cin;
end

always @(posedge clk)
begin
{firstco,firsts}=tempa[1:0]+tempb[1:0]+tempci;
firsta=tempa[7:2];
firstb=tempb[7:2];
end

always @(posedge clk)
begin
{secondco,seconds}={firsta[1:0]+firstb[1:0]+firstco,firsts}; 
seconda=firsta[5:2];
secondb=firstb[5:2];
end

always @(posedge clk)
begin
{thirdco,thirds}={seconda[1:0]+secondb[1:0]+secondco,seconds};
thirda=seconda[3:2];
thirdb=secondb[3:2];
end

always @(posedge clk)
begin
{cout,sum}={thirda[1:0]+thirdb[1:0]+thirdco,thirds};
end
endmodule
