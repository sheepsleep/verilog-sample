//Legal Notice: (C)2007 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.


// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module CPU_jtag_debug_module_wrapper (
                                       // inputs:
                                        MonDReg,
                                        break_readreg,
                                        clk,
                                        dbrk_hit0_latch,
                                        dbrk_hit1_latch,
                                        dbrk_hit2_latch,
                                        dbrk_hit3_latch,
                                        debugack,
                                        monitor_error,
                                        monitor_ready,
                                        reset_n,
                                        resetlatch,
                                        tracemem_on,
                                        tracemem_trcdata,
                                        tracemem_tw,
                                        trc_im_addr,
                                        trc_on,
                                        trc_wrap,
                                        trigbrktype,
                                        trigger_state_1,

                                       // outputs:
                                        jdo,
                                        jrst_n,
                                        st_ready_test_idle,
                                        take_action_break_a,
                                        take_action_break_b,
                                        take_action_break_c,
                                        take_action_ocimem_a,
                                        take_action_ocimem_b,
                                        take_action_tracectrl,
                                        take_action_tracemem_a,
                                        take_action_tracemem_b,
                                        take_no_action_break_a,
                                        take_no_action_break_b,
                                        take_no_action_break_c,
                                        take_no_action_ocimem_a,
                                        take_no_action_tracemem_a
                                     )
