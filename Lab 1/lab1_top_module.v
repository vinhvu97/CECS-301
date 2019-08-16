`timescale 1ns / 1ps
/****************************************************
* File name: lab1_top_module
* Project: Lab 1_301
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 7, 2017
*
* Purpose: This module a top level module. The module
* is constructed based on the top level diagram provided
* within the lab 1 instructions. This top level implements 
* the clk_div, one_shot_pulse, and shift_reg modules
* together to implement the entire lab onto the board. 
*
* Notes: 
*****************************************************/
module lab1_top_module(clk_100MHZ, reset, step, M, SI, D, Q);
	input clk_100MHZ, reset, step, SI;
	input [1:0] M;
	input [3:0] D;
	output [3:0] Q;
	
	wire clk;
	wire shot; 
	
	clk_div clk0(.clk_in(clk_100MHZ), .reset(reset), .clk_out(clk)); 
	one_shot_pulse pulse0( .clk_in(clk), .reset(reset), .D_in(step), .D_out(shot));
	shift_reg reg0( .clk(shot), .reset(reset), .M(M), .SI(SI), .D(D), .Q(Q));
	
endmodule
