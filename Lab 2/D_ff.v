`timescale 1ns / 1ps
/****************************************************
* File name: D_ff
* Project: Lab 2
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 15, 2017
*
* Purpose: This module is a D flip-flop. It has one 
* data input D and a clock and reset input. It operates
* on the positive edge of clock if reset is inactive.
* If reset is active, then Q is 0 no matter. When reset
* is inactive, Q gets D on active edge of clock.  
*
*****************************************************/
module D_ff(clk, reset, D, Q);
	
	//Inputs and outputs declaration
	input  clk, reset, D;
	output Q;
	reg    Q;
	
	//*****************************************
	// It operates at posedge of clk or reset.
	// If reset is 1, then Q gets 0 as its value.
	// If reset is 0, then Qgets D as its value. 
	//*****************************************
	always @ (posedge clk, posedge reset)
		if   (reset) Q<=1'b0;  
		else         Q<=D;    


endmodule
