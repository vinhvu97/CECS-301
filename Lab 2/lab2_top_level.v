`timescale 1ns / 1ps
/****************************************************
* File name: lab2_top_level
* Project: Lab 2
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 16, 2017
*
* Purpose: This module is a top level module. It combines
* all the clk_div, one_shot_pulse, and sequence_detector. 
* The combination is derived from the top level diagram
* provided from the lab 2 instructions. 
*
* Notes: Top level modules connects all modules for
* implementation onto the board NEXYS. 
*****************************************************/
module lab2_top_level(clk_50MHz, reset, step, X, M, Z, Q);
	
	//Inputs and Outputs Declaration
	input clk_50MHz, reset, step, X, M;
	output Z;
	output [2:0] Q;
	
	/*Wires to pass data from clk_div module into one-shot
	* and from one shot to sequence detector module
	*/
	wire wire_clk, wire_shot;
	
	//Instantiates the clock divider to make a 500Hz clock
	clk_div clk0(.clk_in(clk_50MHz), .reset(reset), .clk_out(wire_clk));
	
	//Instantiates the one shot to produce a one-shot for one clock tick
	one_shot_pulse(.clk_in(wire_clk), .reset(reset), .D_in(step), .D_out(wire_shot));
	
	
	//Instantiates the sequence detector to dectect incoming sequence
	sequence_detector(.clk(wire_shot), .reset(reset), .X(X), .M(M), .Z(Z), .Q(Q));

endmodule
