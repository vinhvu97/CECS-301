`timescale 1ns / 1ps
/****************************************************
* File name: addr_seqr
* Project: Lab 4
* Designer: Vinh Vu & Zachery Takkesh
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 23, 2017
*
* Purpose: This module is the address sequencer. It
* increments the output address every time that a clk 
* tick occurs. The clock is controlled by the debounced 
* button
*
* Notes: 
*****************************************************/
module addr_seqr(clk, reset, addr);
	
	// Inputs and output declarations
	input        clk, reset;
	output [7:0] addr;
	reg    [7:0] addr;
	
	// When reset is active, the address is an 8-bit 0.
	// When reset is inactive, the address increments by 1
	// at every positive clock tick 
	always @ (posedge clk or posedge reset) begin
		if (reset==1'b1) 
			addr = 8'b0;
		else
			addr = addr+1;
		end //end of always block

endmodule
