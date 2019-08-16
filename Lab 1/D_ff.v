`timescale 1ns / 1ps
/****************************************************
* File name: D_ff
* Project: Lab 1_301
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 1, 2017
*
* Purpose: This module is a D flip-flop. It has one 
* data input D and a clock and reset input. It operates
* on the positive edge of clock if reset is inactive.
* If reset is active, then Q is 0 no matter. When reset
* is inactive, Q gets D on active edge of clock.  
*
*****************************************************/
module D_ff(clk, reset, D, Q);
	input clk, reset, D;
	output Q;
	reg Q;
	always @ (posedge clk, posedge reset)
		if (reset) Q<=1'b0;  //Q is 0 when reset is on
		else Q<=D;    //this is when reset is 0, so Q gets D on active edge of clk


endmodule
