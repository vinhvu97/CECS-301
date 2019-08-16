`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: Lab8_TopModule
// Project: Lab 8
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: May 5, 2018
//
// Purpose: This is the top level module used to tie all the features of lab 8
//				together. Lab 8 consists of creating a full functioning 16-bit 
//				Reduced Instruction Set Computer(RISC) processor. This top level 
//				implements and instantiates two debounce, clk_500Hz, RISC_Processor,
//				RAM , memory-dump counter and display_controller to load 
//				and display	onto the Nexys4DDR FPGA board
//
// Notes:   This module is easy to understand when top level diagram is drawn out
//////////////////////////////////////////////////////////////////////////////////
module Lab8_TopModule(clk, reset, step_clk, step_mem, dump_mem, 
                      a, b, c, d, e, f, g, anode, status);
	// Input declarations						 
	input clk , reset , step_clk, step_mem, dump_mem;
	
	// Output declarations
	output       a , b , c , d , e , f , g;
	output [7:0] anode, status;
	
	// Wire declarations to interconnect the modules 
	wire        wire_clock ,RISC_shot , mem_dump_shot , mw_en;
	wire [15:0] madr, address, dout, din, mem_counter;
	
	// Instantiate the clock divider module to generate a 500Hz clock
	clk_500Hz          clk0        (.clk_in(clk), 
									        .reset(reset), 
									        .clk_out(wire_clock));
	
   // Instantiate two one-shot debounce to create two one-shot's.  
	// One is for the control processing unit and one is for the RAM. 
	debounce           shot_RISC0   (.clk(wire_clock), 
										     .reset(reset), 
										     .D_in(step_clk), 
										     .D_out(RISC_shot)),
				          shot_RAM1    (.clk(wire_clock), 
										     .reset(reset), 
										     .D_in(step_mem), 
										     .D_out(mem_dump_shot)); 
	
	// Instantiate the control processing unit
	RISC_Processor      cpu0        (.clk(RISC_shot), 
									        .reset(reset), 
									        .address(address), 
											  .D_in(din), 
											  .D_out(dout), 
											  .mw_en(mw_en), 
											  .status(status));
	
	// Instantiate the RAM module 
	ram                ram0        (.clk(clk), 
	                                .we(mw_en), 
									        .addr({madr[7:0]}), 
									        .din(dout), 
									        .dout(din));
	
	// Instantiate the display controller to output Dout and address
	// to the 7-display segment 
	display_controller controller0 (.clk(clk), 
	                                .reset(reset),
											  .S(din), 
											  .R({madr[7:0]}),  
											  .anode(anode), 
							              .a(a), .b(b), .c(c), .d(d), 
											  .e(e), .f(f), .g(g));
											  
	// Instantiates the memory dump that dumps the incrementing
	// counter out into the madr unless reset where counter
	// gets 0 
	mem_dump_counter 	dump_count0 (.clk(mem_dump_shot),
											 .reset(reset), 
										  	 .mem_counter(mem_counter));
											 
	// Determines whether to look at the incrementing counter 
	// or the address to display in the display controller 
	assign madr = (dump_mem == 1'b1) ? mem_counter : address;
	
endmodule //end of Top Level Module