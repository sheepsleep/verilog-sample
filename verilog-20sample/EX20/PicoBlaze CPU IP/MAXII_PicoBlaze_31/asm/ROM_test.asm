	Constant  shifter_port,01	;declare port 
	Namereg   s7, shifter_reg		;declare register
start:  ADD      shifter_reg,80
Loop1:	Output    shifter_reg,shifter_port
	RR        shifter_reg			;rotate left
        Jump      loop1