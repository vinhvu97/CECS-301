`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: Lab7_TopModule
// Project: Lab 7
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 16, 2018
//
// Purpose: 
//
// Notes:   
////////////////////////////////////////////////////////////////////////////////
module Lab7_TopModule(clk, reset, step, mem_W_en, adr_sel, s_sel, pc_ld, pc_inc, 
							 reg_W_en, ir_ld, a, b, c, d, e, f, g, anode, C, N, Z);
	// Input declarations						 
	input clk   , reset , step   , mem_W_en , adr_sel, 
	      s_sel , pc_ld , pc_inc , reg_W_en , ir_ld ;
	
	// Output declarations
	output       a , b , c , d , e , f , g;
	output       C , N , Z;
	output [7:0] anode;
	
	// Wire declarations to interconnect the modules 
	wire        wire_clock , wire_shot , ram_shot;
	wire [15:0] Din        , Dout;
	wire [15:0] addr;
	
	// Instantiate the clock divider module to generate a 500Hz clock
	clk_500Hz          clk0        (.clk_in(clk), 
									        .reset(reset), 
									        .clk_out(wire_clock));
	
   // Instantiate two one-shot debounces to create two one-shot's.  
	// One is for the control processing unit and one is for the RAM. 
	debounce           shot_0      (.clk(wire_clock), 
										     .reset(reset), 
										     .D_in(step), 
										     .D_out(wire_shot));
	debounce			    shot_RAM    (.clk(wire_clock), 
										     .reset(reset), 
										     .D_in(mem_W_en), 
										     .D_out(ram_shot)); 
	
	// Instantiate the CPU_EU to execute functions based on user inputs 
	// which come from the board's switches 
	CPU_EU             cpu0        (.clk(wire_shot), 
									        .reset(reset), 
									        .din(Din), 
									        .address(addr), 
									        .dout(Dout), 
									        .adr_sel(adr_sel),
					                    .s_sel(s_sel), 
									        .pc_ld(pc_ld), 
									        .pc_inc(pc_inc), 
									        .reg_W_en(reg_W_en), 
									        .ir_ld(ir_ld), 
					                    .C(C), .N(N), .Z(Z));
	
	// Instantiate the RAM memory module to store or to write memory from
	// the CPU_EU module 
	ram                ram0        (.clk(clk), 
	                                .we(ram_shot), 
									        .addr({addr[7:0]}), 
									        .din(Dout), 
									        .dout(Din));
	
	// Instantiate the display controller to output Dout and address
	// to the 7-display segment 
	display_controller controller0 (.clk(clk), 
	                                .reset(reset),
											  .S(Dout), 
											  .R(addr), 
											  .anode(anode), 
							              .a(a), .b(b), .c(c), .d(d), 
											  .e(e), .f(f), .g(g));
	
endmodule
