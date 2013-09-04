//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


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

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module CPU_jtag_debug_module_arbitrator (
                                          // inputs:
                                           CPU_data_master_address_to_slave,
                                           CPU_data_master_byteenable,
                                           CPU_data_master_debugaccess,
                                           CPU_data_master_read,
                                           CPU_data_master_waitrequest,
                                           CPU_data_master_write,
                                           CPU_data_master_writedata,
                                           CPU_instruction_master_address_to_slave,
                                           CPU_instruction_master_latency_counter,
                                           CPU_instruction_master_read,
                                           CPU_jtag_debug_module_readdata,
                                           CPU_jtag_debug_module_resetrequest,
                                           clk,
                                           reset_n,

                                          // outputs:
                                           CPU_data_master_granted_CPU_jtag_debug_module,
                                           CPU_data_master_qualified_request_CPU_jtag_debug_module,
                                           CPU_data_master_read_data_valid_CPU_jtag_debug_module,
                                           CPU_data_master_requests_CPU_jtag_debug_module,
                                           CPU_instruction_master_granted_CPU_jtag_debug_module,
                                           CPU_instruction_master_qualified_request_CPU_jtag_debug_module,
                                           CPU_instruction_master_read_data_valid_CPU_jtag_debug_module,
                                           CPU_instruction_master_requests_CPU_jtag_debug_module,
                                           CPU_jtag_debug_module_address,
                                           CPU_jtag_debug_module_begintransfer,
                                           CPU_jtag_debug_module_byteenable,
                                           CPU_jtag_debug_module_chipselect,
                                           CPU_jtag_debug_module_debugaccess,
                                           CPU_jtag_debug_module_readdata_from_sa,
                                           CPU_jtag_debug_module_reset,
                                           CPU_jtag_debug_module_reset_n,
                                           CPU_jtag_debug_module_resetrequest_from_sa,
                                           CPU_jtag_debug_module_write,
                                           CPU_jtag_debug_module_writedata,
                                           d1_CPU_jtag_debug_module_end_xfer
                                        )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           CPU_data_master_granted_CPU_jtag_debug_module;
  output           CPU_data_master_qualified_request_CPU_jtag_debug_module;
  output           CPU_data_master_read_data_valid_CPU_jtag_debug_module;
  output           CPU_data_master_requests_CPU_jtag_debug_module;
  output           CPU_instruction_master_granted_CPU_jtag_debug_module;
  output           CPU_instruction_master_qualified_request_CPU_jtag_debug_module;
  output           CPU_instruction_master_read_data_valid_CPU_jtag_debug_module;
  output           CPU_instruction_master_requests_CPU_jtag_debug_module;
  output  [  8: 0] CPU_jtag_debug_module_address;
  output           CPU_jtag_debug_module_begintransfer;
  output  [  3: 0] CPU_jtag_debug_module_byteenable;
  output           CPU_jtag_debug_module_chipselect;
  output           CPU_jtag_debug_module_debugaccess;
  output  [ 31: 0] CPU_jtag_debug_module_readdata_from_sa;
  output           CPU_jtag_debug_module_reset;
  output           CPU_jtag_debug_module_reset_n;
  output           CPU_jtag_debug_module_resetrequest_from_sa;
  output           CPU_jtag_debug_module_write;
  output  [ 31: 0] CPU_jtag_debug_module_writedata;
  output           d1_CPU_jtag_debug_module_end_xfer;
  input   [ 13: 0] CPU_data_master_address_to_slave;
  input   [  3: 0] CPU_data_master_byteenable;
  input            CPU_data_master_debugaccess;
  input            CPU_data_master_read;
  input            CPU_data_master_waitrequest;
  input            CPU_data_master_write;
  input   [ 31: 0] CPU_data_master_writedata;
  input   [ 13: 0] CPU_instruction_master_address_to_slave;
  input            CPU_instruction_master_latency_counter;
  input            CPU_instruction_master_read;
  input   [ 31: 0] CPU_jtag_debug_module_readdata;
  input            CPU_jtag_debug_module_resetrequest;
  input            clk;
  input            reset_n;

  wire             CPU_data_master_arbiterlock;
  wire             CPU_data_master_arbiterlock2;
  wire             CPU_data_master_continuerequest;
  wire             CPU_data_master_granted_CPU_jtag_debug_module;
  wire             CPU_data_master_qualified_request_CPU_jtag_debug_module;
  wire             CPU_data_master_read_data_valid_CPU_jtag_debug_module;
  wire             CPU_data_master_requests_CPU_jtag_debug_module;
  wire             CPU_data_master_saved_grant_CPU_jtag_debug_module;
  wire             CPU_instruction_master_arbiterlock;
  wire             CPU_instruction_master_arbiterlock2;
  wire             CPU_instruction_master_continuerequest;
  wire             CPU_instruction_master_granted_CPU_jtag_debug_module;
  wire             CPU_instruction_master_qualified_request_CPU_jtag_debug_module;
  wire             CPU_instruction_master_read_data_valid_CPU_jtag_debug_module;
  wire             CPU_instruction_master_requests_CPU_jtag_debug_module;
  wire             CPU_instruction_master_saved_grant_CPU_jtag_debug_module;
  wire    [  8: 0] CPU_jtag_debug_module_address;
  wire             CPU_jtag_debug_module_allgrants;
  wire             CPU_jtag_debug_module_allow_new_arb_cycle;
  wire             CPU_jtag_debug_module_any_bursting_master_saved_grant;
  wire             CPU_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] CPU_jtag_debug_module_arb_addend;
  wire             CPU_jtag_debug_module_arb_counter_enable;
  reg              CPU_jtag_debug_module_arb_share_counter;
  wire             CPU_jtag_debug_module_arb_share_counter_next_value;
  wire             CPU_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] CPU_jtag_debug_module_arb_winner;
  wire             CPU_jtag_debug_module_arbitration_holdoff_internal;
  wire             CPU_jtag_debug_module_beginbursttransfer_internal;
  wire             CPU_jtag_debug_module_begins_xfer;
  wire             CPU_jtag_debug_module_begintransfer;
  wire    [  3: 0] CPU_jtag_debug_module_byteenable;
  wire             CPU_jtag_debug_module_chipselect;
  wire    [  3: 0] CPU_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] CPU_jtag_debug_module_chosen_master_rot_left;
  wire             CPU_jtag_debug_module_debugaccess;
  wire             CPU_jtag_debug_module_end_xfer;
  wire             CPU_jtag_debug_module_firsttransfer;
  wire    [  1: 0] CPU_jtag_debug_module_grant_vector;
  wire             CPU_jtag_debug_module_in_a_read_cycle;
  wire             CPU_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] CPU_jtag_debug_module_master_qreq_vector;
  wire             CPU_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] CPU_jtag_debug_module_readdata_from_sa;
  reg              CPU_jtag_debug_module_reg_firsttransfer;
  wire             CPU_jtag_debug_module_reset;
  wire             CPU_jtag_debug_module_reset_n;
  wire             CPU_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] CPU_jtag_debug_module_saved_chosen_master_vector;
  reg              CPU_jtag_debug_module_slavearbiterlockenable;
  wire             CPU_jtag_debug_module_slavearbiterlockenable2;
  wire             CPU_jtag_debug_module_unreg_firsttransfer;
  wire             CPU_jtag_debug_module_waits_for_read;
  wire             CPU_jtag_debug_module_waits_for_write;
  wire             CPU_jtag_debug_module_write;
  wire    [ 31: 0] CPU_jtag_debug_module_writedata;
  reg              d1_CPU_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_CPU_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module;
  reg              last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module;
  wire    [ 13: 0] shifted_address_to_CPU_jtag_debug_module_from_CPU_data_master;
  wire    [ 13: 0] shifted_address_to_CPU_jtag_debug_module_from_CPU_instruction_master;
  wire             wait_for_CPU_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~CPU_jtag_debug_module_end_xfer;
    end


  assign CPU_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((CPU_data_master_qualified_request_CPU_jtag_debug_module | CPU_instruction_master_qualified_request_CPU_jtag_debug_module));
  //assign CPU_jtag_debug_module_readdata_from_sa = CPU_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign CPU_jtag_debug_module_readdata_from_sa = CPU_jtag_debug_module_readdata;

  assign CPU_data_master_requests_CPU_jtag_debug_module = ({CPU_data_master_address_to_slave[13 : 11] , 11'b0} == 14'h1800) & (CPU_data_master_read | CPU_data_master_write);
  //CPU_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign CPU_jtag_debug_module_arb_share_set_values = 1;

  //CPU_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign CPU_jtag_debug_module_non_bursting_master_requests = CPU_data_master_requests_CPU_jtag_debug_module |
    CPU_instruction_master_requests_CPU_jtag_debug_module |
    CPU_data_master_requests_CPU_jtag_debug_module |
    CPU_instruction_master_requests_CPU_jtag_debug_module;

  //CPU_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign CPU_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //CPU_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign CPU_jtag_debug_module_arb_share_counter_next_value = CPU_jtag_debug_module_firsttransfer ? (CPU_jtag_debug_module_arb_share_set_values - 1) : |CPU_jtag_debug_module_arb_share_counter ? (CPU_jtag_debug_module_arb_share_counter - 1) : 0;

  //CPU_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign CPU_jtag_debug_module_allgrants = |CPU_jtag_debug_module_grant_vector |
    |CPU_jtag_debug_module_grant_vector |
    |CPU_jtag_debug_module_grant_vector |
    |CPU_jtag_debug_module_grant_vector;

  //CPU_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign CPU_jtag_debug_module_end_xfer = ~(CPU_jtag_debug_module_waits_for_read | CPU_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_CPU_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_CPU_jtag_debug_module = CPU_jtag_debug_module_end_xfer & (~CPU_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //CPU_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign CPU_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_CPU_jtag_debug_module & CPU_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_CPU_jtag_debug_module & ~CPU_jtag_debug_module_non_bursting_master_requests);

  //CPU_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_jtag_debug_module_arb_share_counter <= 0;
      else if (CPU_jtag_debug_module_arb_counter_enable)
          CPU_jtag_debug_module_arb_share_counter <= CPU_jtag_debug_module_arb_share_counter_next_value;
    end


  //CPU_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|CPU_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_CPU_jtag_debug_module) | (end_xfer_arb_share_counter_term_CPU_jtag_debug_module & ~CPU_jtag_debug_module_non_bursting_master_requests))
          CPU_jtag_debug_module_slavearbiterlockenable <= |CPU_jtag_debug_module_arb_share_counter_next_value;
    end


  //CPU/data_master CPU/jtag_debug_module arbiterlock, which is an e_assign
  assign CPU_data_master_arbiterlock = CPU_jtag_debug_module_slavearbiterlockenable & CPU_data_master_continuerequest;

  //CPU_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign CPU_jtag_debug_module_slavearbiterlockenable2 = |CPU_jtag_debug_module_arb_share_counter_next_value;

  //CPU/data_master CPU/jtag_debug_module arbiterlock2, which is an e_assign
  assign CPU_data_master_arbiterlock2 = CPU_jtag_debug_module_slavearbiterlockenable2 & CPU_data_master_continuerequest;

  //CPU/instruction_master CPU/jtag_debug_module arbiterlock, which is an e_assign
  assign CPU_instruction_master_arbiterlock = CPU_jtag_debug_module_slavearbiterlockenable & CPU_instruction_master_continuerequest;

  //CPU/instruction_master CPU/jtag_debug_module arbiterlock2, which is an e_assign
  assign CPU_instruction_master_arbiterlock2 = CPU_jtag_debug_module_slavearbiterlockenable2 & CPU_instruction_master_continuerequest;

  //CPU/instruction_master granted CPU/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module <= 0;
      else if (1)
          last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module <= CPU_instruction_master_saved_grant_CPU_jtag_debug_module ? 1 : (CPU_jtag_debug_module_arbitration_holdoff_internal | ~CPU_instruction_master_requests_CPU_jtag_debug_module) ? 0 : last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module;
    end


  //CPU_instruction_master_continuerequest continued request, which is an e_mux
  assign CPU_instruction_master_continuerequest = last_cycle_CPU_instruction_master_granted_slave_CPU_jtag_debug_module & CPU_instruction_master_requests_CPU_jtag_debug_module;

  //CPU_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign CPU_jtag_debug_module_any_continuerequest = CPU_instruction_master_continuerequest |
    CPU_data_master_continuerequest;

  assign CPU_data_master_qualified_request_CPU_jtag_debug_module = CPU_data_master_requests_CPU_jtag_debug_module & ~(((~CPU_data_master_waitrequest) & CPU_data_master_write) | CPU_instruction_master_arbiterlock);
  //CPU_jtag_debug_module_writedata mux, which is an e_mux
  assign CPU_jtag_debug_module_writedata = CPU_data_master_writedata;

  //mux CPU_jtag_debug_module_debugaccess, which is an e_mux
  assign CPU_jtag_debug_module_debugaccess = CPU_data_master_debugaccess;

  assign CPU_instruction_master_requests_CPU_jtag_debug_module = (({CPU_instruction_master_address_to_slave[13 : 11] , 11'b0} == 14'h1800) & (CPU_instruction_master_read)) & CPU_instruction_master_read;
  //CPU/data_master granted CPU/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module <= 0;
      else if (1)
          last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module <= CPU_data_master_saved_grant_CPU_jtag_debug_module ? 1 : (CPU_jtag_debug_module_arbitration_holdoff_internal | ~CPU_data_master_requests_CPU_jtag_debug_module) ? 0 : last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module;
    end


  //CPU_data_master_continuerequest continued request, which is an e_mux
  assign CPU_data_master_continuerequest = last_cycle_CPU_data_master_granted_slave_CPU_jtag_debug_module & CPU_data_master_requests_CPU_jtag_debug_module;

  assign CPU_instruction_master_qualified_request_CPU_jtag_debug_module = CPU_instruction_master_requests_CPU_jtag_debug_module & ~((CPU_instruction_master_read & ((CPU_instruction_master_latency_counter != 0))) | CPU_data_master_arbiterlock);
  //local readdatavalid CPU_instruction_master_read_data_valid_CPU_jtag_debug_module, which is an e_mux
  assign CPU_instruction_master_read_data_valid_CPU_jtag_debug_module = CPU_instruction_master_granted_CPU_jtag_debug_module & CPU_instruction_master_read & ~CPU_jtag_debug_module_waits_for_read;

  //allow new arb cycle for CPU/jtag_debug_module, which is an e_assign
  assign CPU_jtag_debug_module_allow_new_arb_cycle = ~CPU_data_master_arbiterlock & ~CPU_instruction_master_arbiterlock;

  //CPU/instruction_master assignment into master qualified-requests vector for CPU/jtag_debug_module, which is an e_assign
  assign CPU_jtag_debug_module_master_qreq_vector[0] = CPU_instruction_master_qualified_request_CPU_jtag_debug_module;

  //CPU/instruction_master grant CPU/jtag_debug_module, which is an e_assign
  assign CPU_instruction_master_granted_CPU_jtag_debug_module = CPU_jtag_debug_module_grant_vector[0];

  //CPU/instruction_master saved-grant CPU/jtag_debug_module, which is an e_assign
  assign CPU_instruction_master_saved_grant_CPU_jtag_debug_module = CPU_jtag_debug_module_arb_winner[0] && CPU_instruction_master_requests_CPU_jtag_debug_module;

  //CPU/data_master assignment into master qualified-requests vector for CPU/jtag_debug_module, which is an e_assign
  assign CPU_jtag_debug_module_master_qreq_vector[1] = CPU_data_master_qualified_request_CPU_jtag_debug_module;

  //CPU/data_master grant CPU/jtag_debug_module, which is an e_assign
  assign CPU_data_master_granted_CPU_jtag_debug_module = CPU_jtag_debug_module_grant_vector[1];

  //CPU/data_master saved-grant CPU/jtag_debug_module, which is an e_assign
  assign CPU_data_master_saved_grant_CPU_jtag_debug_module = CPU_jtag_debug_module_arb_winner[1] && CPU_data_master_requests_CPU_jtag_debug_module;

  //CPU/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign CPU_jtag_debug_module_chosen_master_double_vector = {CPU_jtag_debug_module_master_qreq_vector, CPU_jtag_debug_module_master_qreq_vector} & ({~CPU_jtag_debug_module_master_qreq_vector, ~CPU_jtag_debug_module_master_qreq_vector} + CPU_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign CPU_jtag_debug_module_arb_winner = (CPU_jtag_debug_module_allow_new_arb_cycle & | CPU_jtag_debug_module_grant_vector) ? CPU_jtag_debug_module_grant_vector : CPU_jtag_debug_module_saved_chosen_master_vector;

  //saved CPU_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (CPU_jtag_debug_module_allow_new_arb_cycle)
          CPU_jtag_debug_module_saved_chosen_master_vector <= |CPU_jtag_debug_module_grant_vector ? CPU_jtag_debug_module_grant_vector : CPU_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign CPU_jtag_debug_module_grant_vector = {(CPU_jtag_debug_module_chosen_master_double_vector[1] | CPU_jtag_debug_module_chosen_master_double_vector[3]),
    (CPU_jtag_debug_module_chosen_master_double_vector[0] | CPU_jtag_debug_module_chosen_master_double_vector[2])};

  //CPU/jtag_debug_module chosen master rotated left, which is an e_assign
  assign CPU_jtag_debug_module_chosen_master_rot_left = (CPU_jtag_debug_module_arb_winner << 1) ? (CPU_jtag_debug_module_arb_winner << 1) : 1;

  //CPU/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_jtag_debug_module_arb_addend <= 1;
      else if (|CPU_jtag_debug_module_grant_vector)
          CPU_jtag_debug_module_arb_addend <= CPU_jtag_debug_module_end_xfer? CPU_jtag_debug_module_chosen_master_rot_left : CPU_jtag_debug_module_grant_vector;
    end


  assign CPU_jtag_debug_module_begintransfer = CPU_jtag_debug_module_begins_xfer;
  //assign lhs ~CPU_jtag_debug_module_reset of type reset_n to CPU_jtag_debug_module_reset_n, which is an e_assign
  assign CPU_jtag_debug_module_reset = ~CPU_jtag_debug_module_reset_n;

  //CPU_jtag_debug_module_reset_n assignment, which is an e_assign
  assign CPU_jtag_debug_module_reset_n = reset_n;

  //assign CPU_jtag_debug_module_resetrequest_from_sa = CPU_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign CPU_jtag_debug_module_resetrequest_from_sa = CPU_jtag_debug_module_resetrequest;

  assign CPU_jtag_debug_module_chipselect = CPU_data_master_granted_CPU_jtag_debug_module | CPU_instruction_master_granted_CPU_jtag_debug_module;
  //CPU_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign CPU_jtag_debug_module_firsttransfer = CPU_jtag_debug_module_begins_xfer ? CPU_jtag_debug_module_unreg_firsttransfer : CPU_jtag_debug_module_reg_firsttransfer;

  //CPU_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign CPU_jtag_debug_module_unreg_firsttransfer = ~(CPU_jtag_debug_module_slavearbiterlockenable & CPU_jtag_debug_module_any_continuerequest);

  //CPU_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (CPU_jtag_debug_module_begins_xfer)
          CPU_jtag_debug_module_reg_firsttransfer <= CPU_jtag_debug_module_unreg_firsttransfer;
    end


  //CPU_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign CPU_jtag_debug_module_beginbursttransfer_internal = CPU_jtag_debug_module_begins_xfer;

  //CPU_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign CPU_jtag_debug_module_arbitration_holdoff_internal = CPU_jtag_debug_module_begins_xfer & CPU_jtag_debug_module_firsttransfer;

  //CPU_jtag_debug_module_write assignment, which is an e_mux
  assign CPU_jtag_debug_module_write = CPU_data_master_granted_CPU_jtag_debug_module & CPU_data_master_write;

  assign shifted_address_to_CPU_jtag_debug_module_from_CPU_data_master = CPU_data_master_address_to_slave;
  //CPU_jtag_debug_module_address mux, which is an e_mux
  assign CPU_jtag_debug_module_address = (CPU_data_master_granted_CPU_jtag_debug_module)? (shifted_address_to_CPU_jtag_debug_module_from_CPU_data_master >> 2) :
    (shifted_address_to_CPU_jtag_debug_module_from_CPU_instruction_master >> 2);

  assign shifted_address_to_CPU_jtag_debug_module_from_CPU_instruction_master = CPU_instruction_master_address_to_slave;
  //d1_CPU_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_CPU_jtag_debug_module_end_xfer <= 1;
      else if (1)
          d1_CPU_jtag_debug_module_end_xfer <= CPU_jtag_debug_module_end_xfer;
    end


  //CPU_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign CPU_jtag_debug_module_waits_for_read = CPU_jtag_debug_module_in_a_read_cycle & CPU_jtag_debug_module_begins_xfer;

  //CPU_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign CPU_jtag_debug_module_in_a_read_cycle = (CPU_data_master_granted_CPU_jtag_debug_module & CPU_data_master_read) | (CPU_instruction_master_granted_CPU_jtag_debug_module & CPU_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = CPU_jtag_debug_module_in_a_read_cycle;

  //CPU_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign CPU_jtag_debug_module_waits_for_write = CPU_jtag_debug_module_in_a_write_cycle & 0;

  //CPU_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign CPU_jtag_debug_module_in_a_write_cycle = CPU_data_master_granted_CPU_jtag_debug_module & CPU_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = CPU_jtag_debug_module_in_a_write_cycle;

  assign wait_for_CPU_jtag_debug_module_counter = 0;
  //CPU_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign CPU_jtag_debug_module_byteenable = (CPU_data_master_granted_CPU_jtag_debug_module)? CPU_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //CPU/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (CPU_data_master_granted_CPU_jtag_debug_module + CPU_instruction_master_granted_CPU_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (CPU_data_master_saved_grant_CPU_jtag_debug_module + CPU_instruction_master_saved_grant_CPU_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module CPU_data_master_arbitrator (
                                    // inputs:
                                     CPU_data_master_address,
                                     CPU_data_master_debugaccess,
                                     CPU_data_master_granted_CPU_jtag_debug_module,
                                     CPU_data_master_granted_KEY_PIO_s1,
                                     CPU_data_master_granted_LED_PIO_s1,
                                     CPU_data_master_granted_onchip_RAM_s1,
                                     CPU_data_master_granted_onchip_ROM_s1,
                                     CPU_data_master_qualified_request_CPU_jtag_debug_module,
                                     CPU_data_master_qualified_request_KEY_PIO_s1,
                                     CPU_data_master_qualified_request_LED_PIO_s1,
                                     CPU_data_master_qualified_request_onchip_RAM_s1,
                                     CPU_data_master_qualified_request_onchip_ROM_s1,
                                     CPU_data_master_read,
                                     CPU_data_master_read_data_valid_CPU_jtag_debug_module,
                                     CPU_data_master_read_data_valid_KEY_PIO_s1,
                                     CPU_data_master_read_data_valid_LED_PIO_s1,
                                     CPU_data_master_read_data_valid_onchip_RAM_s1,
                                     CPU_data_master_read_data_valid_onchip_ROM_s1,
                                     CPU_data_master_requests_CPU_jtag_debug_module,
                                     CPU_data_master_requests_KEY_PIO_s1,
                                     CPU_data_master_requests_LED_PIO_s1,
                                     CPU_data_master_requests_onchip_RAM_s1,
                                     CPU_data_master_requests_onchip_ROM_s1,
                                     CPU_data_master_write,
                                     CPU_jtag_debug_module_readdata_from_sa,
                                     KEY_PIO_s1_irq_from_sa,
                                     KEY_PIO_s1_readdata_from_sa,
                                     clk,
                                     d1_CPU_jtag_debug_module_end_xfer,
                                     d1_KEY_PIO_s1_end_xfer,
                                     d1_LED_PIO_s1_end_xfer,
                                     d1_onchip_RAM_s1_end_xfer,
                                     d1_onchip_ROM_s1_end_xfer,
                                     onchip_RAM_s1_readdata_from_sa,
                                     onchip_ROM_s1_readdata_from_sa,
                                     registered_CPU_data_master_read_data_valid_onchip_RAM_s1,
                                     registered_CPU_data_master_read_data_valid_onchip_ROM_s1,
                                     reset_n,

                                    // outputs:
                                     CPU_data_master_address_to_slave,
                                     CPU_data_master_irq,
                                     CPU_data_master_readdata,
                                     CPU_data_master_waitrequest
                                  )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 13: 0] CPU_data_master_address_to_slave;
  output  [ 31: 0] CPU_data_master_irq;
  output  [ 31: 0] CPU_data_master_readdata;
  output           CPU_data_master_waitrequest;
  input   [ 13: 0] CPU_data_master_address;
  input            CPU_data_master_debugaccess;
  input            CPU_data_master_granted_CPU_jtag_debug_module;
  input            CPU_data_master_granted_KEY_PIO_s1;
  input            CPU_data_master_granted_LED_PIO_s1;
  input            CPU_data_master_granted_onchip_RAM_s1;
  input            CPU_data_master_granted_onchip_ROM_s1;
  input            CPU_data_master_qualified_request_CPU_jtag_debug_module;
  input            CPU_data_master_qualified_request_KEY_PIO_s1;
  input            CPU_data_master_qualified_request_LED_PIO_s1;
  input            CPU_data_master_qualified_request_onchip_RAM_s1;
  input            CPU_data_master_qualified_request_onchip_ROM_s1;
  input            CPU_data_master_read;
  input            CPU_data_master_read_data_valid_CPU_jtag_debug_module;
  input            CPU_data_master_read_data_valid_KEY_PIO_s1;
  input            CPU_data_master_read_data_valid_LED_PIO_s1;
  input            CPU_data_master_read_data_valid_onchip_RAM_s1;
  input            CPU_data_master_read_data_valid_onchip_ROM_s1;
  input            CPU_data_master_requests_CPU_jtag_debug_module;
  input            CPU_data_master_requests_KEY_PIO_s1;
  input            CPU_data_master_requests_LED_PIO_s1;
  input            CPU_data_master_requests_onchip_RAM_s1;
  input            CPU_data_master_requests_onchip_ROM_s1;
  input            CPU_data_master_write;
  input   [ 31: 0] CPU_jtag_debug_module_readdata_from_sa;
  input            KEY_PIO_s1_irq_from_sa;
  input   [  3: 0] KEY_PIO_s1_readdata_from_sa;
  input            clk;
  input            d1_CPU_jtag_debug_module_end_xfer;
  input            d1_KEY_PIO_s1_end_xfer;
  input            d1_LED_PIO_s1_end_xfer;
  input            d1_onchip_RAM_s1_end_xfer;
  input            d1_onchip_ROM_s1_end_xfer;
  input   [ 31: 0] onchip_RAM_s1_readdata_from_sa;
  input   [ 31: 0] onchip_ROM_s1_readdata_from_sa;
  input            registered_CPU_data_master_read_data_valid_onchip_RAM_s1;
  input            registered_CPU_data_master_read_data_valid_onchip_ROM_s1;
  input            reset_n;

  wire    [ 13: 0] CPU_data_master_address_to_slave;
  wire    [ 31: 0] CPU_data_master_irq;
  wire    [ 31: 0] CPU_data_master_readdata;
  wire             CPU_data_master_run;
  reg              CPU_data_master_waitrequest;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (CPU_data_master_qualified_request_CPU_jtag_debug_module | ~CPU_data_master_requests_CPU_jtag_debug_module) & (CPU_data_master_granted_CPU_jtag_debug_module | ~CPU_data_master_qualified_request_CPU_jtag_debug_module) & ((~CPU_data_master_qualified_request_CPU_jtag_debug_module | ~CPU_data_master_read | (1 & 1 & CPU_data_master_read))) & ((~CPU_data_master_qualified_request_CPU_jtag_debug_module | ~CPU_data_master_write | (1 & CPU_data_master_write))) & 1 & (CPU_data_master_qualified_request_KEY_PIO_s1 | ~CPU_data_master_requests_KEY_PIO_s1) & ((~CPU_data_master_qualified_request_KEY_PIO_s1 | ~CPU_data_master_read | (1 & 1 & CPU_data_master_read))) & ((~CPU_data_master_qualified_request_KEY_PIO_s1 | ~CPU_data_master_write | (1 & CPU_data_master_write))) & 1 & (CPU_data_master_qualified_request_LED_PIO_s1 | ~CPU_data_master_requests_LED_PIO_s1) & ((~CPU_data_master_qualified_request_LED_PIO_s1 | ~CPU_data_master_read | (1 & 1 & CPU_data_master_read))) & ((~CPU_data_master_qualified_request_LED_PIO_s1 | ~CPU_data_master_write | (1 & CPU_data_master_write))) & 1 & (CPU_data_master_qualified_request_onchip_RAM_s1 | registered_CPU_data_master_read_data_valid_onchip_RAM_s1 | ~CPU_data_master_requests_onchip_RAM_s1) & (CPU_data_master_granted_onchip_RAM_s1 | ~CPU_data_master_qualified_request_onchip_RAM_s1) & ((~CPU_data_master_qualified_request_onchip_RAM_s1 | ~CPU_data_master_read | (registered_CPU_data_master_read_data_valid_onchip_RAM_s1 & CPU_data_master_read))) & ((~CPU_data_master_qualified_request_onchip_RAM_s1 | ~(CPU_data_master_read | CPU_data_master_write) | (1 & (CPU_data_master_read | CPU_data_master_write)))) & 1 & (CPU_data_master_qualified_request_onchip_ROM_s1 | registered_CPU_data_master_read_data_valid_onchip_ROM_s1 | ~CPU_data_master_requests_onchip_ROM_s1);

  //cascaded wait assignment, which is an e_assign
  assign CPU_data_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = (CPU_data_master_granted_onchip_ROM_s1 | ~CPU_data_master_qualified_request_onchip_ROM_s1) & ((~CPU_data_master_qualified_request_onchip_ROM_s1 | ~CPU_data_master_read | (registered_CPU_data_master_read_data_valid_onchip_ROM_s1 & CPU_data_master_read))) & ((~CPU_data_master_qualified_request_onchip_ROM_s1 | ~(CPU_data_master_read | CPU_data_master_write) | (1 & (CPU_data_master_read | CPU_data_master_write))));

  //optimize select-logic by passing only those address bits which matter.
  assign CPU_data_master_address_to_slave = CPU_data_master_address[13 : 0];

  //CPU/data_master readdata mux, which is an e_mux
  assign CPU_data_master_readdata = ({32 {~CPU_data_master_requests_CPU_jtag_debug_module}} | CPU_jtag_debug_module_readdata_from_sa) &
    ({32 {~CPU_data_master_requests_KEY_PIO_s1}} | KEY_PIO_s1_readdata_from_sa) &
    ({32 {~CPU_data_master_requests_onchip_RAM_s1}} | onchip_RAM_s1_readdata_from_sa) &
    ({32 {~CPU_data_master_requests_onchip_ROM_s1}} | onchip_ROM_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_data_master_waitrequest <= ~0;
      else if (1)
          CPU_data_master_waitrequest <= ~((~(CPU_data_master_read | CPU_data_master_write))? 0: (CPU_data_master_run & CPU_data_master_waitrequest));
    end


  //irq assign, which is an e_assign
  assign CPU_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    KEY_PIO_s1_irq_from_sa};


endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module CPU_instruction_master_arbitrator (
                                           // inputs:
                                            CPU_instruction_master_address,
                                            CPU_instruction_master_granted_CPU_jtag_debug_module,
                                            CPU_instruction_master_granted_onchip_RAM_s1,
                                            CPU_instruction_master_granted_onchip_ROM_s1,
                                            CPU_instruction_master_qualified_request_CPU_jtag_debug_module,
                                            CPU_instruction_master_qualified_request_onchip_RAM_s1,
                                            CPU_instruction_master_qualified_request_onchip_ROM_s1,
                                            CPU_instruction_master_read,
                                            CPU_instruction_master_read_data_valid_CPU_jtag_debug_module,
                                            CPU_instruction_master_read_data_valid_onchip_RAM_s1,
                                            CPU_instruction_master_read_data_valid_onchip_ROM_s1,
                                            CPU_instruction_master_requests_CPU_jtag_debug_module,
                                            CPU_instruction_master_requests_onchip_RAM_s1,
                                            CPU_instruction_master_requests_onchip_ROM_s1,
                                            CPU_jtag_debug_module_readdata_from_sa,
                                            clk,
                                            d1_CPU_jtag_debug_module_end_xfer,
                                            d1_onchip_RAM_s1_end_xfer,
                                            d1_onchip_ROM_s1_end_xfer,
                                            onchip_RAM_s1_readdata_from_sa,
                                            onchip_ROM_s1_readdata_from_sa,
                                            reset_n,

                                           // outputs:
                                            CPU_instruction_master_address_to_slave,
                                            CPU_instruction_master_latency_counter,
                                            CPU_instruction_master_readdata,
                                            CPU_instruction_master_readdatavalid,
                                            CPU_instruction_master_waitrequest
                                         )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output  [ 13: 0] CPU_instruction_master_address_to_slave;
  output           CPU_instruction_master_latency_counter;
  output  [ 31: 0] CPU_instruction_master_readdata;
  output           CPU_instruction_master_readdatavalid;
  output           CPU_instruction_master_waitrequest;
  input   [ 13: 0] CPU_instruction_master_address;
  input            CPU_instruction_master_granted_CPU_jtag_debug_module;
  input            CPU_instruction_master_granted_onchip_RAM_s1;
  input            CPU_instruction_master_granted_onchip_ROM_s1;
  input            CPU_instruction_master_qualified_request_CPU_jtag_debug_module;
  input            CPU_instruction_master_qualified_request_onchip_RAM_s1;
  input            CPU_instruction_master_qualified_request_onchip_ROM_s1;
  input            CPU_instruction_master_read;
  input            CPU_instruction_master_read_data_valid_CPU_jtag_debug_module;
  input            CPU_instruction_master_read_data_valid_onchip_RAM_s1;
  input            CPU_instruction_master_read_data_valid_onchip_ROM_s1;
  input            CPU_instruction_master_requests_CPU_jtag_debug_module;
  input            CPU_instruction_master_requests_onchip_RAM_s1;
  input            CPU_instruction_master_requests_onchip_ROM_s1;
  input   [ 31: 0] CPU_jtag_debug_module_readdata_from_sa;
  input            clk;
  input            d1_CPU_jtag_debug_module_end_xfer;
  input            d1_onchip_RAM_s1_end_xfer;
  input            d1_onchip_ROM_s1_end_xfer;
  input   [ 31: 0] onchip_RAM_s1_readdata_from_sa;
  input   [ 31: 0] onchip_ROM_s1_readdata_from_sa;
  input            reset_n;

  reg     [ 13: 0] CPU_instruction_master_address_last_time;
  wire    [ 13: 0] CPU_instruction_master_address_to_slave;
  wire             CPU_instruction_master_is_granted_some_slave;
  reg              CPU_instruction_master_latency_counter;
  reg              CPU_instruction_master_read_but_no_slave_selected;
  reg              CPU_instruction_master_read_last_time;
  wire    [ 31: 0] CPU_instruction_master_readdata;
  wire             CPU_instruction_master_readdatavalid;
  wire             CPU_instruction_master_run;
  wire             CPU_instruction_master_waitrequest;
  reg              active_and_waiting_last_time;
  wire             latency_load_value;
  wire             p1_CPU_instruction_master_latency_counter;
  wire             pre_flush_CPU_instruction_master_readdatavalid;
  wire             r_0;
  wire             r_1;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (CPU_instruction_master_qualified_request_CPU_jtag_debug_module | ~CPU_instruction_master_requests_CPU_jtag_debug_module) & (CPU_instruction_master_granted_CPU_jtag_debug_module | ~CPU_instruction_master_qualified_request_CPU_jtag_debug_module) & ((~CPU_instruction_master_qualified_request_CPU_jtag_debug_module | ~CPU_instruction_master_read | (1 & ~d1_CPU_jtag_debug_module_end_xfer & CPU_instruction_master_read))) & 1 & (CPU_instruction_master_qualified_request_onchip_RAM_s1 | ~CPU_instruction_master_requests_onchip_RAM_s1) & (CPU_instruction_master_granted_onchip_RAM_s1 | ~CPU_instruction_master_qualified_request_onchip_RAM_s1) & ((~CPU_instruction_master_qualified_request_onchip_RAM_s1 | ~CPU_instruction_master_read | (1 & CPU_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign CPU_instruction_master_run = r_0 & r_1;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = 1 & (CPU_instruction_master_qualified_request_onchip_ROM_s1 | ~CPU_instruction_master_requests_onchip_ROM_s1) & (CPU_instruction_master_granted_onchip_ROM_s1 | ~CPU_instruction_master_qualified_request_onchip_ROM_s1) & ((~CPU_instruction_master_qualified_request_onchip_ROM_s1 | ~CPU_instruction_master_read | (1 & CPU_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign CPU_instruction_master_address_to_slave = CPU_instruction_master_address[13 : 0];

  //CPU_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_instruction_master_read_but_no_slave_selected <= 0;
      else if (1)
          CPU_instruction_master_read_but_no_slave_selected <= CPU_instruction_master_read & CPU_instruction_master_run & ~CPU_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign CPU_instruction_master_is_granted_some_slave = CPU_instruction_master_granted_CPU_jtag_debug_module |
    CPU_instruction_master_granted_onchip_RAM_s1 |
    CPU_instruction_master_granted_onchip_ROM_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_CPU_instruction_master_readdatavalid = CPU_instruction_master_read_data_valid_onchip_RAM_s1 |
    CPU_instruction_master_read_data_valid_onchip_ROM_s1;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign CPU_instruction_master_readdatavalid = CPU_instruction_master_read_but_no_slave_selected |
    pre_flush_CPU_instruction_master_readdatavalid |
    CPU_instruction_master_read_data_valid_CPU_jtag_debug_module |
    CPU_instruction_master_read_but_no_slave_selected |
    pre_flush_CPU_instruction_master_readdatavalid |
    CPU_instruction_master_read_but_no_slave_selected |
    pre_flush_CPU_instruction_master_readdatavalid;

  //CPU/instruction_master readdata mux, which is an e_mux
  assign CPU_instruction_master_readdata = ({32 {~(CPU_instruction_master_qualified_request_CPU_jtag_debug_module & CPU_instruction_master_read)}} | CPU_jtag_debug_module_readdata_from_sa) &
    ({32 {~CPU_instruction_master_read_data_valid_onchip_RAM_s1}} | onchip_RAM_s1_readdata_from_sa) &
    ({32 {~CPU_instruction_master_read_data_valid_onchip_ROM_s1}} | onchip_ROM_s1_readdata_from_sa);

  //actual waitrequest port, which is an e_assign
  assign CPU_instruction_master_waitrequest = ~CPU_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_instruction_master_latency_counter <= 0;
      else if (1)
          CPU_instruction_master_latency_counter <= p1_CPU_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_CPU_instruction_master_latency_counter = ((CPU_instruction_master_run & CPU_instruction_master_read))? latency_load_value :
    (CPU_instruction_master_latency_counter)? CPU_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = ({1 {CPU_instruction_master_requests_onchip_RAM_s1}} & 1) |
    ({1 {CPU_instruction_master_requests_onchip_ROM_s1}} & 1);


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //CPU_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_instruction_master_address_last_time <= 0;
      else if (1)
          CPU_instruction_master_address_last_time <= CPU_instruction_master_address;
    end


  //CPU/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else if (1)
          active_and_waiting_last_time <= CPU_instruction_master_waitrequest & (CPU_instruction_master_read);
    end


  //CPU_instruction_master_address matches last port_name, which is an e_process
  always @(CPU_instruction_master_address or CPU_instruction_master_address_last_time or active_and_waiting_last_time)
    begin
      if (active_and_waiting_last_time & (CPU_instruction_master_address != CPU_instruction_master_address_last_time))
        begin
          $write("%0d ns: CPU_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //CPU_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_instruction_master_read_last_time <= 0;
      else if (1)
          CPU_instruction_master_read_last_time <= CPU_instruction_master_read;
    end


  //CPU_instruction_master_read matches last port_name, which is an e_process
  always @(CPU_instruction_master_read or CPU_instruction_master_read_last_time or active_and_waiting_last_time)
    begin
      if (active_and_waiting_last_time & (CPU_instruction_master_read != CPU_instruction_master_read_last_time))
        begin
          $write("%0d ns: CPU_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module KEY_PIO_s1_arbitrator (
                               // inputs:
                                CPU_data_master_address_to_slave,
                                CPU_data_master_read,
                                CPU_data_master_waitrequest,
                                CPU_data_master_write,
                                CPU_data_master_writedata,
                                KEY_PIO_s1_irq,
                                KEY_PIO_s1_readdata,
                                clk,
                                reset_n,

                               // outputs:
                                CPU_data_master_granted_KEY_PIO_s1,
                                CPU_data_master_qualified_request_KEY_PIO_s1,
                                CPU_data_master_read_data_valid_KEY_PIO_s1,
                                CPU_data_master_requests_KEY_PIO_s1,
                                KEY_PIO_s1_address,
                                KEY_PIO_s1_chipselect,
                                KEY_PIO_s1_irq_from_sa,
                                KEY_PIO_s1_readdata_from_sa,
                                KEY_PIO_s1_reset_n,
                                KEY_PIO_s1_write_n,
                                KEY_PIO_s1_writedata,
                                d1_KEY_PIO_s1_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           CPU_data_master_granted_KEY_PIO_s1;
  output           CPU_data_master_qualified_request_KEY_PIO_s1;
  output           CPU_data_master_read_data_valid_KEY_PIO_s1;
  output           CPU_data_master_requests_KEY_PIO_s1;
  output  [  1: 0] KEY_PIO_s1_address;
  output           KEY_PIO_s1_chipselect;
  output           KEY_PIO_s1_irq_from_sa;
  output  [  3: 0] KEY_PIO_s1_readdata_from_sa;
  output           KEY_PIO_s1_reset_n;
  output           KEY_PIO_s1_write_n;
  output  [  3: 0] KEY_PIO_s1_writedata;
  output           d1_KEY_PIO_s1_end_xfer;
  input   [ 13: 0] CPU_data_master_address_to_slave;
  input            CPU_data_master_read;
  input            CPU_data_master_waitrequest;
  input            CPU_data_master_write;
  input   [ 31: 0] CPU_data_master_writedata;
  input            KEY_PIO_s1_irq;
  input   [  3: 0] KEY_PIO_s1_readdata;
  input            clk;
  input            reset_n;

  wire             CPU_data_master_arbiterlock;
  wire             CPU_data_master_arbiterlock2;
  wire             CPU_data_master_continuerequest;
  wire             CPU_data_master_granted_KEY_PIO_s1;
  wire             CPU_data_master_qualified_request_KEY_PIO_s1;
  wire             CPU_data_master_read_data_valid_KEY_PIO_s1;
  wire             CPU_data_master_requests_KEY_PIO_s1;
  wire             CPU_data_master_saved_grant_KEY_PIO_s1;
  wire    [  1: 0] KEY_PIO_s1_address;
  wire             KEY_PIO_s1_allgrants;
  wire             KEY_PIO_s1_allow_new_arb_cycle;
  wire             KEY_PIO_s1_any_bursting_master_saved_grant;
  wire             KEY_PIO_s1_any_continuerequest;
  wire             KEY_PIO_s1_arb_counter_enable;
  reg              KEY_PIO_s1_arb_share_counter;
  wire             KEY_PIO_s1_arb_share_counter_next_value;
  wire             KEY_PIO_s1_arb_share_set_values;
  wire             KEY_PIO_s1_beginbursttransfer_internal;
  wire             KEY_PIO_s1_begins_xfer;
  wire             KEY_PIO_s1_chipselect;
  wire             KEY_PIO_s1_end_xfer;
  wire             KEY_PIO_s1_firsttransfer;
  wire             KEY_PIO_s1_grant_vector;
  wire             KEY_PIO_s1_in_a_read_cycle;
  wire             KEY_PIO_s1_in_a_write_cycle;
  wire             KEY_PIO_s1_irq_from_sa;
  wire             KEY_PIO_s1_master_qreq_vector;
  wire             KEY_PIO_s1_non_bursting_master_requests;
  wire    [  3: 0] KEY_PIO_s1_readdata_from_sa;
  reg              KEY_PIO_s1_reg_firsttransfer;
  wire             KEY_PIO_s1_reset_n;
  reg              KEY_PIO_s1_slavearbiterlockenable;
  wire             KEY_PIO_s1_slavearbiterlockenable2;
  wire             KEY_PIO_s1_unreg_firsttransfer;
  wire             KEY_PIO_s1_waits_for_read;
  wire             KEY_PIO_s1_waits_for_write;
  wire             KEY_PIO_s1_write_n;
  wire    [  3: 0] KEY_PIO_s1_writedata;
  reg              d1_KEY_PIO_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_KEY_PIO_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 13: 0] shifted_address_to_KEY_PIO_s1_from_CPU_data_master;
  wire             wait_for_KEY_PIO_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~KEY_PIO_s1_end_xfer;
    end


  assign KEY_PIO_s1_begins_xfer = ~d1_reasons_to_wait & ((CPU_data_master_qualified_request_KEY_PIO_s1));
  //assign KEY_PIO_s1_readdata_from_sa = KEY_PIO_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY_PIO_s1_readdata_from_sa = KEY_PIO_s1_readdata;

  assign CPU_data_master_requests_KEY_PIO_s1 = ({CPU_data_master_address_to_slave[13 : 4] , 4'b0} == 14'h3010) & (CPU_data_master_read | CPU_data_master_write);
  //KEY_PIO_s1_arb_share_counter set values, which is an e_mux
  assign KEY_PIO_s1_arb_share_set_values = 1;

  //KEY_PIO_s1_non_bursting_master_requests mux, which is an e_mux
  assign KEY_PIO_s1_non_bursting_master_requests = CPU_data_master_requests_KEY_PIO_s1;

  //KEY_PIO_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign KEY_PIO_s1_any_bursting_master_saved_grant = 0;

  //KEY_PIO_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign KEY_PIO_s1_arb_share_counter_next_value = KEY_PIO_s1_firsttransfer ? (KEY_PIO_s1_arb_share_set_values - 1) : |KEY_PIO_s1_arb_share_counter ? (KEY_PIO_s1_arb_share_counter - 1) : 0;

  //KEY_PIO_s1_allgrants all slave grants, which is an e_mux
  assign KEY_PIO_s1_allgrants = |KEY_PIO_s1_grant_vector;

  //KEY_PIO_s1_end_xfer assignment, which is an e_assign
  assign KEY_PIO_s1_end_xfer = ~(KEY_PIO_s1_waits_for_read | KEY_PIO_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_KEY_PIO_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_KEY_PIO_s1 = KEY_PIO_s1_end_xfer & (~KEY_PIO_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //KEY_PIO_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign KEY_PIO_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_KEY_PIO_s1 & KEY_PIO_s1_allgrants) | (end_xfer_arb_share_counter_term_KEY_PIO_s1 & ~KEY_PIO_s1_non_bursting_master_requests);

  //KEY_PIO_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY_PIO_s1_arb_share_counter <= 0;
      else if (KEY_PIO_s1_arb_counter_enable)
          KEY_PIO_s1_arb_share_counter <= KEY_PIO_s1_arb_share_counter_next_value;
    end


  //KEY_PIO_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY_PIO_s1_slavearbiterlockenable <= 0;
      else if ((|KEY_PIO_s1_master_qreq_vector & end_xfer_arb_share_counter_term_KEY_PIO_s1) | (end_xfer_arb_share_counter_term_KEY_PIO_s1 & ~KEY_PIO_s1_non_bursting_master_requests))
          KEY_PIO_s1_slavearbiterlockenable <= |KEY_PIO_s1_arb_share_counter_next_value;
    end


  //CPU/data_master KEY_PIO/s1 arbiterlock, which is an e_assign
  assign CPU_data_master_arbiterlock = KEY_PIO_s1_slavearbiterlockenable & CPU_data_master_continuerequest;

  //KEY_PIO_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign KEY_PIO_s1_slavearbiterlockenable2 = |KEY_PIO_s1_arb_share_counter_next_value;

  //CPU/data_master KEY_PIO/s1 arbiterlock2, which is an e_assign
  assign CPU_data_master_arbiterlock2 = KEY_PIO_s1_slavearbiterlockenable2 & CPU_data_master_continuerequest;

  //KEY_PIO_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign KEY_PIO_s1_any_continuerequest = 1;

  //CPU_data_master_continuerequest continued request, which is an e_assign
  assign CPU_data_master_continuerequest = 1;

  assign CPU_data_master_qualified_request_KEY_PIO_s1 = CPU_data_master_requests_KEY_PIO_s1 & ~(((~CPU_data_master_waitrequest) & CPU_data_master_write));
  //KEY_PIO_s1_writedata mux, which is an e_mux
  assign KEY_PIO_s1_writedata = CPU_data_master_writedata;

  //master is always granted when requested
  assign CPU_data_master_granted_KEY_PIO_s1 = CPU_data_master_qualified_request_KEY_PIO_s1;

  //CPU/data_master saved-grant KEY_PIO/s1, which is an e_assign
  assign CPU_data_master_saved_grant_KEY_PIO_s1 = CPU_data_master_requests_KEY_PIO_s1;

  //allow new arb cycle for KEY_PIO/s1, which is an e_assign
  assign KEY_PIO_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign KEY_PIO_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign KEY_PIO_s1_master_qreq_vector = 1;

  //KEY_PIO_s1_reset_n assignment, which is an e_assign
  assign KEY_PIO_s1_reset_n = reset_n;

  assign KEY_PIO_s1_chipselect = CPU_data_master_granted_KEY_PIO_s1;
  //KEY_PIO_s1_firsttransfer first transaction, which is an e_assign
  assign KEY_PIO_s1_firsttransfer = KEY_PIO_s1_begins_xfer ? KEY_PIO_s1_unreg_firsttransfer : KEY_PIO_s1_reg_firsttransfer;

  //KEY_PIO_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign KEY_PIO_s1_unreg_firsttransfer = ~(KEY_PIO_s1_slavearbiterlockenable & KEY_PIO_s1_any_continuerequest);

  //KEY_PIO_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          KEY_PIO_s1_reg_firsttransfer <= 1'b1;
      else if (KEY_PIO_s1_begins_xfer)
          KEY_PIO_s1_reg_firsttransfer <= KEY_PIO_s1_unreg_firsttransfer;
    end


  //KEY_PIO_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign KEY_PIO_s1_beginbursttransfer_internal = KEY_PIO_s1_begins_xfer;

  //~KEY_PIO_s1_write_n assignment, which is an e_mux
  assign KEY_PIO_s1_write_n = ~(CPU_data_master_granted_KEY_PIO_s1 & CPU_data_master_write);

  assign shifted_address_to_KEY_PIO_s1_from_CPU_data_master = CPU_data_master_address_to_slave;
  //KEY_PIO_s1_address mux, which is an e_mux
  assign KEY_PIO_s1_address = shifted_address_to_KEY_PIO_s1_from_CPU_data_master >> 2;

  //d1_KEY_PIO_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_KEY_PIO_s1_end_xfer <= 1;
      else if (1)
          d1_KEY_PIO_s1_end_xfer <= KEY_PIO_s1_end_xfer;
    end


  //KEY_PIO_s1_waits_for_read in a cycle, which is an e_mux
  assign KEY_PIO_s1_waits_for_read = KEY_PIO_s1_in_a_read_cycle & KEY_PIO_s1_begins_xfer;

  //KEY_PIO_s1_in_a_read_cycle assignment, which is an e_assign
  assign KEY_PIO_s1_in_a_read_cycle = CPU_data_master_granted_KEY_PIO_s1 & CPU_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = KEY_PIO_s1_in_a_read_cycle;

  //KEY_PIO_s1_waits_for_write in a cycle, which is an e_mux
  assign KEY_PIO_s1_waits_for_write = KEY_PIO_s1_in_a_write_cycle & 0;

  //KEY_PIO_s1_in_a_write_cycle assignment, which is an e_assign
  assign KEY_PIO_s1_in_a_write_cycle = CPU_data_master_granted_KEY_PIO_s1 & CPU_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = KEY_PIO_s1_in_a_write_cycle;

  assign wait_for_KEY_PIO_s1_counter = 0;
  //assign KEY_PIO_s1_irq_from_sa = KEY_PIO_s1_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign KEY_PIO_s1_irq_from_sa = KEY_PIO_s1_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //KEY_PIO/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module LED_PIO_s1_arbitrator (
                               // inputs:
                                CPU_data_master_address_to_slave,
                                CPU_data_master_byteenable,
                                CPU_data_master_read,
                                CPU_data_master_waitrequest,
                                CPU_data_master_write,
                                CPU_data_master_writedata,
                                clk,
                                reset_n,

                               // outputs:
                                CPU_data_master_granted_LED_PIO_s1,
                                CPU_data_master_qualified_request_LED_PIO_s1,
                                CPU_data_master_read_data_valid_LED_PIO_s1,
                                CPU_data_master_requests_LED_PIO_s1,
                                LED_PIO_s1_address,
                                LED_PIO_s1_chipselect,
                                LED_PIO_s1_reset_n,
                                LED_PIO_s1_write_n,
                                LED_PIO_s1_writedata,
                                d1_LED_PIO_s1_end_xfer
                             )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           CPU_data_master_granted_LED_PIO_s1;
  output           CPU_data_master_qualified_request_LED_PIO_s1;
  output           CPU_data_master_read_data_valid_LED_PIO_s1;
  output           CPU_data_master_requests_LED_PIO_s1;
  output  [  1: 0] LED_PIO_s1_address;
  output           LED_PIO_s1_chipselect;
  output           LED_PIO_s1_reset_n;
  output           LED_PIO_s1_write_n;
  output  [  7: 0] LED_PIO_s1_writedata;
  output           d1_LED_PIO_s1_end_xfer;
  input   [ 13: 0] CPU_data_master_address_to_slave;
  input   [  3: 0] CPU_data_master_byteenable;
  input            CPU_data_master_read;
  input            CPU_data_master_waitrequest;
  input            CPU_data_master_write;
  input   [ 31: 0] CPU_data_master_writedata;
  input            clk;
  input            reset_n;

  wire             CPU_data_master_arbiterlock;
  wire             CPU_data_master_arbiterlock2;
  wire             CPU_data_master_continuerequest;
  wire             CPU_data_master_granted_LED_PIO_s1;
  wire             CPU_data_master_qualified_request_LED_PIO_s1;
  wire             CPU_data_master_read_data_valid_LED_PIO_s1;
  wire             CPU_data_master_requests_LED_PIO_s1;
  wire             CPU_data_master_saved_grant_LED_PIO_s1;
  wire    [  1: 0] LED_PIO_s1_address;
  wire             LED_PIO_s1_allgrants;
  wire             LED_PIO_s1_allow_new_arb_cycle;
  wire             LED_PIO_s1_any_bursting_master_saved_grant;
  wire             LED_PIO_s1_any_continuerequest;
  wire             LED_PIO_s1_arb_counter_enable;
  reg              LED_PIO_s1_arb_share_counter;
  wire             LED_PIO_s1_arb_share_counter_next_value;
  wire             LED_PIO_s1_arb_share_set_values;
  wire             LED_PIO_s1_beginbursttransfer_internal;
  wire             LED_PIO_s1_begins_xfer;
  wire             LED_PIO_s1_chipselect;
  wire             LED_PIO_s1_end_xfer;
  wire             LED_PIO_s1_firsttransfer;
  wire             LED_PIO_s1_grant_vector;
  wire             LED_PIO_s1_in_a_read_cycle;
  wire             LED_PIO_s1_in_a_write_cycle;
  wire             LED_PIO_s1_master_qreq_vector;
  wire             LED_PIO_s1_non_bursting_master_requests;
  wire             LED_PIO_s1_pretend_byte_enable;
  reg              LED_PIO_s1_reg_firsttransfer;
  wire             LED_PIO_s1_reset_n;
  reg              LED_PIO_s1_slavearbiterlockenable;
  wire             LED_PIO_s1_slavearbiterlockenable2;
  wire             LED_PIO_s1_unreg_firsttransfer;
  wire             LED_PIO_s1_waits_for_read;
  wire             LED_PIO_s1_waits_for_write;
  wire             LED_PIO_s1_write_n;
  wire    [  7: 0] LED_PIO_s1_writedata;
  reg              d1_LED_PIO_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_LED_PIO_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 13: 0] shifted_address_to_LED_PIO_s1_from_CPU_data_master;
  wire             wait_for_LED_PIO_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~LED_PIO_s1_end_xfer;
    end


  assign LED_PIO_s1_begins_xfer = ~d1_reasons_to_wait & ((CPU_data_master_qualified_request_LED_PIO_s1));
  assign CPU_data_master_requests_LED_PIO_s1 = (({CPU_data_master_address_to_slave[13 : 4] , 4'b0} == 14'h3000) & (CPU_data_master_read | CPU_data_master_write)) & CPU_data_master_write;
  //LED_PIO_s1_arb_share_counter set values, which is an e_mux
  assign LED_PIO_s1_arb_share_set_values = 1;

  //LED_PIO_s1_non_bursting_master_requests mux, which is an e_mux
  assign LED_PIO_s1_non_bursting_master_requests = CPU_data_master_requests_LED_PIO_s1;

  //LED_PIO_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign LED_PIO_s1_any_bursting_master_saved_grant = 0;

  //LED_PIO_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign LED_PIO_s1_arb_share_counter_next_value = LED_PIO_s1_firsttransfer ? (LED_PIO_s1_arb_share_set_values - 1) : |LED_PIO_s1_arb_share_counter ? (LED_PIO_s1_arb_share_counter - 1) : 0;

  //LED_PIO_s1_allgrants all slave grants, which is an e_mux
  assign LED_PIO_s1_allgrants = |LED_PIO_s1_grant_vector;

  //LED_PIO_s1_end_xfer assignment, which is an e_assign
  assign LED_PIO_s1_end_xfer = ~(LED_PIO_s1_waits_for_read | LED_PIO_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_LED_PIO_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_LED_PIO_s1 = LED_PIO_s1_end_xfer & (~LED_PIO_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //LED_PIO_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign LED_PIO_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_LED_PIO_s1 & LED_PIO_s1_allgrants) | (end_xfer_arb_share_counter_term_LED_PIO_s1 & ~LED_PIO_s1_non_bursting_master_requests);

  //LED_PIO_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LED_PIO_s1_arb_share_counter <= 0;
      else if (LED_PIO_s1_arb_counter_enable)
          LED_PIO_s1_arb_share_counter <= LED_PIO_s1_arb_share_counter_next_value;
    end


  //LED_PIO_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LED_PIO_s1_slavearbiterlockenable <= 0;
      else if ((|LED_PIO_s1_master_qreq_vector & end_xfer_arb_share_counter_term_LED_PIO_s1) | (end_xfer_arb_share_counter_term_LED_PIO_s1 & ~LED_PIO_s1_non_bursting_master_requests))
          LED_PIO_s1_slavearbiterlockenable <= |LED_PIO_s1_arb_share_counter_next_value;
    end


  //CPU/data_master LED_PIO/s1 arbiterlock, which is an e_assign
  assign CPU_data_master_arbiterlock = LED_PIO_s1_slavearbiterlockenable & CPU_data_master_continuerequest;

  //LED_PIO_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign LED_PIO_s1_slavearbiterlockenable2 = |LED_PIO_s1_arb_share_counter_next_value;

  //CPU/data_master LED_PIO/s1 arbiterlock2, which is an e_assign
  assign CPU_data_master_arbiterlock2 = LED_PIO_s1_slavearbiterlockenable2 & CPU_data_master_continuerequest;

  //LED_PIO_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign LED_PIO_s1_any_continuerequest = 1;

  //CPU_data_master_continuerequest continued request, which is an e_assign
  assign CPU_data_master_continuerequest = 1;

  assign CPU_data_master_qualified_request_LED_PIO_s1 = CPU_data_master_requests_LED_PIO_s1 & ~(((~CPU_data_master_waitrequest) & CPU_data_master_write));
  //LED_PIO_s1_writedata mux, which is an e_mux
  assign LED_PIO_s1_writedata = CPU_data_master_writedata;

  //master is always granted when requested
  assign CPU_data_master_granted_LED_PIO_s1 = CPU_data_master_qualified_request_LED_PIO_s1;

  //CPU/data_master saved-grant LED_PIO/s1, which is an e_assign
  assign CPU_data_master_saved_grant_LED_PIO_s1 = CPU_data_master_requests_LED_PIO_s1;

  //allow new arb cycle for LED_PIO/s1, which is an e_assign
  assign LED_PIO_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign LED_PIO_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign LED_PIO_s1_master_qreq_vector = 1;

  //LED_PIO_s1_reset_n assignment, which is an e_assign
  assign LED_PIO_s1_reset_n = reset_n;

  assign LED_PIO_s1_chipselect = CPU_data_master_granted_LED_PIO_s1;
  //LED_PIO_s1_firsttransfer first transaction, which is an e_assign
  assign LED_PIO_s1_firsttransfer = LED_PIO_s1_begins_xfer ? LED_PIO_s1_unreg_firsttransfer : LED_PIO_s1_reg_firsttransfer;

  //LED_PIO_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign LED_PIO_s1_unreg_firsttransfer = ~(LED_PIO_s1_slavearbiterlockenable & LED_PIO_s1_any_continuerequest);

  //LED_PIO_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LED_PIO_s1_reg_firsttransfer <= 1'b1;
      else if (LED_PIO_s1_begins_xfer)
          LED_PIO_s1_reg_firsttransfer <= LED_PIO_s1_unreg_firsttransfer;
    end


  //LED_PIO_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign LED_PIO_s1_beginbursttransfer_internal = LED_PIO_s1_begins_xfer;

  //~LED_PIO_s1_write_n assignment, which is an e_mux
  assign LED_PIO_s1_write_n = ~(((CPU_data_master_granted_LED_PIO_s1 & CPU_data_master_write)) & LED_PIO_s1_pretend_byte_enable);

  assign shifted_address_to_LED_PIO_s1_from_CPU_data_master = CPU_data_master_address_to_slave;
  //LED_PIO_s1_address mux, which is an e_mux
  assign LED_PIO_s1_address = shifted_address_to_LED_PIO_s1_from_CPU_data_master >> 2;

  //d1_LED_PIO_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_LED_PIO_s1_end_xfer <= 1;
      else if (1)
          d1_LED_PIO_s1_end_xfer <= LED_PIO_s1_end_xfer;
    end


  //LED_PIO_s1_waits_for_read in a cycle, which is an e_mux
  assign LED_PIO_s1_waits_for_read = LED_PIO_s1_in_a_read_cycle & LED_PIO_s1_begins_xfer;

  //LED_PIO_s1_in_a_read_cycle assignment, which is an e_assign
  assign LED_PIO_s1_in_a_read_cycle = CPU_data_master_granted_LED_PIO_s1 & CPU_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = LED_PIO_s1_in_a_read_cycle;

  //LED_PIO_s1_waits_for_write in a cycle, which is an e_mux
  assign LED_PIO_s1_waits_for_write = LED_PIO_s1_in_a_write_cycle & 0;

  //LED_PIO_s1_in_a_write_cycle assignment, which is an e_assign
  assign LED_PIO_s1_in_a_write_cycle = CPU_data_master_granted_LED_PIO_s1 & CPU_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = LED_PIO_s1_in_a_write_cycle;

  assign wait_for_LED_PIO_s1_counter = 0;
  //LED_PIO_s1_pretend_byte_enable byte enable port mux, which is an e_mux
  assign LED_PIO_s1_pretend_byte_enable = (CPU_data_master_granted_LED_PIO_s1)? CPU_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //LED_PIO/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_RAM_s1_arbitrator (
                                  // inputs:
                                   CPU_data_master_address_to_slave,
                                   CPU_data_master_byteenable,
                                   CPU_data_master_read,
                                   CPU_data_master_waitrequest,
                                   CPU_data_master_write,
                                   CPU_data_master_writedata,
                                   CPU_instruction_master_address_to_slave,
                                   CPU_instruction_master_latency_counter,
                                   CPU_instruction_master_read,
                                   clk,
                                   onchip_RAM_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   CPU_data_master_granted_onchip_RAM_s1,
                                   CPU_data_master_qualified_request_onchip_RAM_s1,
                                   CPU_data_master_read_data_valid_onchip_RAM_s1,
                                   CPU_data_master_requests_onchip_RAM_s1,
                                   CPU_instruction_master_granted_onchip_RAM_s1,
                                   CPU_instruction_master_qualified_request_onchip_RAM_s1,
                                   CPU_instruction_master_read_data_valid_onchip_RAM_s1,
                                   CPU_instruction_master_requests_onchip_RAM_s1,
                                   d1_onchip_RAM_s1_end_xfer,
                                   onchip_RAM_s1_address,
                                   onchip_RAM_s1_byteenable,
                                   onchip_RAM_s1_chipselect,
                                   onchip_RAM_s1_clken,
                                   onchip_RAM_s1_readdata_from_sa,
                                   onchip_RAM_s1_write,
                                   onchip_RAM_s1_writedata,
                                   registered_CPU_data_master_read_data_valid_onchip_RAM_s1
                                )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           CPU_data_master_granted_onchip_RAM_s1;
  output           CPU_data_master_qualified_request_onchip_RAM_s1;
  output           CPU_data_master_read_data_valid_onchip_RAM_s1;
  output           CPU_data_master_requests_onchip_RAM_s1;
  output           CPU_instruction_master_granted_onchip_RAM_s1;
  output           CPU_instruction_master_qualified_request_onchip_RAM_s1;
  output           CPU_instruction_master_read_data_valid_onchip_RAM_s1;
  output           CPU_instruction_master_requests_onchip_RAM_s1;
  output           d1_onchip_RAM_s1_end_xfer;
  output  [  8: 0] onchip_RAM_s1_address;
  output  [  3: 0] onchip_RAM_s1_byteenable;
  output           onchip_RAM_s1_chipselect;
  output           onchip_RAM_s1_clken;
  output  [ 31: 0] onchip_RAM_s1_readdata_from_sa;
  output           onchip_RAM_s1_write;
  output  [ 31: 0] onchip_RAM_s1_writedata;
  output           registered_CPU_data_master_read_data_valid_onchip_RAM_s1;
  input   [ 13: 0] CPU_data_master_address_to_slave;
  input   [  3: 0] CPU_data_master_byteenable;
  input            CPU_data_master_read;
  input            CPU_data_master_waitrequest;
  input            CPU_data_master_write;
  input   [ 31: 0] CPU_data_master_writedata;
  input   [ 13: 0] CPU_instruction_master_address_to_slave;
  input            CPU_instruction_master_latency_counter;
  input            CPU_instruction_master_read;
  input            clk;
  input   [ 31: 0] onchip_RAM_s1_readdata;
  input            reset_n;

  wire             CPU_data_master_arbiterlock;
  wire             CPU_data_master_arbiterlock2;
  wire             CPU_data_master_continuerequest;
  wire             CPU_data_master_granted_onchip_RAM_s1;
  wire             CPU_data_master_qualified_request_onchip_RAM_s1;
  wire             CPU_data_master_read_data_valid_onchip_RAM_s1;
  reg              CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register;
  wire             CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register_in;
  wire             CPU_data_master_requests_onchip_RAM_s1;
  wire             CPU_data_master_saved_grant_onchip_RAM_s1;
  wire             CPU_instruction_master_arbiterlock;
  wire             CPU_instruction_master_arbiterlock2;
  wire             CPU_instruction_master_continuerequest;
  wire             CPU_instruction_master_granted_onchip_RAM_s1;
  wire             CPU_instruction_master_qualified_request_onchip_RAM_s1;
  wire             CPU_instruction_master_read_data_valid_onchip_RAM_s1;
  reg              CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register;
  wire             CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register_in;
  wire             CPU_instruction_master_requests_onchip_RAM_s1;
  wire             CPU_instruction_master_saved_grant_onchip_RAM_s1;
  reg              d1_onchip_RAM_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_RAM_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_CPU_data_master_granted_slave_onchip_RAM_s1;
  reg              last_cycle_CPU_instruction_master_granted_slave_onchip_RAM_s1;
  wire    [  8: 0] onchip_RAM_s1_address;
  wire             onchip_RAM_s1_allgrants;
  wire             onchip_RAM_s1_allow_new_arb_cycle;
  wire             onchip_RAM_s1_any_bursting_master_saved_grant;
  wire             onchip_RAM_s1_any_continuerequest;
  reg     [  1: 0] onchip_RAM_s1_arb_addend;
  wire             onchip_RAM_s1_arb_counter_enable;
  reg              onchip_RAM_s1_arb_share_counter;
  wire             onchip_RAM_s1_arb_share_counter_next_value;
  wire             onchip_RAM_s1_arb_share_set_values;
  wire    [  1: 0] onchip_RAM_s1_arb_winner;
  wire             onchip_RAM_s1_arbitration_holdoff_internal;
  wire             onchip_RAM_s1_beginbursttransfer_internal;
  wire             onchip_RAM_s1_begins_xfer;
  wire    [  3: 0] onchip_RAM_s1_byteenable;
  wire             onchip_RAM_s1_chipselect;
  wire    [  3: 0] onchip_RAM_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_RAM_s1_chosen_master_rot_left;
  wire             onchip_RAM_s1_clken;
  wire             onchip_RAM_s1_end_xfer;
  wire             onchip_RAM_s1_firsttransfer;
  wire    [  1: 0] onchip_RAM_s1_grant_vector;
  wire             onchip_RAM_s1_in_a_read_cycle;
  wire             onchip_RAM_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_RAM_s1_master_qreq_vector;
  wire             onchip_RAM_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_RAM_s1_readdata_from_sa;
  reg              onchip_RAM_s1_reg_firsttransfer;
  reg     [  1: 0] onchip_RAM_s1_saved_chosen_master_vector;
  reg              onchip_RAM_s1_slavearbiterlockenable;
  wire             onchip_RAM_s1_slavearbiterlockenable2;
  wire             onchip_RAM_s1_unreg_firsttransfer;
  wire             onchip_RAM_s1_waits_for_read;
  wire             onchip_RAM_s1_waits_for_write;
  wire             onchip_RAM_s1_write;
  wire    [ 31: 0] onchip_RAM_s1_writedata;
  wire             p1_CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register;
  wire             p1_CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register;
  wire             registered_CPU_data_master_read_data_valid_onchip_RAM_s1;
  wire    [ 13: 0] shifted_address_to_onchip_RAM_s1_from_CPU_data_master;
  wire    [ 13: 0] shifted_address_to_onchip_RAM_s1_from_CPU_instruction_master;
  wire             wait_for_onchip_RAM_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~onchip_RAM_s1_end_xfer;
    end


  assign onchip_RAM_s1_begins_xfer = ~d1_reasons_to_wait & ((CPU_data_master_qualified_request_onchip_RAM_s1 | CPU_instruction_master_qualified_request_onchip_RAM_s1));
  //assign onchip_RAM_s1_readdata_from_sa = onchip_RAM_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_RAM_s1_readdata_from_sa = onchip_RAM_s1_readdata;

  assign CPU_data_master_requests_onchip_RAM_s1 = ({CPU_data_master_address_to_slave[13 : 11] , 11'b0} == 14'h2800) & (CPU_data_master_read | CPU_data_master_write);
  //registered rdv signal_name registered_CPU_data_master_read_data_valid_onchip_RAM_s1 assignment, which is an e_assign
  assign registered_CPU_data_master_read_data_valid_onchip_RAM_s1 = CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register_in;

  //onchip_RAM_s1_arb_share_counter set values, which is an e_mux
  assign onchip_RAM_s1_arb_share_set_values = 1;

  //onchip_RAM_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_RAM_s1_non_bursting_master_requests = CPU_data_master_requests_onchip_RAM_s1 |
    CPU_instruction_master_requests_onchip_RAM_s1 |
    CPU_data_master_requests_onchip_RAM_s1 |
    CPU_instruction_master_requests_onchip_RAM_s1;

  //onchip_RAM_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_RAM_s1_any_bursting_master_saved_grant = 0;

  //onchip_RAM_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_RAM_s1_arb_share_counter_next_value = onchip_RAM_s1_firsttransfer ? (onchip_RAM_s1_arb_share_set_values - 1) : |onchip_RAM_s1_arb_share_counter ? (onchip_RAM_s1_arb_share_counter - 1) : 0;

  //onchip_RAM_s1_allgrants all slave grants, which is an e_mux
  assign onchip_RAM_s1_allgrants = |onchip_RAM_s1_grant_vector |
    |onchip_RAM_s1_grant_vector |
    |onchip_RAM_s1_grant_vector |
    |onchip_RAM_s1_grant_vector;

  //onchip_RAM_s1_end_xfer assignment, which is an e_assign
  assign onchip_RAM_s1_end_xfer = ~(onchip_RAM_s1_waits_for_read | onchip_RAM_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_RAM_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_RAM_s1 = onchip_RAM_s1_end_xfer & (~onchip_RAM_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_RAM_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_RAM_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_RAM_s1 & onchip_RAM_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_RAM_s1 & ~onchip_RAM_s1_non_bursting_master_requests);

  //onchip_RAM_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_RAM_s1_arb_share_counter <= 0;
      else if (onchip_RAM_s1_arb_counter_enable)
          onchip_RAM_s1_arb_share_counter <= onchip_RAM_s1_arb_share_counter_next_value;
    end


  //onchip_RAM_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_RAM_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_RAM_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_RAM_s1) | (end_xfer_arb_share_counter_term_onchip_RAM_s1 & ~onchip_RAM_s1_non_bursting_master_requests))
          onchip_RAM_s1_slavearbiterlockenable <= |onchip_RAM_s1_arb_share_counter_next_value;
    end


  //CPU/data_master onchip_RAM/s1 arbiterlock, which is an e_assign
  assign CPU_data_master_arbiterlock = onchip_RAM_s1_slavearbiterlockenable & CPU_data_master_continuerequest;

  //onchip_RAM_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_RAM_s1_slavearbiterlockenable2 = |onchip_RAM_s1_arb_share_counter_next_value;

  //CPU/data_master onchip_RAM/s1 arbiterlock2, which is an e_assign
  assign CPU_data_master_arbiterlock2 = onchip_RAM_s1_slavearbiterlockenable2 & CPU_data_master_continuerequest;

  //CPU/instruction_master onchip_RAM/s1 arbiterlock, which is an e_assign
  assign CPU_instruction_master_arbiterlock = onchip_RAM_s1_slavearbiterlockenable & CPU_instruction_master_continuerequest;

  //CPU/instruction_master onchip_RAM/s1 arbiterlock2, which is an e_assign
  assign CPU_instruction_master_arbiterlock2 = onchip_RAM_s1_slavearbiterlockenable2 & CPU_instruction_master_continuerequest;

  //CPU/instruction_master granted onchip_RAM/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_CPU_instruction_master_granted_slave_onchip_RAM_s1 <= 0;
      else if (1)
          last_cycle_CPU_instruction_master_granted_slave_onchip_RAM_s1 <= CPU_instruction_master_saved_grant_onchip_RAM_s1 ? 1 : (onchip_RAM_s1_arbitration_holdoff_internal | ~CPU_instruction_master_requests_onchip_RAM_s1) ? 0 : last_cycle_CPU_instruction_master_granted_slave_onchip_RAM_s1;
    end


  //CPU_instruction_master_continuerequest continued request, which is an e_mux
  assign CPU_instruction_master_continuerequest = last_cycle_CPU_instruction_master_granted_slave_onchip_RAM_s1 & CPU_instruction_master_requests_onchip_RAM_s1;

  //onchip_RAM_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_RAM_s1_any_continuerequest = CPU_instruction_master_continuerequest |
    CPU_data_master_continuerequest;

  assign CPU_data_master_qualified_request_onchip_RAM_s1 = CPU_data_master_requests_onchip_RAM_s1 & ~((CPU_data_master_read & ((|CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register))) | ((~CPU_data_master_waitrequest) & CPU_data_master_write) | CPU_instruction_master_arbiterlock);
  //CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register_in = CPU_data_master_granted_onchip_RAM_s1 & CPU_data_master_read & ~onchip_RAM_s1_waits_for_read & ~(|CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register);

  //shift register p1 CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register = {CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register, CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register_in};

  //CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register <= 0;
      else if (1)
          CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register <= p1_CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register;
    end


  //local readdatavalid CPU_data_master_read_data_valid_onchip_RAM_s1, which is an e_mux
  assign CPU_data_master_read_data_valid_onchip_RAM_s1 = CPU_data_master_read_data_valid_onchip_RAM_s1_shift_register;

  //onchip_RAM_s1_writedata mux, which is an e_mux
  assign onchip_RAM_s1_writedata = CPU_data_master_writedata;

  //mux onchip_RAM_s1_clken, which is an e_mux
  assign onchip_RAM_s1_clken = 1'b1;

  assign CPU_instruction_master_requests_onchip_RAM_s1 = (({CPU_instruction_master_address_to_slave[13 : 11] , 11'b0} == 14'h2800) & (CPU_instruction_master_read)) & CPU_instruction_master_read;
  //CPU/data_master granted onchip_RAM/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_CPU_data_master_granted_slave_onchip_RAM_s1 <= 0;
      else if (1)
          last_cycle_CPU_data_master_granted_slave_onchip_RAM_s1 <= CPU_data_master_saved_grant_onchip_RAM_s1 ? 1 : (onchip_RAM_s1_arbitration_holdoff_internal | ~CPU_data_master_requests_onchip_RAM_s1) ? 0 : last_cycle_CPU_data_master_granted_slave_onchip_RAM_s1;
    end


  //CPU_data_master_continuerequest continued request, which is an e_mux
  assign CPU_data_master_continuerequest = last_cycle_CPU_data_master_granted_slave_onchip_RAM_s1 & CPU_data_master_requests_onchip_RAM_s1;

  assign CPU_instruction_master_qualified_request_onchip_RAM_s1 = CPU_instruction_master_requests_onchip_RAM_s1 & ~((CPU_instruction_master_read & ((1 < CPU_instruction_master_latency_counter))) | CPU_data_master_arbiterlock);
  //CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register_in = CPU_instruction_master_granted_onchip_RAM_s1 & CPU_instruction_master_read & ~onchip_RAM_s1_waits_for_read;

  //shift register p1 CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register = {CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register, CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register_in};

  //CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register <= 0;
      else if (1)
          CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register <= p1_CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register;
    end


  //local readdatavalid CPU_instruction_master_read_data_valid_onchip_RAM_s1, which is an e_mux
  assign CPU_instruction_master_read_data_valid_onchip_RAM_s1 = CPU_instruction_master_read_data_valid_onchip_RAM_s1_shift_register;

  //allow new arb cycle for onchip_RAM/s1, which is an e_assign
  assign onchip_RAM_s1_allow_new_arb_cycle = ~CPU_data_master_arbiterlock & ~CPU_instruction_master_arbiterlock;

  //CPU/instruction_master assignment into master qualified-requests vector for onchip_RAM/s1, which is an e_assign
  assign onchip_RAM_s1_master_qreq_vector[0] = CPU_instruction_master_qualified_request_onchip_RAM_s1;

  //CPU/instruction_master grant onchip_RAM/s1, which is an e_assign
  assign CPU_instruction_master_granted_onchip_RAM_s1 = onchip_RAM_s1_grant_vector[0];

  //CPU/instruction_master saved-grant onchip_RAM/s1, which is an e_assign
  assign CPU_instruction_master_saved_grant_onchip_RAM_s1 = onchip_RAM_s1_arb_winner[0] && CPU_instruction_master_requests_onchip_RAM_s1;

  //CPU/data_master assignment into master qualified-requests vector for onchip_RAM/s1, which is an e_assign
  assign onchip_RAM_s1_master_qreq_vector[1] = CPU_data_master_qualified_request_onchip_RAM_s1;

  //CPU/data_master grant onchip_RAM/s1, which is an e_assign
  assign CPU_data_master_granted_onchip_RAM_s1 = onchip_RAM_s1_grant_vector[1];

  //CPU/data_master saved-grant onchip_RAM/s1, which is an e_assign
  assign CPU_data_master_saved_grant_onchip_RAM_s1 = onchip_RAM_s1_arb_winner[1] && CPU_data_master_requests_onchip_RAM_s1;

  //onchip_RAM/s1 chosen-master double-vector, which is an e_assign
  assign onchip_RAM_s1_chosen_master_double_vector = {onchip_RAM_s1_master_qreq_vector, onchip_RAM_s1_master_qreq_vector} & ({~onchip_RAM_s1_master_qreq_vector, ~onchip_RAM_s1_master_qreq_vector} + onchip_RAM_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_RAM_s1_arb_winner = (onchip_RAM_s1_allow_new_arb_cycle & | onchip_RAM_s1_grant_vector) ? onchip_RAM_s1_grant_vector : onchip_RAM_s1_saved_chosen_master_vector;

  //saved onchip_RAM_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_RAM_s1_saved_chosen_master_vector <= 0;
      else if (onchip_RAM_s1_allow_new_arb_cycle)
          onchip_RAM_s1_saved_chosen_master_vector <= |onchip_RAM_s1_grant_vector ? onchip_RAM_s1_grant_vector : onchip_RAM_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_RAM_s1_grant_vector = {(onchip_RAM_s1_chosen_master_double_vector[1] | onchip_RAM_s1_chosen_master_double_vector[3]),
    (onchip_RAM_s1_chosen_master_double_vector[0] | onchip_RAM_s1_chosen_master_double_vector[2])};

  //onchip_RAM/s1 chosen master rotated left, which is an e_assign
  assign onchip_RAM_s1_chosen_master_rot_left = (onchip_RAM_s1_arb_winner << 1) ? (onchip_RAM_s1_arb_winner << 1) : 1;

  //onchip_RAM/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_RAM_s1_arb_addend <= 1;
      else if (|onchip_RAM_s1_grant_vector)
          onchip_RAM_s1_arb_addend <= onchip_RAM_s1_end_xfer? onchip_RAM_s1_chosen_master_rot_left : onchip_RAM_s1_grant_vector;
    end


  assign onchip_RAM_s1_chipselect = CPU_data_master_granted_onchip_RAM_s1 | CPU_instruction_master_granted_onchip_RAM_s1;
  //onchip_RAM_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_RAM_s1_firsttransfer = onchip_RAM_s1_begins_xfer ? onchip_RAM_s1_unreg_firsttransfer : onchip_RAM_s1_reg_firsttransfer;

  //onchip_RAM_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_RAM_s1_unreg_firsttransfer = ~(onchip_RAM_s1_slavearbiterlockenable & onchip_RAM_s1_any_continuerequest);

  //onchip_RAM_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_RAM_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_RAM_s1_begins_xfer)
          onchip_RAM_s1_reg_firsttransfer <= onchip_RAM_s1_unreg_firsttransfer;
    end


  //onchip_RAM_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_RAM_s1_beginbursttransfer_internal = onchip_RAM_s1_begins_xfer;

  //onchip_RAM_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_RAM_s1_arbitration_holdoff_internal = onchip_RAM_s1_begins_xfer & onchip_RAM_s1_firsttransfer;

  //onchip_RAM_s1_write assignment, which is an e_mux
  assign onchip_RAM_s1_write = CPU_data_master_granted_onchip_RAM_s1 & CPU_data_master_write;

  assign shifted_address_to_onchip_RAM_s1_from_CPU_data_master = CPU_data_master_address_to_slave;
  //onchip_RAM_s1_address mux, which is an e_mux
  assign onchip_RAM_s1_address = (CPU_data_master_granted_onchip_RAM_s1)? (shifted_address_to_onchip_RAM_s1_from_CPU_data_master >> 2) :
    (shifted_address_to_onchip_RAM_s1_from_CPU_instruction_master >> 2);

  assign shifted_address_to_onchip_RAM_s1_from_CPU_instruction_master = CPU_instruction_master_address_to_slave;
  //d1_onchip_RAM_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_RAM_s1_end_xfer <= 1;
      else if (1)
          d1_onchip_RAM_s1_end_xfer <= onchip_RAM_s1_end_xfer;
    end


  //onchip_RAM_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_RAM_s1_waits_for_read = onchip_RAM_s1_in_a_read_cycle & 0;

  //onchip_RAM_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_RAM_s1_in_a_read_cycle = (CPU_data_master_granted_onchip_RAM_s1 & CPU_data_master_read) | (CPU_instruction_master_granted_onchip_RAM_s1 & CPU_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_RAM_s1_in_a_read_cycle;

  //onchip_RAM_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_RAM_s1_waits_for_write = onchip_RAM_s1_in_a_write_cycle & 0;

  //onchip_RAM_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_RAM_s1_in_a_write_cycle = CPU_data_master_granted_onchip_RAM_s1 & CPU_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_RAM_s1_in_a_write_cycle;

  assign wait_for_onchip_RAM_s1_counter = 0;
  //onchip_RAM_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_RAM_s1_byteenable = (CPU_data_master_granted_onchip_RAM_s1)? CPU_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_RAM/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (CPU_data_master_granted_onchip_RAM_s1 + CPU_instruction_master_granted_onchip_RAM_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (CPU_data_master_saved_grant_onchip_RAM_s1 + CPU_instruction_master_saved_grant_onchip_RAM_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module onchip_ROM_s1_arbitrator (
                                  // inputs:
                                   CPU_data_master_address_to_slave,
                                   CPU_data_master_byteenable,
                                   CPU_data_master_debugaccess,
                                   CPU_data_master_read,
                                   CPU_data_master_waitrequest,
                                   CPU_data_master_write,
                                   CPU_data_master_writedata,
                                   CPU_instruction_master_address_to_slave,
                                   CPU_instruction_master_latency_counter,
                                   CPU_instruction_master_read,
                                   clk,
                                   onchip_ROM_s1_readdata,
                                   reset_n,

                                  // outputs:
                                   CPU_data_master_granted_onchip_ROM_s1,
                                   CPU_data_master_qualified_request_onchip_ROM_s1,
                                   CPU_data_master_read_data_valid_onchip_ROM_s1,
                                   CPU_data_master_requests_onchip_ROM_s1,
                                   CPU_instruction_master_granted_onchip_ROM_s1,
                                   CPU_instruction_master_qualified_request_onchip_ROM_s1,
                                   CPU_instruction_master_read_data_valid_onchip_ROM_s1,
                                   CPU_instruction_master_requests_onchip_ROM_s1,
                                   d1_onchip_ROM_s1_end_xfer,
                                   onchip_ROM_s1_address,
                                   onchip_ROM_s1_byteenable,
                                   onchip_ROM_s1_chipselect,
                                   onchip_ROM_s1_clken,
                                   onchip_ROM_s1_debugaccess,
                                   onchip_ROM_s1_readdata_from_sa,
                                   onchip_ROM_s1_write,
                                   onchip_ROM_s1_writedata,
                                   registered_CPU_data_master_read_data_valid_onchip_ROM_s1
                                )
  /* synthesis auto_dissolve = "FALSE" */ ;

  output           CPU_data_master_granted_onchip_ROM_s1;
  output           CPU_data_master_qualified_request_onchip_ROM_s1;
  output           CPU_data_master_read_data_valid_onchip_ROM_s1;
  output           CPU_data_master_requests_onchip_ROM_s1;
  output           CPU_instruction_master_granted_onchip_ROM_s1;
  output           CPU_instruction_master_qualified_request_onchip_ROM_s1;
  output           CPU_instruction_master_read_data_valid_onchip_ROM_s1;
  output           CPU_instruction_master_requests_onchip_ROM_s1;
  output           d1_onchip_ROM_s1_end_xfer;
  output  [  8: 0] onchip_ROM_s1_address;
  output  [  3: 0] onchip_ROM_s1_byteenable;
  output           onchip_ROM_s1_chipselect;
  output           onchip_ROM_s1_clken;
  output           onchip_ROM_s1_debugaccess;
  output  [ 31: 0] onchip_ROM_s1_readdata_from_sa;
  output           onchip_ROM_s1_write;
  output  [ 31: 0] onchip_ROM_s1_writedata;
  output           registered_CPU_data_master_read_data_valid_onchip_ROM_s1;
  input   [ 13: 0] CPU_data_master_address_to_slave;
  input   [  3: 0] CPU_data_master_byteenable;
  input            CPU_data_master_debugaccess;
  input            CPU_data_master_read;
  input            CPU_data_master_waitrequest;
  input            CPU_data_master_write;
  input   [ 31: 0] CPU_data_master_writedata;
  input   [ 13: 0] CPU_instruction_master_address_to_slave;
  input            CPU_instruction_master_latency_counter;
  input            CPU_instruction_master_read;
  input            clk;
  input   [ 31: 0] onchip_ROM_s1_readdata;
  input            reset_n;

  wire             CPU_data_master_arbiterlock;
  wire             CPU_data_master_arbiterlock2;
  wire             CPU_data_master_continuerequest;
  wire             CPU_data_master_granted_onchip_ROM_s1;
  wire             CPU_data_master_qualified_request_onchip_ROM_s1;
  wire             CPU_data_master_read_data_valid_onchip_ROM_s1;
  reg              CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register;
  wire             CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register_in;
  wire             CPU_data_master_requests_onchip_ROM_s1;
  wire             CPU_data_master_saved_grant_onchip_ROM_s1;
  wire             CPU_instruction_master_arbiterlock;
  wire             CPU_instruction_master_arbiterlock2;
  wire             CPU_instruction_master_continuerequest;
  wire             CPU_instruction_master_granted_onchip_ROM_s1;
  wire             CPU_instruction_master_qualified_request_onchip_ROM_s1;
  wire             CPU_instruction_master_read_data_valid_onchip_ROM_s1;
  reg              CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register;
  wire             CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register_in;
  wire             CPU_instruction_master_requests_onchip_ROM_s1;
  wire             CPU_instruction_master_saved_grant_onchip_ROM_s1;
  reg              d1_onchip_ROM_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_onchip_ROM_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_CPU_data_master_granted_slave_onchip_ROM_s1;
  reg              last_cycle_CPU_instruction_master_granted_slave_onchip_ROM_s1;
  wire    [  8: 0] onchip_ROM_s1_address;
  wire             onchip_ROM_s1_allgrants;
  wire             onchip_ROM_s1_allow_new_arb_cycle;
  wire             onchip_ROM_s1_any_bursting_master_saved_grant;
  wire             onchip_ROM_s1_any_continuerequest;
  reg     [  1: 0] onchip_ROM_s1_arb_addend;
  wire             onchip_ROM_s1_arb_counter_enable;
  reg              onchip_ROM_s1_arb_share_counter;
  wire             onchip_ROM_s1_arb_share_counter_next_value;
  wire             onchip_ROM_s1_arb_share_set_values;
  wire    [  1: 0] onchip_ROM_s1_arb_winner;
  wire             onchip_ROM_s1_arbitration_holdoff_internal;
  wire             onchip_ROM_s1_beginbursttransfer_internal;
  wire             onchip_ROM_s1_begins_xfer;
  wire    [  3: 0] onchip_ROM_s1_byteenable;
  wire             onchip_ROM_s1_chipselect;
  wire    [  3: 0] onchip_ROM_s1_chosen_master_double_vector;
  wire    [  1: 0] onchip_ROM_s1_chosen_master_rot_left;
  wire             onchip_ROM_s1_clken;
  wire             onchip_ROM_s1_debugaccess;
  wire             onchip_ROM_s1_end_xfer;
  wire             onchip_ROM_s1_firsttransfer;
  wire    [  1: 0] onchip_ROM_s1_grant_vector;
  wire             onchip_ROM_s1_in_a_read_cycle;
  wire             onchip_ROM_s1_in_a_write_cycle;
  wire    [  1: 0] onchip_ROM_s1_master_qreq_vector;
  wire             onchip_ROM_s1_non_bursting_master_requests;
  wire    [ 31: 0] onchip_ROM_s1_readdata_from_sa;
  reg              onchip_ROM_s1_reg_firsttransfer;
  reg     [  1: 0] onchip_ROM_s1_saved_chosen_master_vector;
  reg              onchip_ROM_s1_slavearbiterlockenable;
  wire             onchip_ROM_s1_slavearbiterlockenable2;
  wire             onchip_ROM_s1_unreg_firsttransfer;
  wire             onchip_ROM_s1_waits_for_read;
  wire             onchip_ROM_s1_waits_for_write;
  wire             onchip_ROM_s1_write;
  wire    [ 31: 0] onchip_ROM_s1_writedata;
  wire             p1_CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register;
  wire             p1_CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register;
  wire             registered_CPU_data_master_read_data_valid_onchip_ROM_s1;
  wire    [ 13: 0] shifted_address_to_onchip_ROM_s1_from_CPU_data_master;
  wire    [ 13: 0] shifted_address_to_onchip_ROM_s1_from_CPU_instruction_master;
  wire             wait_for_onchip_ROM_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else if (1)
          d1_reasons_to_wait <= ~onchip_ROM_s1_end_xfer;
    end


  assign onchip_ROM_s1_begins_xfer = ~d1_reasons_to_wait & ((CPU_data_master_qualified_request_onchip_ROM_s1 | CPU_instruction_master_qualified_request_onchip_ROM_s1));
  //assign onchip_ROM_s1_readdata_from_sa = onchip_ROM_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign onchip_ROM_s1_readdata_from_sa = onchip_ROM_s1_readdata;

  assign CPU_data_master_requests_onchip_ROM_s1 = ({CPU_data_master_address_to_slave[13 : 11] , 11'b0} == 14'h2000) & (CPU_data_master_read | CPU_data_master_write);
  //registered rdv signal_name registered_CPU_data_master_read_data_valid_onchip_ROM_s1 assignment, which is an e_assign
  assign registered_CPU_data_master_read_data_valid_onchip_ROM_s1 = CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register_in;

  //onchip_ROM_s1_arb_share_counter set values, which is an e_mux
  assign onchip_ROM_s1_arb_share_set_values = 1;

  //onchip_ROM_s1_non_bursting_master_requests mux, which is an e_mux
  assign onchip_ROM_s1_non_bursting_master_requests = CPU_data_master_requests_onchip_ROM_s1 |
    CPU_instruction_master_requests_onchip_ROM_s1 |
    CPU_data_master_requests_onchip_ROM_s1 |
    CPU_instruction_master_requests_onchip_ROM_s1;

  //onchip_ROM_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign onchip_ROM_s1_any_bursting_master_saved_grant = 0;

  //onchip_ROM_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign onchip_ROM_s1_arb_share_counter_next_value = onchip_ROM_s1_firsttransfer ? (onchip_ROM_s1_arb_share_set_values - 1) : |onchip_ROM_s1_arb_share_counter ? (onchip_ROM_s1_arb_share_counter - 1) : 0;

  //onchip_ROM_s1_allgrants all slave grants, which is an e_mux
  assign onchip_ROM_s1_allgrants = |onchip_ROM_s1_grant_vector |
    |onchip_ROM_s1_grant_vector |
    |onchip_ROM_s1_grant_vector |
    |onchip_ROM_s1_grant_vector;

  //onchip_ROM_s1_end_xfer assignment, which is an e_assign
  assign onchip_ROM_s1_end_xfer = ~(onchip_ROM_s1_waits_for_read | onchip_ROM_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_onchip_ROM_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_onchip_ROM_s1 = onchip_ROM_s1_end_xfer & (~onchip_ROM_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //onchip_ROM_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign onchip_ROM_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_onchip_ROM_s1 & onchip_ROM_s1_allgrants) | (end_xfer_arb_share_counter_term_onchip_ROM_s1 & ~onchip_ROM_s1_non_bursting_master_requests);

  //onchip_ROM_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_ROM_s1_arb_share_counter <= 0;
      else if (onchip_ROM_s1_arb_counter_enable)
          onchip_ROM_s1_arb_share_counter <= onchip_ROM_s1_arb_share_counter_next_value;
    end


  //onchip_ROM_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_ROM_s1_slavearbiterlockenable <= 0;
      else if ((|onchip_ROM_s1_master_qreq_vector & end_xfer_arb_share_counter_term_onchip_ROM_s1) | (end_xfer_arb_share_counter_term_onchip_ROM_s1 & ~onchip_ROM_s1_non_bursting_master_requests))
          onchip_ROM_s1_slavearbiterlockenable <= |onchip_ROM_s1_arb_share_counter_next_value;
    end


  //CPU/data_master onchip_ROM/s1 arbiterlock, which is an e_assign
  assign CPU_data_master_arbiterlock = onchip_ROM_s1_slavearbiterlockenable & CPU_data_master_continuerequest;

  //onchip_ROM_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign onchip_ROM_s1_slavearbiterlockenable2 = |onchip_ROM_s1_arb_share_counter_next_value;

  //CPU/data_master onchip_ROM/s1 arbiterlock2, which is an e_assign
  assign CPU_data_master_arbiterlock2 = onchip_ROM_s1_slavearbiterlockenable2 & CPU_data_master_continuerequest;

  //CPU/instruction_master onchip_ROM/s1 arbiterlock, which is an e_assign
  assign CPU_instruction_master_arbiterlock = onchip_ROM_s1_slavearbiterlockenable & CPU_instruction_master_continuerequest;

  //CPU/instruction_master onchip_ROM/s1 arbiterlock2, which is an e_assign
  assign CPU_instruction_master_arbiterlock2 = onchip_ROM_s1_slavearbiterlockenable2 & CPU_instruction_master_continuerequest;

  //CPU/instruction_master granted onchip_ROM/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_CPU_instruction_master_granted_slave_onchip_ROM_s1 <= 0;
      else if (1)
          last_cycle_CPU_instruction_master_granted_slave_onchip_ROM_s1 <= CPU_instruction_master_saved_grant_onchip_ROM_s1 ? 1 : (onchip_ROM_s1_arbitration_holdoff_internal | ~CPU_instruction_master_requests_onchip_ROM_s1) ? 0 : last_cycle_CPU_instruction_master_granted_slave_onchip_ROM_s1;
    end


  //CPU_instruction_master_continuerequest continued request, which is an e_mux
  assign CPU_instruction_master_continuerequest = last_cycle_CPU_instruction_master_granted_slave_onchip_ROM_s1 & CPU_instruction_master_requests_onchip_ROM_s1;

  //onchip_ROM_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign onchip_ROM_s1_any_continuerequest = CPU_instruction_master_continuerequest |
    CPU_data_master_continuerequest;

  assign CPU_data_master_qualified_request_onchip_ROM_s1 = CPU_data_master_requests_onchip_ROM_s1 & ~((CPU_data_master_read & ((|CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register))) | ((~CPU_data_master_waitrequest) & CPU_data_master_write) | CPU_instruction_master_arbiterlock);
  //CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register_in = CPU_data_master_granted_onchip_ROM_s1 & CPU_data_master_read & ~onchip_ROM_s1_waits_for_read & ~(|CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register);

  //shift register p1 CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register = {CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register, CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register_in};

  //CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register <= 0;
      else if (1)
          CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register <= p1_CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register;
    end


  //local readdatavalid CPU_data_master_read_data_valid_onchip_ROM_s1, which is an e_mux
  assign CPU_data_master_read_data_valid_onchip_ROM_s1 = CPU_data_master_read_data_valid_onchip_ROM_s1_shift_register;

  //onchip_ROM_s1_writedata mux, which is an e_mux
  assign onchip_ROM_s1_writedata = CPU_data_master_writedata;

  //mux onchip_ROM_s1_clken, which is an e_mux
  assign onchip_ROM_s1_clken = 1'b1;

  //mux onchip_ROM_s1_debugaccess, which is an e_mux
  assign onchip_ROM_s1_debugaccess = CPU_data_master_debugaccess;

  assign CPU_instruction_master_requests_onchip_ROM_s1 = (({CPU_instruction_master_address_to_slave[13 : 11] , 11'b0} == 14'h2000) & (CPU_instruction_master_read)) & CPU_instruction_master_read;
  //CPU/data_master granted onchip_ROM/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_CPU_data_master_granted_slave_onchip_ROM_s1 <= 0;
      else if (1)
          last_cycle_CPU_data_master_granted_slave_onchip_ROM_s1 <= CPU_data_master_saved_grant_onchip_ROM_s1 ? 1 : (onchip_ROM_s1_arbitration_holdoff_internal | ~CPU_data_master_requests_onchip_ROM_s1) ? 0 : last_cycle_CPU_data_master_granted_slave_onchip_ROM_s1;
    end


  //CPU_data_master_continuerequest continued request, which is an e_mux
  assign CPU_data_master_continuerequest = last_cycle_CPU_data_master_granted_slave_onchip_ROM_s1 & CPU_data_master_requests_onchip_ROM_s1;

  assign CPU_instruction_master_qualified_request_onchip_ROM_s1 = CPU_instruction_master_requests_onchip_ROM_s1 & ~((CPU_instruction_master_read & ((1 < CPU_instruction_master_latency_counter))) | CPU_data_master_arbiterlock);
  //CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register_in mux for readlatency shift register, which is an e_mux
  assign CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register_in = CPU_instruction_master_granted_onchip_ROM_s1 & CPU_instruction_master_read & ~onchip_ROM_s1_waits_for_read;

  //shift register p1 CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register in if flush, otherwise shift left, which is an e_mux
  assign p1_CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register = {CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register, CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register_in};

  //CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register for remembering which master asked for a fixed latency read, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register <= 0;
      else if (1)
          CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register <= p1_CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register;
    end


  //local readdatavalid CPU_instruction_master_read_data_valid_onchip_ROM_s1, which is an e_mux
  assign CPU_instruction_master_read_data_valid_onchip_ROM_s1 = CPU_instruction_master_read_data_valid_onchip_ROM_s1_shift_register;

  //allow new arb cycle for onchip_ROM/s1, which is an e_assign
  assign onchip_ROM_s1_allow_new_arb_cycle = ~CPU_data_master_arbiterlock & ~CPU_instruction_master_arbiterlock;

  //CPU/instruction_master assignment into master qualified-requests vector for onchip_ROM/s1, which is an e_assign
  assign onchip_ROM_s1_master_qreq_vector[0] = CPU_instruction_master_qualified_request_onchip_ROM_s1;

  //CPU/instruction_master grant onchip_ROM/s1, which is an e_assign
  assign CPU_instruction_master_granted_onchip_ROM_s1 = onchip_ROM_s1_grant_vector[0];

  //CPU/instruction_master saved-grant onchip_ROM/s1, which is an e_assign
  assign CPU_instruction_master_saved_grant_onchip_ROM_s1 = onchip_ROM_s1_arb_winner[0] && CPU_instruction_master_requests_onchip_ROM_s1;

  //CPU/data_master assignment into master qualified-requests vector for onchip_ROM/s1, which is an e_assign
  assign onchip_ROM_s1_master_qreq_vector[1] = CPU_data_master_qualified_request_onchip_ROM_s1;

  //CPU/data_master grant onchip_ROM/s1, which is an e_assign
  assign CPU_data_master_granted_onchip_ROM_s1 = onchip_ROM_s1_grant_vector[1];

  //CPU/data_master saved-grant onchip_ROM/s1, which is an e_assign
  assign CPU_data_master_saved_grant_onchip_ROM_s1 = onchip_ROM_s1_arb_winner[1] && CPU_data_master_requests_onchip_ROM_s1;

  //onchip_ROM/s1 chosen-master double-vector, which is an e_assign
  assign onchip_ROM_s1_chosen_master_double_vector = {onchip_ROM_s1_master_qreq_vector, onchip_ROM_s1_master_qreq_vector} & ({~onchip_ROM_s1_master_qreq_vector, ~onchip_ROM_s1_master_qreq_vector} + onchip_ROM_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign onchip_ROM_s1_arb_winner = (onchip_ROM_s1_allow_new_arb_cycle & | onchip_ROM_s1_grant_vector) ? onchip_ROM_s1_grant_vector : onchip_ROM_s1_saved_chosen_master_vector;

  //saved onchip_ROM_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_ROM_s1_saved_chosen_master_vector <= 0;
      else if (onchip_ROM_s1_allow_new_arb_cycle)
          onchip_ROM_s1_saved_chosen_master_vector <= |onchip_ROM_s1_grant_vector ? onchip_ROM_s1_grant_vector : onchip_ROM_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign onchip_ROM_s1_grant_vector = {(onchip_ROM_s1_chosen_master_double_vector[1] | onchip_ROM_s1_chosen_master_double_vector[3]),
    (onchip_ROM_s1_chosen_master_double_vector[0] | onchip_ROM_s1_chosen_master_double_vector[2])};

  //onchip_ROM/s1 chosen master rotated left, which is an e_assign
  assign onchip_ROM_s1_chosen_master_rot_left = (onchip_ROM_s1_arb_winner << 1) ? (onchip_ROM_s1_arb_winner << 1) : 1;

  //onchip_ROM/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_ROM_s1_arb_addend <= 1;
      else if (|onchip_ROM_s1_grant_vector)
          onchip_ROM_s1_arb_addend <= onchip_ROM_s1_end_xfer? onchip_ROM_s1_chosen_master_rot_left : onchip_ROM_s1_grant_vector;
    end


  assign onchip_ROM_s1_chipselect = CPU_data_master_granted_onchip_ROM_s1 | CPU_instruction_master_granted_onchip_ROM_s1;
  //onchip_ROM_s1_firsttransfer first transaction, which is an e_assign
  assign onchip_ROM_s1_firsttransfer = onchip_ROM_s1_begins_xfer ? onchip_ROM_s1_unreg_firsttransfer : onchip_ROM_s1_reg_firsttransfer;

  //onchip_ROM_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign onchip_ROM_s1_unreg_firsttransfer = ~(onchip_ROM_s1_slavearbiterlockenable & onchip_ROM_s1_any_continuerequest);

  //onchip_ROM_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          onchip_ROM_s1_reg_firsttransfer <= 1'b1;
      else if (onchip_ROM_s1_begins_xfer)
          onchip_ROM_s1_reg_firsttransfer <= onchip_ROM_s1_unreg_firsttransfer;
    end


  //onchip_ROM_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign onchip_ROM_s1_beginbursttransfer_internal = onchip_ROM_s1_begins_xfer;

  //onchip_ROM_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign onchip_ROM_s1_arbitration_holdoff_internal = onchip_ROM_s1_begins_xfer & onchip_ROM_s1_firsttransfer;

  //onchip_ROM_s1_write assignment, which is an e_mux
  assign onchip_ROM_s1_write = CPU_data_master_granted_onchip_ROM_s1 & CPU_data_master_write;

  assign shifted_address_to_onchip_ROM_s1_from_CPU_data_master = CPU_data_master_address_to_slave;
  //onchip_ROM_s1_address mux, which is an e_mux
  assign onchip_ROM_s1_address = (CPU_data_master_granted_onchip_ROM_s1)? (shifted_address_to_onchip_ROM_s1_from_CPU_data_master >> 2) :
    (shifted_address_to_onchip_ROM_s1_from_CPU_instruction_master >> 2);

  assign shifted_address_to_onchip_ROM_s1_from_CPU_instruction_master = CPU_instruction_master_address_to_slave;
  //d1_onchip_ROM_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_onchip_ROM_s1_end_xfer <= 1;
      else if (1)
          d1_onchip_ROM_s1_end_xfer <= onchip_ROM_s1_end_xfer;
    end


  //onchip_ROM_s1_waits_for_read in a cycle, which is an e_mux
  assign onchip_ROM_s1_waits_for_read = onchip_ROM_s1_in_a_read_cycle & 0;

  //onchip_ROM_s1_in_a_read_cycle assignment, which is an e_assign
  assign onchip_ROM_s1_in_a_read_cycle = (CPU_data_master_granted_onchip_ROM_s1 & CPU_data_master_read) | (CPU_instruction_master_granted_onchip_ROM_s1 & CPU_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = onchip_ROM_s1_in_a_read_cycle;

  //onchip_ROM_s1_waits_for_write in a cycle, which is an e_mux
  assign onchip_ROM_s1_waits_for_write = onchip_ROM_s1_in_a_write_cycle & 0;

  //onchip_ROM_s1_in_a_write_cycle assignment, which is an e_assign
  assign onchip_ROM_s1_in_a_write_cycle = CPU_data_master_granted_onchip_ROM_s1 & CPU_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = onchip_ROM_s1_in_a_write_cycle;

  assign wait_for_onchip_ROM_s1_counter = 0;
  //onchip_ROM_s1_byteenable byte enable port mux, which is an e_mux
  assign onchip_ROM_s1_byteenable = (CPU_data_master_granted_onchip_ROM_s1)? CPU_data_master_byteenable :
    -1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //onchip_ROM/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else if (1)
          enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (CPU_data_master_granted_onchip_ROM_s1 + CPU_instruction_master_granted_onchip_ROM_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (CPU_data_master_saved_grant_onchip_ROM_s1 + CPU_instruction_master_saved_grant_onchip_ROM_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ucos_reset_SYS_CLK_domain_synch_module (
                                                     // inputs:
                                                      clk,
                                                      data_in,
                                                      reset_n,

                                                     // outputs:
                                                      data_out
                                                   )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "MAX_DELAY=\"100ns\" ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else if (1)
          data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else if (1)
          data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module nios_ucos (
                   // 1) global signals:
                    SYS_CLK,
                    reset_n,

                   // the_KEY_PIO
                    in_port_to_the_KEY_PIO,

                   // the_LED_PIO
                    out_port_from_the_LED_PIO
                 )
;

  output  [  7: 0] out_port_from_the_LED_PIO;
  input            SYS_CLK;
  input   [  3: 0] in_port_to_the_KEY_PIO;
  input            reset_n;

  wire    [ 13: 0] CPU_data_master_address;
  wire    [ 13: 0] CPU_data_master_address_to_slave;
  wire    [  3: 0] CPU_data_master_byteenable;
  wire             CPU_data_master_debugaccess;
  wire             CPU_data_master_granted_CPU_jtag_debug_module;
  wire             CPU_data_master_granted_KEY_PIO_s1;
  wire             CPU_data_master_granted_LED_PIO_s1;
  wire             CPU_data_master_granted_onchip_RAM_s1;
  wire             CPU_data_master_granted_onchip_ROM_s1;
  wire    [ 31: 0] CPU_data_master_irq;
  wire             CPU_data_master_qualified_request_CPU_jtag_debug_module;
  wire             CPU_data_master_qualified_request_KEY_PIO_s1;
  wire             CPU_data_master_qualified_request_LED_PIO_s1;
  wire             CPU_data_master_qualified_request_onchip_RAM_s1;
  wire             CPU_data_master_qualified_request_onchip_ROM_s1;
  wire             CPU_data_master_read;
  wire             CPU_data_master_read_data_valid_CPU_jtag_debug_module;
  wire             CPU_data_master_read_data_valid_KEY_PIO_s1;
  wire             CPU_data_master_read_data_valid_LED_PIO_s1;
  wire             CPU_data_master_read_data_valid_onchip_RAM_s1;
  wire             CPU_data_master_read_data_valid_onchip_ROM_s1;
  wire    [ 31: 0] CPU_data_master_readdata;
  wire             CPU_data_master_requests_CPU_jtag_debug_module;
  wire             CPU_data_master_requests_KEY_PIO_s1;
  wire             CPU_data_master_requests_LED_PIO_s1;
  wire             CPU_data_master_requests_onchip_RAM_s1;
  wire             CPU_data_master_requests_onchip_ROM_s1;
  wire             CPU_data_master_waitrequest;
  wire             CPU_data_master_write;
  wire    [ 31: 0] CPU_data_master_writedata;
  wire    [ 13: 0] CPU_instruction_master_address;
  wire    [ 13: 0] CPU_instruction_master_address_to_slave;
  wire             CPU_instruction_master_granted_CPU_jtag_debug_module;
  wire             CPU_instruction_master_granted_onchip_RAM_s1;
  wire             CPU_instruction_master_granted_onchip_ROM_s1;
  wire             CPU_instruction_master_latency_counter;
  wire             CPU_instruction_master_qualified_request_CPU_jtag_debug_module;
  wire             CPU_instruction_master_qualified_request_onchip_RAM_s1;
  wire             CPU_instruction_master_qualified_request_onchip_ROM_s1;
  wire             CPU_instruction_master_read;
  wire             CPU_instruction_master_read_data_valid_CPU_jtag_debug_module;
  wire             CPU_instruction_master_read_data_valid_onchip_RAM_s1;
  wire             CPU_instruction_master_read_data_valid_onchip_ROM_s1;
  wire    [ 31: 0] CPU_instruction_master_readdata;
  wire             CPU_instruction_master_readdatavalid;
  wire             CPU_instruction_master_requests_CPU_jtag_debug_module;
  wire             CPU_instruction_master_requests_onchip_RAM_s1;
  wire             CPU_instruction_master_requests_onchip_ROM_s1;
  wire             CPU_instruction_master_waitrequest;
  wire    [  8: 0] CPU_jtag_debug_module_address;
  wire             CPU_jtag_debug_module_begintransfer;
  wire    [  3: 0] CPU_jtag_debug_module_byteenable;
  wire             CPU_jtag_debug_module_chipselect;
  wire             CPU_jtag_debug_module_debugaccess;
  wire    [ 31: 0] CPU_jtag_debug_module_readdata;
  wire    [ 31: 0] CPU_jtag_debug_module_readdata_from_sa;
  wire             CPU_jtag_debug_module_reset;
  wire             CPU_jtag_debug_module_reset_n;
  wire             CPU_jtag_debug_module_resetrequest;
  wire             CPU_jtag_debug_module_resetrequest_from_sa;
  wire             CPU_jtag_debug_module_write;
  wire    [ 31: 0] CPU_jtag_debug_module_writedata;
  wire    [  1: 0] KEY_PIO_s1_address;
  wire             KEY_PIO_s1_chipselect;
  wire             KEY_PIO_s1_irq;
  wire             KEY_PIO_s1_irq_from_sa;
  wire    [  3: 0] KEY_PIO_s1_readdata;
  wire    [  3: 0] KEY_PIO_s1_readdata_from_sa;
  wire             KEY_PIO_s1_reset_n;
  wire             KEY_PIO_s1_write_n;
  wire    [  3: 0] KEY_PIO_s1_writedata;
  wire    [  1: 0] LED_PIO_s1_address;
  wire             LED_PIO_s1_chipselect;
  wire             LED_PIO_s1_reset_n;
  wire             LED_PIO_s1_write_n;
  wire    [  7: 0] LED_PIO_s1_writedata;
  wire             SYS_CLK_reset_n;
  wire             d1_CPU_jtag_debug_module_end_xfer;
  wire             d1_KEY_PIO_s1_end_xfer;
  wire             d1_LED_PIO_s1_end_xfer;
  wire             d1_onchip_RAM_s1_end_xfer;
  wire             d1_onchip_ROM_s1_end_xfer;
  wire    [  8: 0] onchip_RAM_s1_address;
  wire    [  3: 0] onchip_RAM_s1_byteenable;
  wire             onchip_RAM_s1_chipselect;
  wire             onchip_RAM_s1_clken;
  wire    [ 31: 0] onchip_RAM_s1_readdata;
  wire    [ 31: 0] onchip_RAM_s1_readdata_from_sa;
  wire             onchip_RAM_s1_write;
  wire    [ 31: 0] onchip_RAM_s1_writedata;
  wire    [  8: 0] onchip_ROM_s1_address;
  wire    [  3: 0] onchip_ROM_s1_byteenable;
  wire             onchip_ROM_s1_chipselect;
  wire             onchip_ROM_s1_clken;
  wire             onchip_ROM_s1_debugaccess;
  wire    [ 31: 0] onchip_ROM_s1_readdata;
  wire    [ 31: 0] onchip_ROM_s1_readdata_from_sa;
  wire             onchip_ROM_s1_write;
  wire    [ 31: 0] onchip_ROM_s1_writedata;
  wire    [  7: 0] out_port_from_the_LED_PIO;
  wire             registered_CPU_data_master_read_data_valid_onchip_RAM_s1;
  wire             registered_CPU_data_master_read_data_valid_onchip_ROM_s1;
  wire             reset_n_sources;
  CPU_jtag_debug_module_arbitrator the_CPU_jtag_debug_module
    (
      .CPU_data_master_address_to_slave                               (CPU_data_master_address_to_slave),
      .CPU_data_master_byteenable                                     (CPU_data_master_byteenable),
      .CPU_data_master_debugaccess                                    (CPU_data_master_debugaccess),
      .CPU_data_master_granted_CPU_jtag_debug_module                  (CPU_data_master_granted_CPU_jtag_debug_module),
      .CPU_data_master_qualified_request_CPU_jtag_debug_module        (CPU_data_master_qualified_request_CPU_jtag_debug_module),
      .CPU_data_master_read                                           (CPU_data_master_read),
      .CPU_data_master_read_data_valid_CPU_jtag_debug_module          (CPU_data_master_read_data_valid_CPU_jtag_debug_module),
      .CPU_data_master_requests_CPU_jtag_debug_module                 (CPU_data_master_requests_CPU_jtag_debug_module),
      .CPU_data_master_waitrequest                                    (CPU_data_master_waitrequest),
      .CPU_data_master_write                                          (CPU_data_master_write),
      .CPU_data_master_writedata                                      (CPU_data_master_writedata),
      .CPU_instruction_master_address_to_slave                        (CPU_instruction_master_address_to_slave),
      .CPU_instruction_master_granted_CPU_jtag_debug_module           (CPU_instruction_master_granted_CPU_jtag_debug_module),
      .CPU_instruction_master_latency_counter                         (CPU_instruction_master_latency_counter),
      .CPU_instruction_master_qualified_request_CPU_jtag_debug_module (CPU_instruction_master_qualified_request_CPU_jtag_debug_module),
      .CPU_instruction_master_read                                    (CPU_instruction_master_read),
      .CPU_instruction_master_read_data_valid_CPU_jtag_debug_module   (CPU_instruction_master_read_data_valid_CPU_jtag_debug_module),
      .CPU_instruction_master_requests_CPU_jtag_debug_module          (CPU_instruction_master_requests_CPU_jtag_debug_module),
      .CPU_jtag_debug_module_address                                  (CPU_jtag_debug_module_address),
      .CPU_jtag_debug_module_begintransfer                            (CPU_jtag_debug_module_begintransfer),
      .CPU_jtag_debug_module_byteenable                               (CPU_jtag_debug_module_byteenable),
      .CPU_jtag_debug_module_chipselect                               (CPU_jtag_debug_module_chipselect),
      .CPU_jtag_debug_module_debugaccess                              (CPU_jtag_debug_module_debugaccess),
      .CPU_jtag_debug_module_readdata                                 (CPU_jtag_debug_module_readdata),
      .CPU_jtag_debug_module_readdata_from_sa                         (CPU_jtag_debug_module_readdata_from_sa),
      .CPU_jtag_debug_module_reset                                    (CPU_jtag_debug_module_reset),
      .CPU_jtag_debug_module_reset_n                                  (CPU_jtag_debug_module_reset_n),
      .CPU_jtag_debug_module_resetrequest                             (CPU_jtag_debug_module_resetrequest),
      .CPU_jtag_debug_module_resetrequest_from_sa                     (CPU_jtag_debug_module_resetrequest_from_sa),
      .CPU_jtag_debug_module_write                                    (CPU_jtag_debug_module_write),
      .CPU_jtag_debug_module_writedata                                (CPU_jtag_debug_module_writedata),
      .clk                                                            (SYS_CLK),
      .d1_CPU_jtag_debug_module_end_xfer                              (d1_CPU_jtag_debug_module_end_xfer),
      .reset_n                                                        (SYS_CLK_reset_n)
    );

  CPU_data_master_arbitrator the_CPU_data_master
    (
      .CPU_data_master_address                                  (CPU_data_master_address),
      .CPU_data_master_address_to_slave                         (CPU_data_master_address_to_slave),
      .CPU_data_master_debugaccess                              (CPU_data_master_debugaccess),
      .CPU_data_master_granted_CPU_jtag_debug_module            (CPU_data_master_granted_CPU_jtag_debug_module),
      .CPU_data_master_granted_KEY_PIO_s1                       (CPU_data_master_granted_KEY_PIO_s1),
      .CPU_data_master_granted_LED_PIO_s1                       (CPU_data_master_granted_LED_PIO_s1),
      .CPU_data_master_granted_onchip_RAM_s1                    (CPU_data_master_granted_onchip_RAM_s1),
      .CPU_data_master_granted_onchip_ROM_s1                    (CPU_data_master_granted_onchip_ROM_s1),
      .CPU_data_master_irq                                      (CPU_data_master_irq),
      .CPU_data_master_qualified_request_CPU_jtag_debug_module  (CPU_data_master_qualified_request_CPU_jtag_debug_module),
      .CPU_data_master_qualified_request_KEY_PIO_s1             (CPU_data_master_qualified_request_KEY_PIO_s1),
      .CPU_data_master_qualified_request_LED_PIO_s1             (CPU_data_master_qualified_request_LED_PIO_s1),
      .CPU_data_master_qualified_request_onchip_RAM_s1          (CPU_data_master_qualified_request_onchip_RAM_s1),
      .CPU_data_master_qualified_request_onchip_ROM_s1          (CPU_data_master_qualified_request_onchip_ROM_s1),
      .CPU_data_master_read                                     (CPU_data_master_read),
      .CPU_data_master_read_data_valid_CPU_jtag_debug_module    (CPU_data_master_read_data_valid_CPU_jtag_debug_module),
      .CPU_data_master_read_data_valid_KEY_PIO_s1               (CPU_data_master_read_data_valid_KEY_PIO_s1),
      .CPU_data_master_read_data_valid_LED_PIO_s1               (CPU_data_master_read_data_valid_LED_PIO_s1),
      .CPU_data_master_read_data_valid_onchip_RAM_s1            (CPU_data_master_read_data_valid_onchip_RAM_s1),
      .CPU_data_master_read_data_valid_onchip_ROM_s1            (CPU_data_master_read_data_valid_onchip_ROM_s1),
      .CPU_data_master_readdata                                 (CPU_data_master_readdata),
      .CPU_data_master_requests_CPU_jtag_debug_module           (CPU_data_master_requests_CPU_jtag_debug_module),
      .CPU_data_master_requests_KEY_PIO_s1                      (CPU_data_master_requests_KEY_PIO_s1),
      .CPU_data_master_requests_LED_PIO_s1                      (CPU_data_master_requests_LED_PIO_s1),
      .CPU_data_master_requests_onchip_RAM_s1                   (CPU_data_master_requests_onchip_RAM_s1),
      .CPU_data_master_requests_onchip_ROM_s1                   (CPU_data_master_requests_onchip_ROM_s1),
      .CPU_data_master_waitrequest                              (CPU_data_master_waitrequest),
      .CPU_data_master_write                                    (CPU_data_master_write),
      .CPU_jtag_debug_module_readdata_from_sa                   (CPU_jtag_debug_module_readdata_from_sa),
      .KEY_PIO_s1_irq_from_sa                                   (KEY_PIO_s1_irq_from_sa),
      .KEY_PIO_s1_readdata_from_sa                              (KEY_PIO_s1_readdata_from_sa),
      .clk                                                      (SYS_CLK),
      .d1_CPU_jtag_debug_module_end_xfer                        (d1_CPU_jtag_debug_module_end_xfer),
      .d1_KEY_PIO_s1_end_xfer                                   (d1_KEY_PIO_s1_end_xfer),
      .d1_LED_PIO_s1_end_xfer                                   (d1_LED_PIO_s1_end_xfer),
      .d1_onchip_RAM_s1_end_xfer                                (d1_onchip_RAM_s1_end_xfer),
      .d1_onchip_ROM_s1_end_xfer                                (d1_onchip_ROM_s1_end_xfer),
      .onchip_RAM_s1_readdata_from_sa                           (onchip_RAM_s1_readdata_from_sa),
      .onchip_ROM_s1_readdata_from_sa                           (onchip_ROM_s1_readdata_from_sa),
      .registered_CPU_data_master_read_data_valid_onchip_RAM_s1 (registered_CPU_data_master_read_data_valid_onchip_RAM_s1),
      .registered_CPU_data_master_read_data_valid_onchip_ROM_s1 (registered_CPU_data_master_read_data_valid_onchip_ROM_s1),
      .reset_n                                                  (SYS_CLK_reset_n)
    );

  CPU_instruction_master_arbitrator the_CPU_instruction_master
    (
      .CPU_instruction_master_address                                 (CPU_instruction_master_address),
      .CPU_instruction_master_address_to_slave                        (CPU_instruction_master_address_to_slave),
      .CPU_instruction_master_granted_CPU_jtag_debug_module           (CPU_instruction_master_granted_CPU_jtag_debug_module),
      .CPU_instruction_master_granted_onchip_RAM_s1                   (CPU_instruction_master_granted_onchip_RAM_s1),
      .CPU_instruction_master_granted_onchip_ROM_s1                   (CPU_instruction_master_granted_onchip_ROM_s1),
      .CPU_instruction_master_latency_counter                         (CPU_instruction_master_latency_counter),
      .CPU_instruction_master_qualified_request_CPU_jtag_debug_module (CPU_instruction_master_qualified_request_CPU_jtag_debug_module),
      .CPU_instruction_master_qualified_request_onchip_RAM_s1         (CPU_instruction_master_qualified_request_onchip_RAM_s1),
      .CPU_instruction_master_qualified_request_onchip_ROM_s1         (CPU_instruction_master_qualified_request_onchip_ROM_s1),
      .CPU_instruction_master_read                                    (CPU_instruction_master_read),
      .CPU_instruction_master_read_data_valid_CPU_jtag_debug_module   (CPU_instruction_master_read_data_valid_CPU_jtag_debug_module),
      .CPU_instruction_master_read_data_valid_onchip_RAM_s1           (CPU_instruction_master_read_data_valid_onchip_RAM_s1),
      .CPU_instruction_master_read_data_valid_onchip_ROM_s1           (CPU_instruction_master_read_data_valid_onchip_ROM_s1),
      .CPU_instruction_master_readdata                                (CPU_instruction_master_readdata),
      .CPU_instruction_master_readdatavalid                           (CPU_instruction_master_readdatavalid),
      .CPU_instruction_master_requests_CPU_jtag_debug_module          (CPU_instruction_master_requests_CPU_jtag_debug_module),
      .CPU_instruction_master_requests_onchip_RAM_s1                  (CPU_instruction_master_requests_onchip_RAM_s1),
      .CPU_instruction_master_requests_onchip_ROM_s1                  (CPU_instruction_master_requests_onchip_ROM_s1),
      .CPU_instruction_master_waitrequest                             (CPU_instruction_master_waitrequest),
      .CPU_jtag_debug_module_readdata_from_sa                         (CPU_jtag_debug_module_readdata_from_sa),
      .clk                                                            (SYS_CLK),
      .d1_CPU_jtag_debug_module_end_xfer                              (d1_CPU_jtag_debug_module_end_xfer),
      .d1_onchip_RAM_s1_end_xfer                                      (d1_onchip_RAM_s1_end_xfer),
      .d1_onchip_ROM_s1_end_xfer                                      (d1_onchip_ROM_s1_end_xfer),
      .onchip_RAM_s1_readdata_from_sa                                 (onchip_RAM_s1_readdata_from_sa),
      .onchip_ROM_s1_readdata_from_sa                                 (onchip_ROM_s1_readdata_from_sa),
      .reset_n                                                        (SYS_CLK_reset_n)
    );

  CPU the_CPU
    (
      .clk                                   (SYS_CLK),
      .d_address                             (CPU_data_master_address),
      .d_byteenable                          (CPU_data_master_byteenable),
      .d_irq                                 (CPU_data_master_irq),
      .d_read                                (CPU_data_master_read),
      .d_readdata                            (CPU_data_master_readdata),
      .d_waitrequest                         (CPU_data_master_waitrequest),
      .d_write                               (CPU_data_master_write),
      .d_writedata                           (CPU_data_master_writedata),
      .i_address                             (CPU_instruction_master_address),
      .i_read                                (CPU_instruction_master_read),
      .i_readdata                            (CPU_instruction_master_readdata),
      .i_readdatavalid                       (CPU_instruction_master_readdatavalid),
      .i_waitrequest                         (CPU_instruction_master_waitrequest),
      .jtag_debug_module_address             (CPU_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (CPU_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (CPU_jtag_debug_module_byteenable),
      .jtag_debug_module_clk                 (SYS_CLK),
      .jtag_debug_module_debugaccess         (CPU_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (CPU_data_master_debugaccess),
      .jtag_debug_module_readdata            (CPU_jtag_debug_module_readdata),
      .jtag_debug_module_reset               (CPU_jtag_debug_module_reset),
      .jtag_debug_module_resetrequest        (CPU_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (CPU_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (CPU_jtag_debug_module_write),
      .jtag_debug_module_writedata           (CPU_jtag_debug_module_writedata),
      .reset_n                               (CPU_jtag_debug_module_reset_n)
    );

  KEY_PIO_s1_arbitrator the_KEY_PIO_s1
    (
      .CPU_data_master_address_to_slave             (CPU_data_master_address_to_slave),
      .CPU_data_master_granted_KEY_PIO_s1           (CPU_data_master_granted_KEY_PIO_s1),
      .CPU_data_master_qualified_request_KEY_PIO_s1 (CPU_data_master_qualified_request_KEY_PIO_s1),
      .CPU_data_master_read                         (CPU_data_master_read),
      .CPU_data_master_read_data_valid_KEY_PIO_s1   (CPU_data_master_read_data_valid_KEY_PIO_s1),
      .CPU_data_master_requests_KEY_PIO_s1          (CPU_data_master_requests_KEY_PIO_s1),
      .CPU_data_master_waitrequest                  (CPU_data_master_waitrequest),
      .CPU_data_master_write                        (CPU_data_master_write),
      .CPU_data_master_writedata                    (CPU_data_master_writedata),
      .KEY_PIO_s1_address                           (KEY_PIO_s1_address),
      .KEY_PIO_s1_chipselect                        (KEY_PIO_s1_chipselect),
      .KEY_PIO_s1_irq                               (KEY_PIO_s1_irq),
      .KEY_PIO_s1_irq_from_sa                       (KEY_PIO_s1_irq_from_sa),
      .KEY_PIO_s1_readdata                          (KEY_PIO_s1_readdata),
      .KEY_PIO_s1_readdata_from_sa                  (KEY_PIO_s1_readdata_from_sa),
      .KEY_PIO_s1_reset_n                           (KEY_PIO_s1_reset_n),
      .KEY_PIO_s1_write_n                           (KEY_PIO_s1_write_n),
      .KEY_PIO_s1_writedata                         (KEY_PIO_s1_writedata),
      .clk                                          (SYS_CLK),
      .d1_KEY_PIO_s1_end_xfer                       (d1_KEY_PIO_s1_end_xfer),
      .reset_n                                      (SYS_CLK_reset_n)
    );

  KEY_PIO the_KEY_PIO
    (
      .address    (KEY_PIO_s1_address),
      .chipselect (KEY_PIO_s1_chipselect),
      .clk        (SYS_CLK),
      .in_port    (in_port_to_the_KEY_PIO),
      .irq        (KEY_PIO_s1_irq),
      .readdata   (KEY_PIO_s1_readdata),
      .reset_n    (KEY_PIO_s1_reset_n),
      .write_n    (KEY_PIO_s1_write_n),
      .writedata  (KEY_PIO_s1_writedata)
    );

  LED_PIO_s1_arbitrator the_LED_PIO_s1
    (
      .CPU_data_master_address_to_slave             (CPU_data_master_address_to_slave),
      .CPU_data_master_byteenable                   (CPU_data_master_byteenable),
      .CPU_data_master_granted_LED_PIO_s1           (CPU_data_master_granted_LED_PIO_s1),
      .CPU_data_master_qualified_request_LED_PIO_s1 (CPU_data_master_qualified_request_LED_PIO_s1),
      .CPU_data_master_read                         (CPU_data_master_read),
      .CPU_data_master_read_data_valid_LED_PIO_s1   (CPU_data_master_read_data_valid_LED_PIO_s1),
      .CPU_data_master_requests_LED_PIO_s1          (CPU_data_master_requests_LED_PIO_s1),
      .CPU_data_master_waitrequest                  (CPU_data_master_waitrequest),
      .CPU_data_master_write                        (CPU_data_master_write),
      .CPU_data_master_writedata                    (CPU_data_master_writedata),
      .LED_PIO_s1_address                           (LED_PIO_s1_address),
      .LED_PIO_s1_chipselect                        (LED_PIO_s1_chipselect),
      .LED_PIO_s1_reset_n                           (LED_PIO_s1_reset_n),
      .LED_PIO_s1_write_n                           (LED_PIO_s1_write_n),
      .LED_PIO_s1_writedata                         (LED_PIO_s1_writedata),
      .clk                                          (SYS_CLK),
      .d1_LED_PIO_s1_end_xfer                       (d1_LED_PIO_s1_end_xfer),
      .reset_n                                      (SYS_CLK_reset_n)
    );

  LED_PIO the_LED_PIO
    (
      .address    (LED_PIO_s1_address),
      .chipselect (LED_PIO_s1_chipselect),
      .clk        (SYS_CLK),
      .out_port   (out_port_from_the_LED_PIO),
      .reset_n    (LED_PIO_s1_reset_n),
      .write_n    (LED_PIO_s1_write_n),
      .writedata  (LED_PIO_s1_writedata)
    );

  onchip_RAM_s1_arbitrator the_onchip_RAM_s1
    (
      .CPU_data_master_address_to_slave                         (CPU_data_master_address_to_slave),
      .CPU_data_master_byteenable                               (CPU_data_master_byteenable),
      .CPU_data_master_granted_onchip_RAM_s1                    (CPU_data_master_granted_onchip_RAM_s1),
      .CPU_data_master_qualified_request_onchip_RAM_s1          (CPU_data_master_qualified_request_onchip_RAM_s1),
      .CPU_data_master_read                                     (CPU_data_master_read),
      .CPU_data_master_read_data_valid_onchip_RAM_s1            (CPU_data_master_read_data_valid_onchip_RAM_s1),
      .CPU_data_master_requests_onchip_RAM_s1                   (CPU_data_master_requests_onchip_RAM_s1),
      .CPU_data_master_waitrequest                              (CPU_data_master_waitrequest),
      .CPU_data_master_write                                    (CPU_data_master_write),
      .CPU_data_master_writedata                                (CPU_data_master_writedata),
      .CPU_instruction_master_address_to_slave                  (CPU_instruction_master_address_to_slave),
      .CPU_instruction_master_granted_onchip_RAM_s1             (CPU_instruction_master_granted_onchip_RAM_s1),
      .CPU_instruction_master_latency_counter                   (CPU_instruction_master_latency_counter),
      .CPU_instruction_master_qualified_request_onchip_RAM_s1   (CPU_instruction_master_qualified_request_onchip_RAM_s1),
      .CPU_instruction_master_read                              (CPU_instruction_master_read),
      .CPU_instruction_master_read_data_valid_onchip_RAM_s1     (CPU_instruction_master_read_data_valid_onchip_RAM_s1),
      .CPU_instruction_master_requests_onchip_RAM_s1            (CPU_instruction_master_requests_onchip_RAM_s1),
      .clk                                                      (SYS_CLK),
      .d1_onchip_RAM_s1_end_xfer                                (d1_onchip_RAM_s1_end_xfer),
      .onchip_RAM_s1_address                                    (onchip_RAM_s1_address),
      .onchip_RAM_s1_byteenable                                 (onchip_RAM_s1_byteenable),
      .onchip_RAM_s1_chipselect                                 (onchip_RAM_s1_chipselect),
      .onchip_RAM_s1_clken                                      (onchip_RAM_s1_clken),
      .onchip_RAM_s1_readdata                                   (onchip_RAM_s1_readdata),
      .onchip_RAM_s1_readdata_from_sa                           (onchip_RAM_s1_readdata_from_sa),
      .onchip_RAM_s1_write                                      (onchip_RAM_s1_write),
      .onchip_RAM_s1_writedata                                  (onchip_RAM_s1_writedata),
      .registered_CPU_data_master_read_data_valid_onchip_RAM_s1 (registered_CPU_data_master_read_data_valid_onchip_RAM_s1),
      .reset_n                                                  (SYS_CLK_reset_n)
    );

  onchip_RAM the_onchip_RAM
    (
      .address    (onchip_RAM_s1_address),
      .byteenable (onchip_RAM_s1_byteenable),
      .chipselect (onchip_RAM_s1_chipselect),
      .clk        (SYS_CLK),
      .clken      (onchip_RAM_s1_clken),
      .readdata   (onchip_RAM_s1_readdata),
      .write      (onchip_RAM_s1_write),
      .writedata  (onchip_RAM_s1_writedata)
    );

  onchip_ROM_s1_arbitrator the_onchip_ROM_s1
    (
      .CPU_data_master_address_to_slave                         (CPU_data_master_address_to_slave),
      .CPU_data_master_byteenable                               (CPU_data_master_byteenable),
      .CPU_data_master_debugaccess                              (CPU_data_master_debugaccess),
      .CPU_data_master_granted_onchip_ROM_s1                    (CPU_data_master_granted_onchip_ROM_s1),
      .CPU_data_master_qualified_request_onchip_ROM_s1          (CPU_data_master_qualified_request_onchip_ROM_s1),
      .CPU_data_master_read                                     (CPU_data_master_read),
      .CPU_data_master_read_data_valid_onchip_ROM_s1            (CPU_data_master_read_data_valid_onchip_ROM_s1),
      .CPU_data_master_requests_onchip_ROM_s1                   (CPU_data_master_requests_onchip_ROM_s1),
      .CPU_data_master_waitrequest                              (CPU_data_master_waitrequest),
      .CPU_data_master_write                                    (CPU_data_master_write),
      .CPU_data_master_writedata                                (CPU_data_master_writedata),
      .CPU_instruction_master_address_to_slave                  (CPU_instruction_master_address_to_slave),
      .CPU_instruction_master_granted_onchip_ROM_s1             (CPU_instruction_master_granted_onchip_ROM_s1),
      .CPU_instruction_master_latency_counter                   (CPU_instruction_master_latency_counter),
      .CPU_instruction_master_qualified_request_onchip_ROM_s1   (CPU_instruction_master_qualified_request_onchip_ROM_s1),
      .CPU_instruction_master_read                              (CPU_instruction_master_read),
      .CPU_instruction_master_read_data_valid_onchip_ROM_s1     (CPU_instruction_master_read_data_valid_onchip_ROM_s1),
      .CPU_instruction_master_requests_onchip_ROM_s1            (CPU_instruction_master_requests_onchip_ROM_s1),
      .clk                                                      (SYS_CLK),
      .d1_onchip_ROM_s1_end_xfer                                (d1_onchip_ROM_s1_end_xfer),
      .onchip_ROM_s1_address                                    (onchip_ROM_s1_address),
      .onchip_ROM_s1_byteenable                                 (onchip_ROM_s1_byteenable),
      .onchip_ROM_s1_chipselect                                 (onchip_ROM_s1_chipselect),
      .onchip_ROM_s1_clken                                      (onchip_ROM_s1_clken),
      .onchip_ROM_s1_debugaccess                                (onchip_ROM_s1_debugaccess),
      .onchip_ROM_s1_readdata                                   (onchip_ROM_s1_readdata),
      .onchip_ROM_s1_readdata_from_sa                           (onchip_ROM_s1_readdata_from_sa),
      .onchip_ROM_s1_write                                      (onchip_ROM_s1_write),
      .onchip_ROM_s1_writedata                                  (onchip_ROM_s1_writedata),
      .registered_CPU_data_master_read_data_valid_onchip_ROM_s1 (registered_CPU_data_master_read_data_valid_onchip_ROM_s1),
      .reset_n                                                  (SYS_CLK_reset_n)
    );

  onchip_ROM the_onchip_ROM
    (
      .address     (onchip_ROM_s1_address),
      .byteenable  (onchip_ROM_s1_byteenable),
      .chipselect  (onchip_ROM_s1_chipselect),
      .clk         (SYS_CLK),
      .clken       (onchip_ROM_s1_clken),
      .debugaccess (onchip_ROM_s1_debugaccess),
      .readdata    (onchip_ROM_s1_readdata),
      .write       (onchip_ROM_s1_write),
      .writedata   (onchip_ROM_s1_writedata)
    );

  //reset is asserted asynchronously and deasserted synchronously
  nios_ucos_reset_SYS_CLK_domain_synch_module nios_ucos_reset_SYS_CLK_domain_synch
    (
      .clk      (SYS_CLK),
      .data_in  (1'b1),
      .data_out (SYS_CLK_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    CPU_jtag_debug_module_resetrequest_from_sa |
    CPU_jtag_debug_module_resetrequest_from_sa);


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "c:/altera/72/quartus/eda/sim_lib/altera_mf.v"
`include "c:/altera/72/quartus/eda/sim_lib/220model.v"
`include "c:/altera/72/quartus/eda/sim_lib/sgate.v"
`include "onchip_ROM.v"
`include "CPU_test_bench.v"
`include "CPU_jtag_debug_module.v"
`include "CPU_jtag_debug_module_wrapper.v"
`include "CPU.v"
`include "LED_PIO.v"
`include "onchip_RAM.v"
`include "KEY_PIO.v"

`timescale 1ns / 1ps

module test_bench 
;


  reg              SYS_CLK;
  wire             clk;
  wire    [  3: 0] in_port_to_the_KEY_PIO;
  wire    [  7: 0] out_port_from_the_LED_PIO;
  reg              reset_n;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  nios_ucos DUT
    (
      .SYS_CLK                   (SYS_CLK),
      .in_port_to_the_KEY_PIO    (in_port_to_the_KEY_PIO),
      .out_port_from_the_LED_PIO (out_port_from_the_LED_PIO),
      .reset_n                   (reset_n)
    );

  initial
    SYS_CLK = 1'b0;
  always
    #10 SYS_CLK <= ~SYS_CLK;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on