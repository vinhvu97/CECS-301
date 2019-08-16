`timescale 1ns / 1ps
/****************************************************
* File name: one_shot_pulse
* Project: Lab 1_301
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Jan. 31, 2017
*
* Purpose: This module is designed to wait for the
* the amount of time necessary for stablization of 
* the output of the switch. The amount of time require for
* a switch to stop bouncing is about 10 to 20 ms. We are
* going to wait 20 ms. The technique this module used to
* wait for stabilization is one-shot. After waiting for
* stablization of the switch, a one shot output signal 
* may be created, that will only last for one incoming 
* clock tick. 
*
*****************************************************/
module one_shot_pulse(D_in,clk_in,reset,D_out);
	input D_in, clk_in, reset;
	output D_out;
	wire D_out;
	
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	always @ (posedge clk_in or posedge reset)
		if (reset==1'b1)
			{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
		else begin
			q9<=q8; q8<=q7; q7<=q6; q6<=q5; q5<=q4; 
			q4<=q3; q3<=q2; q2<=q1; q1<=q0; q0<=D_in;  //shifting from right to left 
		end
	assign D_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;  //Make sure all the outputs are 1 beside q9

endmodule
