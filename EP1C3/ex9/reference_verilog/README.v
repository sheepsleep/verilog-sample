
	=============================
	========   Read Me   ========
	=============================

 File SDRSD50_071010.v is integrated verilog model 
 for (Mobile) SDRAM(64M, 128M, 256M) of Samsung.
 It is protectd using Verilog-XL(Cadence) or VCS.
 If you want to simulate verilog behavioral model 
 then set following option(+define) for products 
 in verilog command line. 

	- Density
		-64M	-   +M64	
		-128M	-   +M128
		-256M	-   +M256
	- Organization
		-X4	-   +X4
		-X8	-   +X8
		-X16	-   +X16
	- Speed
		-75	-   +S75 
		-60	-   +S60 
	- BANK
		-4BANK	-   +NBANK4 
		-2BANK	-   +NBANK2 

	- Memory allocation
		Static	-   default
		Dynamic	-   +DYMEM (to use dynamic-allocation, you must build 
				verilog-XL excutable file which contains PLI routines 
				according to below information)
	- If you want print command-echo at log file, use +v option

 ex) Product : K4S561632J, -60 (256M, x16bit, 4Banks, -60)
	If you want to simulate K4S561632J, -60
		then you have to set following command.  

	Verilog command : verilog +define+M256+X16+S60+NBANK4 SDRSD50_071010.v

 -- Power-up time of SDRAM is 200u sec. 
    So when model check power-up time, simulation time is long.   
    If you want to skip power-up time checking,
    set parameter (powerup_check) to 0; 

------------------------------------------------------------------------------
