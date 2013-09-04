/* system.h
 *
 * Machine generated for a CPU named "CPU" as defined in:
 * d:\2.3\Nios\key\hello_key_0\hello_key_0_syslib\..\..\nios_ucos.ptf
 *
 * Generated: 2011-10-01 00:36:04.625
 *
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/*

DO NOT MODIFY THIS FILE

   Changing this file will have subtle consequences
   which will almost certainly lead to a nonfunctioning
   system. If you do modify this file, be aware that your
   changes will be overwritten and lost when this file
   is generated again.

DO NOT MODIFY THIS FILE

*/

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

/*
 * system configuration
 *
 */

#define ALT_SYSTEM_NAME "nios_ucos"
#define ALT_CPU_NAME "CPU"
#define ALT_CPU_ARCHITECTURE "altera_nios2"
#define ALT_DEVICE_FAMILY "CYCLONEII"
#define ALT_STDIN "/dev/null"
#define ALT_STDIN_TYPE ""
#define ALT_STDIN_BASE UNDEFINED VARIABLE %BASE_ADDRESS%
#define ALT_STDIN_DEV null
#define ALT_STDOUT "/dev/null"
#define ALT_STDOUT_TYPE ""
#define ALT_STDOUT_BASE UNDEFINED VARIABLE %BASE_ADDRESS%
#define ALT_STDOUT_DEV null
#define ALT_STDERR "/dev/null"
#define ALT_STDERR_TYPE ""
#define ALT_STDERR_BASE UNDEFINED VARIABLE %BASE_ADDRESS%
#define ALT_STDERR_DEV null
#define ALT_CPU_FREQ 50000000
#define ALT_IRQ_BASE NULL

/*
 * processor configuration
 *
 */

#define NIOS2_CPU_IMPLEMENTATION "small"
#define NIOS2_BIG_ENDIAN 0

#define NIOS2_ICACHE_SIZE 2048
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_FLUSHDA_SUPPORTED

#define NIOS2_EXCEPTION_ADDR 0x00010020
#define NIOS2_RESET_ADDR 0x00008000
#define NIOS2_BREAK_ADDR 0x00000020

#define NIOS2_HAS_DEBUG_STUB

#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0

/*
 * A define for each class of peripheral
 *
 */

#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO

/*
 * onchip_ROM configuration
 *
 */

#define ONCHIP_ROM_NAME "/dev/onchip_ROM"
#define ONCHIP_ROM_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_ROM_BASE 0x00008000
#define ONCHIP_ROM_SPAN 2048
#define ONCHIP_ROM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_ROM_RAM_BLOCK_TYPE "M4K"
#define ONCHIP_ROM_INIT_CONTENTS_FILE "onchip_ROM"
#define ONCHIP_ROM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_ROM_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_ROM_WRITEABLE 0
#define ONCHIP_ROM_DUAL_PORT 0
#define ONCHIP_ROM_SIZE_VALUE 2048
#define ONCHIP_ROM_SIZE_MULTIPLE 1
#define ONCHIP_ROM_USE_SHALLOW_MEM_BLOCKS 0
#define ONCHIP_ROM_INIT_MEM_CONTENT 1
#define ONCHIP_ROM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_ROM_INSTANCE_ID "NONE"
#define ONCHIP_ROM_IGNORE_AUTO_BLOCK_TYPE_ASSIGNMENT 1
#define ONCHIP_ROM_CONTENTS_INFO "QUARTUS_PROJECT_DIR/onchip_ROM.hex 1260080631"
#define ALT_MODULE_CLASS_onchip_ROM altera_avalon_onchip_memory2

/*
 * onchip_RAM configuration
 *
 */

#define ONCHIP_RAM_NAME "/dev/onchip_RAM"
#define ONCHIP_RAM_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_RAM_BASE 0x00010000
#define ONCHIP_RAM_SPAN 1024
#define ONCHIP_RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_RAM_RAM_BLOCK_TYPE "M4K"
#define ONCHIP_RAM_INIT_CONTENTS_FILE "onchip_RAM"
#define ONCHIP_RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_RAM_GUI_RAM_BLOCK_TYPE "Automatic"
#define ONCHIP_RAM_WRITEABLE 1
#define ONCHIP_RAM_DUAL_PORT 0
#define ONCHIP_RAM_SIZE_VALUE 1024
#define ONCHIP_RAM_SIZE_MULTIPLE 1
#define ONCHIP_RAM_USE_SHALLOW_MEM_BLOCKS 0
#define ONCHIP_RAM_INIT_MEM_CONTENT 1
#define ONCHIP_RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_RAM_INSTANCE_ID "NONE"
#define ONCHIP_RAM_IGNORE_AUTO_BLOCK_TYPE_ASSIGNMENT 1
#define ONCHIP_RAM_CONTENTS_INFO "QUARTUS_PROJECT_DIR/onchip_RAM.hex 1260080632"
#define ALT_MODULE_CLASS_onchip_RAM altera_avalon_onchip_memory2

/*
 * LED_PIO configuration
 *
 */

#define LED_PIO_NAME "/dev/LED_PIO"
#define LED_PIO_TYPE "altera_avalon_pio"
#define LED_PIO_BASE 0x00018000
#define LED_PIO_SPAN 16
#define LED_PIO_DO_TEST_BENCH_WIRING 0
#define LED_PIO_DRIVEN_SIM_VALUE 0
#define LED_PIO_HAS_TRI 0
#define LED_PIO_HAS_OUT 1
#define LED_PIO_HAS_IN 0
#define LED_PIO_CAPTURE 0
#define LED_PIO_DATA_WIDTH 8
#define LED_PIO_EDGE_TYPE "NONE"
#define LED_PIO_IRQ_TYPE "NONE"
#define LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define LED_PIO_FREQ 50000000
#define ALT_MODULE_CLASS_LED_PIO altera_avalon_pio

/*
 * KEY_PIO configuration
 *
 */

#define KEY_PIO_NAME "/dev/KEY_PIO"
#define KEY_PIO_TYPE "altera_avalon_pio"
#define KEY_PIO_BASE 0x00019000
#define KEY_PIO_SPAN 16
#define KEY_PIO_DO_TEST_BENCH_WIRING 0
#define KEY_PIO_DRIVEN_SIM_VALUE 0
#define KEY_PIO_HAS_TRI 0
#define KEY_PIO_HAS_OUT 0
#define KEY_PIO_HAS_IN 1
#define KEY_PIO_CAPTURE 0
#define KEY_PIO_DATA_WIDTH 4
#define KEY_PIO_EDGE_TYPE "NONE"
#define KEY_PIO_IRQ_TYPE "NONE"
#define KEY_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define KEY_PIO_FREQ 50000000
#define ALT_MODULE_CLASS_KEY_PIO altera_avalon_pio

/*
 * system library configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none

/*
 * Devices associated with code sections.
 *
 */

#define ALT_TEXT_DEVICE       ONCHIP_RAM
#define ALT_RODATA_DEVICE     ONCHIP_RAM
#define ALT_RWDATA_DEVICE     ONCHIP_RAM
#define ALT_EXCEPTIONS_DEVICE ONCHIP_RAM
#define ALT_RESET_DEVICE      ONCHIP_ROM


#endif /* __SYSTEM_H_ */
