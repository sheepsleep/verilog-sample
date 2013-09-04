# generated_app.mk
#
# Machine generated for a CPU named "CPU" as defined in:
# d:\2.3\Nios\interrupt\interrupt\interrupt_syslib\..\..\nios_ucos.ptf
#
# Generated: 2011-10-24 00:40:35.671

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# assuming the Quartus project directory is the same as the PTF directory
QUARTUS_PROJECT_DIR = D:/2.3/Nios/interrupt

# the simulation directory is a subdirectory of the PTF directory
SIMDIR = $(QUARTUS_PROJECT_DIR)/nios_ucos_sim

DBL_QUOTE := "



all: delete_placeholder_warning hex sim

delete_placeholder_warning: do_delete_placeholder_warning
.PHONY: delete_placeholder_warning

hex: $(QUARTUS_PROJECT_DIR)/onchip_ROM.hex $(QUARTUS_PROJECT_DIR)/onchip_RAM.hex
.PHONY: hex

sim: $(SIMDIR)/dummy_file
.PHONY: sim

do_delete_placeholder_warning:
	rm -f $(SIMDIR)/contents_file_warning.txt
.PHONY: do_delete_placeholder_warning

$(QUARTUS_PROJECT_DIR)/onchip_ROM.hex: $(ELF)
	@echo Post-processing to create $(notdir $@)
	elf2hex $(ELF) 0x00002000 0x27FF --width=32 $(QUARTUS_PROJECT_DIR)/onchip_ROM.hex --create-lanes=0

$(QUARTUS_PROJECT_DIR)/onchip_RAM.hex: $(ELF)
	@echo Post-processing to create $(notdir $@)
	elf2hex $(ELF) 0x00002800 0x2FFF --width=32 $(QUARTUS_PROJECT_DIR)/onchip_RAM.hex --create-lanes=0

$(SIMDIR)/dummy_file: $(ELF)
	if [ ! -d $(SIMDIR) ]; then mkdir $(SIMDIR) ; fi
	@echo Hardware simulation is not enabled for the target SOPC Builder system. Skipping creation of hardware simulation model contents and simulation symbol files. \(Note: This does not affect the instruction set simulator.\)
	touch $(SIMDIR)/dummy_file


generated_app_clean:
	$(RM) $(QUARTUS_PROJECT_DIR)/onchip_ROM.hex
	$(RM) $(QUARTUS_PROJECT_DIR)/onchip_RAM.hex
	$(RM) $(SIMDIR)/dummy_file
.PHONY: generated_app_clean
