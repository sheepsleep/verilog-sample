/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <system.h>
#include <altera_avalon_pio_regs.h>
#include <alt_types.h>

int alt_main(void)
{ 
  alt_u8 led = 0;
  alt_u32 i ;
  volatile alt_u32 key_state,led_state;
  
  while(1)
  {
      key_state = IORD_ALTERA_AVALON_PIO_DATA(KEY_PIO_BASE) & 0x0F;
      led_state = key_state;
      IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE,led_state);
      i = 0;
  }
  return 0;
}

