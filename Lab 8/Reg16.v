`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
// File Name: reg16
// Project: Lab 8
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: Mar. 19, 2018
//
// Purpose:  The reg16 is a behavioral model of a 16-bit register with asynchronous
//           reset and a synchronous load for the Din input. The register has two
//           16-bit outputs, DA and DB. Both have tri-state outputs that are 
//				 controlled by signals sent out from the decoder. When the register 
//           does not receive the signal, the output ports are blocked or turned 
//				 off(High Impedance). When the register receives the signal the output 
//				 ports are open and the data is the outputed. 
//
// Notes:    This verilog module is not a regular register. It is a tri-state register
//           which means that its outputs are controlled by other signals. 
//////////////////////////////////////////////////////////////////////////////////
module reg16 (clk, reset, ld, oeA, oeB, Din, DA, DB);
	
	// Initialize inputs and outputs
	input  		  clk, reset, ld, oeA, oeB;
	input  [15:0] Din;
	output [15:0] DA, DB;
	
	// Initialize register to write upon
	reg 	 [15:0] Dout;
	
	// Behavioral section for writing to the register
	always@(posedge clk or posedge reset)
		if(reset) 
			Dout <=16'b0;
		else
			if (ld)
				  Dout <= Din;
			else Dout <= Dout;
	
	// Conditional continuous assignments for reading the register 
	assign DA = oeA ? Dout : 16'hz;
	assign DB = oeB ? Dout : 16'hz;

endmodule //end of reg16 module