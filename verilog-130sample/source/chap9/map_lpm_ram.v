module map_lpm_ram(dataout,datain,addr,we,inclk,outclk);
input[15:0] datain;
input[7:0] addr;
input we,inclk,outclk;
output[15:0] dataout;

lpm_ram_dq ram(.data(datain),.address(addr),.we(we),.inclock(inclk),
		.outclock(outclk),.q(dataout));
defparam ram.lpm_width=16;
defparam ram.lpm_widthad=8;
defparam ram.lpm_indata="REGISTERED";
defparam ram.lpm_outdata="REGISTERED";
defparam ram.lpm_file="map_lpm_ram.mif";
endmodule