;

  output  [ 37: 0] jdo;
  output           jrst_n;
  output           st_ready_test_idle;
  output           take_action_break_a;
  output           take_action_break_b;
  output           take_action_break_c;
  output           take_action_ocimem_a;
  output           take_action_ocimem_b;
  output           take_action_tracectrl;
  output           take_action_tracemem_a;
  output           take_action_tracemem_b;
  output           take_no_action_break_a;
  output           take_no_action_break_b;
  output           take_no_action_break_c;
  output           take_no_action_ocimem_a;
  output           take_no_action_tracemem_a;
  input   [ 31: 0] MonDReg;
  input   [ 31: 0] break_readreg;
  input            clk;
  input            dbrk_hit0_latch;
  input            dbrk_hit1_latch;
  input            dbrk_hit2_latch;
  input            dbrk_hit3_latch;
  input            debugack;
  input            monitor_error;
  input            monitor_ready;
  input            reset_n;
  input            resetlatch;
  input            tracemem_on;
  input   [ 35: 0] tracemem_trcdata;
  input            tracemem_tw;
  input   [  6: 0] trc_im_addr;
  input            trc_on;
  input            trc_wrap;
  input            trigbrktype;
  input            trigger_state_1;

  wire    [ 37: 0] jdo;
  wire             jrst_n;
  wire             st_ready_test_idle;
  wire             take_action_break_a;
  wire             take_action_break_b;
  wire             take_action_break_c;
  wire             take_action_ocimem_a;
  wire             take_action_ocimem_b;
  wire             take_action_tracectrl;
  wire             take_action_tracemem_a;
  wire             take_action_tracemem_b;
  wire             take_no_action_break_a;
  wire             take_no_action_break_b;
  wire             take_no_action_break_c;
  wire             take_no_action_ocimem_a;
  wire             take_no_action_tracemem_a;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  CPU_jtag_debug_module the_CPU_jtag_debug_module
    (
      .MonDReg                   (MonDReg),
      .break_readreg             (break_readreg),
      .clk                       (clk),
      .clrn                      (reset_n),
      .dbrk_hit0_latch           (dbrk_hit0_latch),
      .dbrk_hit1_latch           (dbrk_hit1_latch),
      .dbrk_hit2_latch           (dbrk_hit2_latch),
      .dbrk_hit3_latch           (dbrk_hit3_latch),
      .debugack                  (debugack),
      .ena                       (1'b0),
      .ir_in                     (2'b0),
      .jdo                       (jdo),
      .jrst_n                    (jrst_n),
      .jtag_state_sdr            (1'b0),
      .jtag_state_udr            (1'b0),
      .monitor_error             (monitor_error),
      .monitor_ready             (monitor_ready),
      .raw_tck                   (1'b0),
      .reset_n                   (reset_n),
      .resetlatch                (resetlatch),
      .rti                       (1'b0),
      .shift                     (1'b0),
      .st_ready_test_idle        (st_ready_test_idle),
      .take_action_break_a       (take_action_break_a),
      .take_action_break_b       (take_action_break_b),
      .take_action_break_c       (take_action_break_c),
      .take_action_ocimem_a      (take_action_ocimem_a),
      .take_action_ocimem_b      (take_action_ocimem_b),
      .take_action_tracectrl     (take_action_tracectrl),
      .take_action_tracemem_a    (take_action_tracemem_a),
      .take_action_tracemem_b    (take_action_tracemem_b),
      .take_no_action_break_a    (take_no_action_break_a),
      .take_no_action_break_b    (take_no_action_break_b),
      .take_no_action_break_c    (take_no_action_break_c),
      .take_no_action_ocimem_a   (take_no_action_ocimem_a),
      .take_no_action_tracemem_a (take_no_action_tracemem_a),
      .tdi                       (1'b0),
      .tracemem_on               (tracemem_on),
      .tracemem_trcdata          (tracemem_trcdata),
      .tracemem_tw               (tracemem_tw),
      .trc_im_addr               (trc_im_addr),
      .trc_on                    (trc_on),
      .trc_wrap                  (trc_wrap),
      .trigbrktype               (trigbrktype),
      .trigger_state_1           (trigger_state_1),
      .update                    (1'b0),
      .usr1                      (1'b0)
    );


//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
//synthesis read_comments_as_HDL on
//  CPU_jtag_debug_module the_CPU_jtag_debug_module1
//    (
//      .MonDReg                   (MonDReg),
//      .break_readreg             (break_readreg),
//      .clk                       (clk),
//      .dbrk_hit0_latch           (dbrk_hit0_latch),
//      .dbrk_hit1_latch           (dbrk_hit1_latch),
//      .dbrk_hit2_latch           (dbrk_hit2_latch),
//      .dbrk_hit3_latch           (dbrk_hit3_latch),
//      .debugack                  (debugack),
//      .jdo                       (jdo),
//      .jrst_n                    (jrst_n),
//      .monitor_error             (monitor_error),
//      .monitor_ready             (monitor_ready),
//      .reset_n                   (reset_n),
//      .resetlatch                (resetlatch),
//      .st_ready_test_idle        (st_ready_test_idle),
//      .take_action_break_a       (take_action_break_a),
//      .take_action_break_b       (take_action_break_b),
//      .take_action_break_c       (take_action_break_c),
//      .take_action_ocimem_a      (take_action_ocimem_a),
//      .take_action_ocimem_b      (take_action_ocimem_b),
//      .take_action_tracectrl     (take_action_tracectrl),
//      .take_action_tracemem_a    (take_action_tracemem_a),
//      .take_action_tracemem_b    (take_action_tracemem_b),
//      .take_no_action_break_a    (take_no_action_break_a),
//      .take_no_action_break_b    (take_no_action_break_b),
//      .take_no_action_break_c    (take_no_action_break_c),
//      .take_no_action_ocimem_a   (take_no_action_ocimem_a),
//      .take_no_action_tracemem_a (take_no_action_tracemem_a),
//      .tracemem_on               (tracemem_on),
//      .tracemem_trcdata          (tracemem_trcdata),
//      .tracemem_tw               (tracemem_tw),
//      .trc_im_addr               (trc_im_addr),
//      .trc_on                    (trc_on),
//      .trc_wrap                  (trc_wrap),
//      .trigbrktype               (trigbrktype),
//      .trigger_state_1           (trigger_state_1)
//    );
//
//synthesis read_comments_as_HDL off

endmodule

