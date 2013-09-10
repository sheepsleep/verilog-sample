//----------------------------------------
//
// FORMULATING BAUD RATE SETTINGS
//
//
// This ROM contains BAUD rate selection parameters for
// use with the clock_gen_select block.
// The BAUD clocks which are generated are positive pulses,
// (used as clock enables,) and may be used as general clock enables
// if desired.
// Configuring the clock_gen begins with a "Fclk" MHz basic clock.
// To this is applied a prescaler (with value of dds_prescale_value,) 
// followed by a Direct Digital Synthesizer (DDS) frequency
// generator.  The DDS has an accumulator that is "dds_bits" bits wide.
// The user should know that there is some "jitter" introduced by the
// DDS, and that the amount of jitter varies depending upon the desired
// output frequency.  By increasing "dds_bits" the jitter can be made
// very small.  Also, the jitter tends to be smaller for small values of
// "dds_phase_increment"
//
// The following settings apply for these table values:
// rate_select    BAUD rate (16x this is generated)
//----------------------------------------
//     000        9600
//     001        19200
//     010        38400
//     011        57600
//     100        115200
//   (other values are available)
//
//
//
// In order to generate the parameters for a new clock
// frequency, first find the basic Fclk for your board.
// (Fclk=50.0 MHz in this example.)  
// Next, choose the lowest desired BAUD rate.
// (lowest_rate=9600 in this example.)
//
// STEP 1 : Find the ratio
//-------------------------
// First, pick a "clock_factor" for the operation of the rs232 units.
// (16 is traditional, although this hardware supports odd values as
//  well.  For instance, you could pick a clock_factor of 7, if this
//  allows you to generate BAUD rates more exactly from your particular
//  Fclk.  Try to pick the highest clock_factor that you practically can
//  since higher numbers allow the receiver to sample in the middle of
//  the received bit more exactly...  Also, don't go over 16 unless you
//  widen out the counters in the design!)
// So, for this example, let clock_factor=16.
//
// Now, find (Fclk/lowest_rate)/clock_factor = 320 (in this example).
// If this ratio is NOT an integer, then be aware that the
// BAUD rates which you will be able to produce will not be
// exact.  For asynchronous communications, the clock frequency need not
// be exact. (As mentioned in "Brute Force DDS method" below.)
// If you cannot make clocks close enough to the BAUD rates you desire,
// then you can try a different "clock_factor" setting.
// Or, alternately, you could just use the "Brute Force DDS method."
// (See below)
// 
// Or, if all else fails: get a different clock oscillator!
// If the ratio is an integer, or close to it, then proceed to step 2.
//
// Brute Force DDS method (Still step 1):
//-----------------------
// Simply increase the size of the DDS (increase "dds_bits",)
// and set the prescaler to Ndiv=1 (to pass the clock directly
// to the DDS).  Then choose your DDS phase increment values (STEP 3)
// so that you can produce rates which are as close as possible
// to "clock_factor" times the desired BAUD rates.  It might not be exact,
// but it is as close as possible.  If "dds_bits" is sufficiently large,
// then the resulting BAUD rate clocks can be _extremely_ close to the
// correct frequencies.  The Baud rate clocks actually do not need
// to be perfect, they can vary by perhaps 3 or 4 percent from their
// exact frequencies, with an increased risk of bit-errors which result,
// of course.
// 
// The formula is: dds_freq_int = (2^dds_bits)*(desired_frequency)/Fclk.
//
// STEP 2 : Find the prescaler value
//----------------------------------
// If the ratio mentioned in STEP 1 is an integer, then divide that integer
// into its prime factors.  The product of all of the prime factors which
// are not equal to 2 is a good place to start for the prescaler_value.
// If this yields too low of a clock frequency going into the DDS, then
// revert to the "Brute force DDS approach" mentioned above, or else get
// a more suitable clock oscillator!
//
// For this example: 320 = 2*2*2*2*2*2*5.  So the prescaler Ndiv = 5.
//
// If you are lucky and the prime factors are all equal to 2, then you have
// chosen an Fclk which is very agreeable to producing the BAUD clocks.  You
// can probably set Ndiv=1, which disables the prescaler from operating.
//
//
// STEP 3 : Calculate DDS phase increment values
//----------------------------------------------
// Use the following formula:
//    dds_freq_int = (2^dds_bits)*(desired_frequency)/Fclk_dds.
// The resulting values should be used with the DDS, and the values will be
// be "dds_bits-1" wide unsigned quantities.
// Remember that you can change the prescaler Ndiv value to get different
// Fclk_dds values.
//
//=========================================================================
//-----------------------------------------
// This component is a clock generator with parameters selected by an
// index into a lookup table.  There are eight possible settings.
// Recalculate the settings for your own needs as described in 
// "FORMULATING BAUD RATE SETTINGS" above.  You will need to change
// the bit width of the DDS registers, according to the `defines.

