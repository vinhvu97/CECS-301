`timescale 1ns / 1ps
/****************************************************
* File name: lab3_top_level
* Project: Lab 3
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 25, 2017
*
* Purpose: This module is a top level module. It combines
* all the clk_div, one_shot_pulse, Hex_to_7Seg and 
* sequence_detector. The combination is derived from 
* the previous lab as well as instantiating the new
* module Hex_to_7Seg. Since the Hex_to_7Seg module intakes
* a 4-bit input and Q only has 3 bits, I added the MSB
* to be 0 to the value of Q does not change. 
*
* Notes: Top level modules connects all modules for
* implementation onto the board NEXYS. 
*****************************************************/
module lab3_top_level(clk_100MHz, reset, step, X, M, Z, a, b, c, d, e, f, g, anode);
	
	// Inputs and outputs declaration
	input        clk_100MHz , reset , M , X , step;
	output       Z;
	output [7:0] anode;
	output       a , b , c , d , e , f , g; 
	
	// Wires to pass data from clk_div module into one-shot
	// and from one shot to sequence detector module
	wire clk_wire , shot_wire;
	
	// Q wires to pass to sequence detector. It is not an output
	// because the assignment does not require Q to be displayed
	// on the LED's. 
	wire [2:0] Q; 
	
	// Instantiates the clock divider to make a 500Hz clock
	clk_div clk0(.clk_in(clk_100MHz) , .reset(reset) , .clk_out(clk_wire));
	
	//Instantiates the one shot to produce a one-shot pulse for one clock tick
	one_shot_pulse shot0(.clk_in(clk_wire) , .reset(reset) , .D_in(step) , .D_out(shot_wire));
	
	// Instantiates the sequence detector to detect an overlapping sequence of 010110
	sequence_detector detector2(.clk(shot_wire) , .reset(reset) , .M(M) , .X(X) , .Z(Z) , .Q(Q));
	
	// Instantiates the hex to 7 segment module to display Q onto the 7 segment
	// Since the module inputs 4 bits and Q only has 3 bit, the MSB is assigned
	// to 0 to meet the 4-bit requirement without changing Q value. 
	Hex_to_7Seg u4({1'b0 , Q} , a , b , c , d , e , f , g);
	
	// Anode assignment to turn off all displays beside the LSB. 
	// The hex value FE (11111110) turns off everything beside the 
	// last 7-segment display. 
	assign anode= 8'hFE;


endmodule
