`timescale 1ns / 1ps
/****************************************************
* File name: clk_div
* Project: Lab 3
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 22, 2017
*
* Purpose: This module is a clock divider. Clock divider
* takes in the default frequency 100MHz and divides it
* to 500Hz by using 
*
* Notes: The assignment required the clk_out to be 500Hz.
* By using the formula (100MHz/500Hz)/2 we get 100,000.
*****************************************************/
module clk_div(clk_in, reset, clk_out);
	
	//Inputs and Outputs declaration
	input  clk_in, reset;
	output clk_out;
	reg    clk_out;
	
	//int i to keep track of clk
	integer i;
	
	//**********************************************************************
	// The following verilog code will "divide" an incoming clock 
	// by the 32-bit decimal value specified in the "if condition"
	//
	// The value of the counter that counts the incoming clock ticks
	// is equal to [ (Incoming Freq/Outgoing Freq) / 2]
	//**********************************************************************
	
	always @ (posedge clk_in or posedge reset) begin
		if (reset == 1'b1) begin
			i       = 0;
			clk_out = 0;
		end
	// got a clock, so increment the counter and
	// test to see if half a period has elapsed
		else begin
			i = i+1;
			if (i >= 100000) begin
				clk_out = ~clk_out;
				i = 0;
			end // if
		end // else
		
	end // always

endmodule
