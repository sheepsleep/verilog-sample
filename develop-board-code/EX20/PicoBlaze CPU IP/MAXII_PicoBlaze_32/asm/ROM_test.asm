	Constant  shifter_port,01	;declare port 
	Namereg   s7, shifter_reg		;declare register
start:  ADD      shifter_reg,08
Loop1:	Output    shifter_reg,shifter_port
	RL        shifter_reg			;rotate left
        Jump      loop1