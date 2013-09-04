/**************************************************************************
 * Copyright (c) 2004 Altera Corporation, San Jose, California, USA.      *
 * All rights reserved. All use of this software and documentation is     *
 * subject to the License Agreement located at the end of this file below.*
 *************************************************************************/
/******************************************************************************
 *  DANGER ** WARNING ** Please read before proceeding! ** WARNING ** DANGER  *           
 ******************************************************************************
 *
 * This program is an example of a "free-standing" C application.  If you 
 * modify this example and try to call C library functions such as printf, they 
 * will NOT work unless you explicitly initialize the system, such as in the
 * hello_alt_main software template.  Please see below for details.
 *
 * Description
 * ************* 
 * A very minimal program that simply shifts an LED back and forth.
 * 
 * Requirements
 * **************
 * According to the ANSI C standard, freestanding programs "own" the hardware, 
 * and cannot rely on system-services or device-drivers being initialized prior
 * to program-start. A freestanding program is responsible for initializing all
 * hardware devices, device-drivers, and system-services. Many embedded 
 * programs are, by nature, freestanding. The author relinquishes any illusion 
 * of running their program on a workstation.
 * 
 * This example is a freestanding program because it's entry point is the 
 * function:
 * 
 *    void alt_main (void)
 * 
 * As opposed to "main()" as a "hosted" application would (see the 
 * "hello_world" example). 
 * 
 * Upon entry to alt_main():
 * - The CPU's caches (if any) have been initialized.
 * - The stack-pointer has been set.
 * - That's all. The rest is up to you.
 * 
 * If you modify this example and try to call C library functions such as 
 * printf, they will NOT  work unless you explicitly initialize the system.
 * If you wish to use C library calls, it is strongly suggested you start 
 * with the hosted hello_world template which uses main() as it's entry 
 * point.
 * 
 * On the other hand, if you want to write a program that gets-in even 
 * earlier, you will need to provide your own assembly-language machine-setup 
 * code by defining the symbol "_start". Any definition of _start in your 
 * directory will override the library definition. You can find source code 
 * for the Nios II library _start here:
 * 
 *   <NiosII-Kit-Install-Dir>/components/altera_nios2/HAL/src/crt0.S
 * 
 * This software example requires a system with a PIO peripheral named 
 * "led_pio".  The software example will run on the following hardware 
 * examples:
 * 
 * Nios Development Board, Stratix II Edition:
 * -  Standard
 * -  Small
 * -  Full Featured
 *
 * DSP Development Board, Stratix II Edition:
 * -  Standard
 * -  Small
 * -  Full Featured
 *
 * Nios Development Board, Stratix Edition:
 * -  Standard
 * -  Small
 * -  Full Featured
 * 
 * Nios Development Board, Stratix Professional Edition:
 * -  Standard
 * -  Small
 * -  Full Featured
 *
 * Nios Development Board, Cyclone Edition:
 * -  Standard
 * -  Small
 * -  Low Cost
 * -  Full Featured
 * 
 * Peripherals Exercised by SW
 * *****************************
 * The hello_led.c program simply shifts an 8-bit variable back and forth, 
 * writing the variable's value to the system's LED PIO peripheral on every 
 * iteration.
 * 
 * Software Files
 * ****************
 * hello_led.c - Main C file that contains the simple led manipulation routine.
 * 
 */
