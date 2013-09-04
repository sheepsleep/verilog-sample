`timescale 10 ns/ 1 ns
module divider5_5_vlg_tst();
reg sys_clk;
reg sys_rst_n;                                             
wire clkout;                        
divider5_5 i1 (
   .clkout(clkout),
   .sys_clk(sys_clk),
   .sys_rst_n(sys_rst_n)
);
initial
begin
  sys_rst_n=0;
  #3 sys_rst_n=1;
end
initial                                                
begin
sys_clk=0;
forever
begin
#2 sys_clk<=~sys_clk;                                                                      
end                                                    
                                           
end                                                    
endmodule