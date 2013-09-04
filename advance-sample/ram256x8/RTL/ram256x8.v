module ram256x8(data,address,we,inclock,outclock,q);
input[7:0] data;
input[7:0] address;
input we,inclock,outclock;
output[7:0] q;

lpm_ram_dq myram(.q(q),.data(data),.address(address),
  		.we(we),.inclock(inclock),.outclock(outclock));

defparam myram.lpm_width=8;
defparam myram.lpm_widthad=8;
endmodule
