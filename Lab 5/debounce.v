`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: debounce
// Project: Lab 5 
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: Mar. 15, 2018
//
// Purpose: The debounce module will wait for some amount of time for
//				stabilization from the input switch button on board.When a switch is
//				pushed, there is an unstablized electro-mechanical signal, generated 
//				for around 10 to 20 milisecond. After this module has waited for
//				20 miliseconds, it will send out a one-shot pulse to the 
//				output signal(D_out)and will be created to last for only one postive-
//				-edge clock tick at a time
//
// Notes:   This module allows user to control clock tick one button push at a time.
//////////////////////////////////////////////////////////////////////////////////
module debounce(clk, reset, D_out, D_in);

	// Tnitialize input and output variables
	input  D_in, reset, clk;
	output D_out;
	wire   D_out;
	
	// initialize 10 1-bit register values
	reg q9 , q8 , q7 , q6 , q5 , q4 , q3 , q2 , q1 , q0 ;
	
	always @(posedge clk or posedge reset)
		
		// When reset is asserted, all the registers get 0 as their values
		if(reset == 1'b1)
			{q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
		
		// Shifting new sample that is on the D_in one bit at a time	
		else begin 
			q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4; 			
			q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= D_in; 
			
		end //end of else 
	
	// Create the debounced, one-shot output pulse
	// Make sure all the D_out outputs are 1's beside q9
	assign D_out = !q9 & q8 & q7 & q6 & q5 &
						 q4 & q3 & q2 & q1 & q0; 

endmodule //end of one shot module