`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:34:26 02/17/2018
// Design Name:   sequence_detector
// Module Name:   C:/Users/Vinh/Documents/Vu_301/Lab3/lab3_tb.v
// Project Name:  Lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sequence_detector
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module lab3_tb;

	// Inputs
	reg clk;
	reg reset;
	reg X;
	reg M;

	// Outputs
	wire Z;
	wire [2:0] Q;

	reg [48:1] sequence_pattern;
	integer i; 
	// Instantiate the Unit Under Test (UUT)
	sequence_detector uut (
		.clk(clk), 
		.reset(reset), 
		.X(X), 
		.M(M), 
		.Z(Z), 
		.Q(Q)
	);
	
	always
		#5 clk=~clk;
		
	initial begin
		$timeformat(-12, 1, " ps", 8);
		clk = 0; reset = 0; M = 0; X = 0;

		sequence_pattern=48'b010101101011000110101101011011101001011001011011;
		@(negedge clk)
			reset=1;
		@(negedge clk)
			reset=0;
			
			M=0;
			
		for ( i=48; i>0; i=i-1) begin
			@(negedge clk)
				X = sequence_pattern[i];
			@(posedge clk)
				#1 $display ("Time=%t X=%b Q=%b Z=%b", $time, X, Q, Z);
		end
			$stop; 
	end
      