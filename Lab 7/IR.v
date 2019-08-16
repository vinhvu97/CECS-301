`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: IR
// Project: Lab 7
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 16, 2018
//
// Purpose: Program counter module inputs Alu_Out from the IDP module. There are
//				two signals for two different functions that can be done with the
//          input data. When load is 0 and increment 1, Q gets incremented. 
//				When load is 1 and increment is 0, D goes to Q. 
//
// Notes:   The program counter cannot increments and output the results at the
//			   same time. The module can only perform 2 functions, everything else is 
//			   just load Q to Q.  
////////////////////////////////////////////////////////////////////////////////
module IR(clk, reset, ld, inc, D, Q);

	// Input declarations
	input        clk , reset , ld , inc;
	input [15:0] D;
	
	// Output declarations
	output reg [15:0] Q;
	
	always@(posedge clk or posedge reset)
	
		// If reset is asserted, pc_out is always 0
		if(reset == 1'b1)
			Q <= 16'b0;
		else 
			
			// Case for load and increment, active high
			case({ld, inc})
				2'b0_1: Q <= Q + 16'b1; // increment Q
				2'b1_0: Q <= D;         // load D
				default: Q <= Q;	      // Q gets Q as default
			endcase 

endmodule