`define DDS_BITS 6
`define DDS_PRESCALE_BITS 3

`timescale 1ns/100ps
module clock_gen_select (
                         clk,
                         reset,
                         rate_select,
                         clk_out
                         );

input clk;
input reset;
input [2:0] rate_select;

output clk_out;

// Local signals
wire pulse;
wire dds_clk;

reg delayed_pulse;
reg [`DDS_PRESCALE_BITS-1:0] dds_prescale_count;
reg [`DDS_PRESCALE_BITS-1:0] dds_prescale_ndiv;
reg [`DDS_BITS-1:0] dds_phase;
reg [`DDS_BITS-2:0] dds_phase_increment;

// This part sets up the "dds_phase_increment" and "dds_prescale_ndiv" values
always @(rate_select)
begin
  case (rate_select)
    3'b000  : begin
                dds_phase_increment <=  1;  // 9600
                dds_prescale_ndiv   <=  7;
              end
              
    3'b001  : begin
                dds_phase_increment <=  2;  // 19200
                dds_prescale_ndiv   <=  5;
              end
              
    3'b010  : begin
                dds_phase_increment <=  4;  // 38400
                dds_prescale_ndiv   <=  5;
              end
              
    3'b011  : begin
                dds_phase_increment <=  6;  // 57600
                dds_prescale_ndiv   <=  5;
              end
              
    3'b100  : begin
                dds_phase_increment <= 12;  // 115200
                dds_prescale_ndiv   <=  5;
              end
              
    3'b101  : begin
                dds_phase_increment <= 12;  // 115200
                dds_prescale_ndiv   <=  5;
              end
              
    3'b110  : begin
                dds_phase_increment <= 12;  // 115200
                dds_prescale_ndiv   <=  5;
              end
              
    3'b111  : begin
                dds_phase_increment <= 12;  // 115200
                dds_prescale_ndiv   <=  5;
              end
              
    default : begin
                dds_phase_increment <= 12;  // 115200
                dds_prescale_ndiv   <=  5;
              end
  endcase 
end 


// This is the DDS prescaler part.  It has a variable divide value.
// The divide factor is "dds_prescale_ndiv" + 1.
always @(posedge clk)
begin
  if (reset) dds_prescale_count <= 0;
  else if (dds_prescale_count == (dds_prescale_ndiv-1))
    dds_prescale_count <= 0;
  else dds_prescale_count <= dds_prescale_count + 1;
end
assign dds_clk = (dds_prescale_count == (dds_prescale_ndiv-1));
// "dds_prescale_count" above could be compared to zero?...

// This is the DDS phase accumulator part
always @(posedge clk)
begin
  if (reset) dds_phase <= 0;
  else if (dds_clk) dds_phase <= dds_phase + dds_phase_increment;
end

assign pulse = dds_phase[`DDS_BITS-1];  // Simple renaming for readability
// This is "rising edge detector" part
always @(posedge clk)
begin
  delayed_pulse <= pulse;
end
assign clk_out = (pulse && ~delayed_pulse);  // Choose the rising edge

endmodule

//`undef DDS_BITS
//`undef DDS_PRESCALE_BITS


