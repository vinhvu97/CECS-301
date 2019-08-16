`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: mem_dump_counter
// Project: Lab 8
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 16, 2018
//
// Purpose: The mem_dump_counter holds the memory locations that are changed 
//				so the user can step through the memory to check appropriate
//				data within the memory.   
////////////////////////////////////////////////////////////////////////////////
module mem_dump_counter(clk, reset, mem_counter);

	// Input and output declarations
	input             clk, reset;
	output reg [15:0] mem_counter;
	
	always @ (posedge clk or posedge reset) begin
	
		// When reset is asserted, mem_counter is 0
		if (reset == 1'b1)
			mem_counter <= 16'b0;
			
		// Increment mem_counter
		else
			mem_counter <= mem_counter + 1;
			
		end //end of always block
	
endmodule //end of memory_dump counter
