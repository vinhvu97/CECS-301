`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: TopModule_6
// Project: Lab 6
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 5, 2018
//
// Purpose: This is the top level module used to tie all the features of lab 6
//				together, This top level implements and instantiates the clk_500Hz, 
//				debounce, Integer_Datapath, and display_controller to load and display
//				onto the Nexys4DDR FPGA board
//
// Notes:   This module is easy to understand when top level diagram is drawn out
//////////////////////////////////////////////////////////////////////////////////
module TopModule_6(clk, reset, step, W_Adr, S_Adr, R_Adr, S_Sel, ALU_OP, anode, 
						 a, b, c, d, e, f, g);
						 
	// Input declarations
	input        clk   , reset , step , S_Sel ;
	input  [2:0] W_Adr , S_Adr , R_Adr ;
	input  [3:0] ALU_OP ;
	
	// Output declarations
	output [7:0] anode ;
	output       a , b , c , d , e , f , g ;
	
	// Wire declarations to interconnect the modules
	wire        clk_out , shot_out ;
	wire [15:0] Reg_Out , Alu_Out ;
	
	// Instantiate the clock divider to get a 500 Hz clock
	clk_500Hz          clk0     ( .clk_in(clk), 
										   .reset(reset), 
										   .clk_out(clk_out));
	
	// Instantiate the debounce module to send a one-shot pulse
	// to the Integer Datapath file 
	debounce           shot0    ( .clk(clk_out), 
										   .reset(reset), 
										   .D_in(step), 
										   .D_out(shot_out));
	
	// Instantiate the integer datapath module that contains register
	// files, mux, and Alu where all arithmetic operations take place
	Integer_Datapath   IDP      ( .clk(shot_out),
											.reset(reset),
											.W_En({1'b1}),
											.DS({16'hAA55}),
											.W_Adr(W_Adr),
											.S_Adr(S_Adr),
											.R_Adr(R_Adr),
											.S_Sel(S_Sel),
											.C(C), .N(N), .Z(Z),
											.ALU_OP(ALU_OP),
											.Reg_Out(Reg_Out),
											.Alu_Out(Alu_Out));
										  
	// Instantiate the display controller module to output the results
	// from the arithmatic operations 
	display_controller display0 ( .clk(clk), 
										   .reset(reset), 
										   .R(Reg_Out), 
										   .S(Alu_Out), 
										   .anode(anode), 
										   .a(a) , .b(b) , .c(c) , .d(d),
										   .e(e) , .f(f) , .g(g));
										  
	
endmodule
