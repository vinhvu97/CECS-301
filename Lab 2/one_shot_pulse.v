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
* the output of the switch. 

* Node: The amount of time require for a switch to 
* stop bouncing is about 10 to 20 ms. We are
* going to wait 20 ms. After waiting for stablization 
* of the switch, a one shot output signal may be 
* created, that will only last for one incoming 
* clock tick. 
*
*****************************************************/
module one_shot_pulse(D_in,clk_in,reset,D_out);
	
	//Input and Output Declarations
	input  D_in, clk_in, reset;
	output D_out;
	wire   D_out;
	
	reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;
	always @ (posedge clk_in or posedge reset)
		if (reset==1'b1)
			{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
			
		//shifting from right to left 
		else begin
			q9<=q8; q8<=q7; q7<=q6; q6<=q5; q5<=q4; 
			q4<=q3; q3<=q2; q2<=q1; q1<=q0; q0<=D_in;  
		end
		
	//Make sure all the outputs are 1 beside q9 to get a one-shot pulse
	assign D_out = !q9 & q8 & q7 & q6 & q5 & q4 & q3 & q2 & q1 & q0;  

endmodule
