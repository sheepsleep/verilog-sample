#!/bin/sh
#
# generated.sh - shell script fragment - not very useful on its own
#
# Machine generated for a CPU named "CPU" as defined in:
# d:\2.3\Nios\key\hello_key_0\hello_key_0_syslib\..\..\nios_ucos.ptf
#
# Generated: 2011-10-01 00:37:46.125

# DO NOT MODIFY THIS FILE
#
#   Changing this file will have subtle consequences
#   which will almost certainly lead to a nonfunctioning
#   system. If you do modify this file, be aware that your
#   changes will be overwritten and lost when this file
#   is generated again.
#
# DO NOT MODIFY THIS FILE

# This variable indicates where the PTF file for this design is located
ptf=d:\2.3\Nios\key\hello_key_0\hello_key_0_syslib\..\..\nios_ucos.ptf

# This variable indicates whether there is a CPU debug core
nios2_debug_core=yes

# This variable indicates how to connect to the CPU debug core
nios2_instance=0

# This variable indicates the CPU module name
nios2_cpu_name=CPU

# Include operating system specific parameters, if they are supplied.

if test -f /cygdrive/c/altera/72/nios2eds/components/altera_hal/build/os.sh ; then
   . /cygdrive/c/altera/72/nios2eds/components/altera_hal/build/os.sh
fi
