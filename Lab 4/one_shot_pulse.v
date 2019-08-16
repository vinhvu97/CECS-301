`timescale 1ns / 1ps
/****************************************************
* File name: one_shot_pulse
* Project: Lab 2
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 15, 2017
*
* Purpose: This module is designed to wait for the
* the amount of time necessary for stablization of 
* the output of the switch. When the switch is pressed,
* there is a signal, generated for 10 ms to 20 ms.  
* After waiting for 20 ms, it will send out a one-shot
* pulse to the output (D_out). The pulse will be created 
* for only one positive-edge clock tick at a time. 
*
* Note: The module is designed to allow users to have
* control over clock ticks one push at a time. 
*
*****************************************************/
module one_shot_pulse(D_in,clk,reset,D_out);
	
	// Input and Output Declarations
	input  D_in, clk, reset;
	output D_out;
	wire   D_out;
	
	// Initialize 10 1-bit register values
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	
	always @ (posedge clk or posedge reset)
	
		// When reset is asserted, all the registers get 0 as their values
		if (reset==1'b1)
			{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
			
		// Shifting new sample that is on the D_in 
		else begin
			q9<=q8; q8<=q7; q7<=q6; q6<=q5; q5<=q4; 
			q4<=q3; q3<=q2; q2<=q1; q1<=q0; q0<=D_in;  
			
		end // end of else
		
	// Make sure all the outputs are 1 beside q9 
	// Create the debounced one-shot D_out pulse 
	assign D_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;  

endmodule
