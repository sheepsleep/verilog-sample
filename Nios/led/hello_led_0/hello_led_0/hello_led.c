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

#include "system.h"
#include "altera_avalon_pio_regs.h"
#include "alt_types.h"

  /* 
   * This is a freestanding application, so we want to use alt_main
   * as the entry point.  However, if the debugger is run on this
   * application, it will try to set a breakpoint at main, which 
   * the application does not contain.  The below line creates an
   * alias so the debugger is able to set a breakpoint at main, 
   * yet the application retains alt_main as it's entry point.
   */

int main (void) __attribute__ ((weak, alias ("alt_main")));

  /* 
   * Use alt_main as entry point for this free-standing application
   */

int alt_main (void)
{
  alt_u8 led = 0x2;
  alt_u8 dir = 0;
  volatile int i;
     
  /* 
   * Infinitely shift a variable with one bit set back and forth, and write
   * it to the LED PIO.  Software loop provides delay element.
   */
  while (1) 
  {
    if (led & 0x81) 
    {
      dir = (dir ^ 0x1);
    }

    if (dir) 
    {
      led = led >> 1;
    } 
    else 
    {
      led = led << 1;
    }
    IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, led);

    /* 
    * The delay element in this design has been written as a while loop
    * to avoid confusing the software debugger.  A tight, one line software
    * delay loop such as:
    *   for(i=0; i<200000; i++);
    * can cause problems when it is stepped through using a software debugger.
    * The while loop below produces the same behavior as the for loop shown 
    * above, but without causing potential debugger problems.  
    */
 
    i = 0;
    while (i<200000)
      i++;
  }

  return 0;
}

/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.           *
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
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
******************************************************************************/
