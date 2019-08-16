`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: PC
// Project: Lab 8
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 16, 2018
//
// Purpose: This 16-bit Program counter module has two purposes .One, this register
//				has a load enable, which will send data from the IDP module to
//				memory(RAM.V) if asserted. Two, This register also has an enable 
//				control for incrementing the program counter which contains the 
//				address (location) of the current instruction being executed.
//
// Notes: Only one enable signal can be High at a time
////////////////////////////////////////////////////////////////////////////////
module PC(clk, reset, pc_ld, pc_inc, Alu_Out, pc_out);

	//initialize inputs and outputs
	input 					clk, 
							 reset, 
							 pc_ld, 
							pc_inc;
	input 	 [15:0] Alu_Out;
	
	output reg [15:0] pc_out;
	

	always@(posedge clk or posedge reset)begin
		
		//if reset is asserted, program counter
		// gets value of Zero
		if(reset == 1'b1)
			pc_out <= 16'b0;
			
		//if reset is not asserted	
		else 
			//decision selection based on load and inc control signals
			case({pc_ld, pc_inc})
			
				//if pc_increment is enabled, 
				//add one to the program counter
				2'b0_1: pc_out <= pc_out + 1;
				
				//if pc_load is enabled, 
				//pass input Alu_Out to PC_out
				2'b1_0: pc_out <= Alu_Out;
				
				//if both enable signals are high
				// or low at the same time
				default: pc_out <= pc_out;
				
			endcase //end of case statement
			
	end //end of always block
	
endmodule //end of program counter