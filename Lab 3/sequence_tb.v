`timescale 1ps / 100fs

module sequence_tb;

	// DATE:     Thursday Feb 27 2018
	// AUTHOR:   Vinh Vu
	// EMAIL:    vincentvinhvu@yahoo.com
	// MODULE:   sequence_tb
	// FILENAME: sequence_tb.v
	// PROJECT:  Lab3.xise
	// VERSION:  Version 1.4

	// Inputs
	reg clk;
	reg reset;
	reg X;
	reg M;

	// Outputs
	wire       Z;
	wire [2:0] Q;

	// Local variable declarations
	reg [48:1] sequence_pattern;
	integer    i;
	
	// Generate 10ps clock
	always
		#5 clk = ~clk;
		
	// Instantiate the Unit Under Test (UUT)
	sequence_detector uut (
		.clk(clk), 
		.reset(reset), 
		.X(X), 
		.M(M), 
		.Z(Z), 
		.Q(Q)
	);

	//Initial block for the sequence of "test vectors," applied every clock cycle 
	initial begin
		$timeformat(-12, 1, " ps", 8);
		clk   = 0;
		reset = 0;
		X     = 0;
		M     = 0;
		
		//Input sequence pattern to be detected 
		sequence_pattern= 48'b0101_0110_1011_0001_1010_1101_0110_1110_1001_0110_0101_1011;
		
		@(negedge clk)
			reset=1;
		@(posedge clk)
			reset=0;
			
			// Moore implementation (M=0). To simulate the Mealy implementation,
			// set (M=1) and "re-run" the simulation to get new waveform
			M=0;
			
		// This loop will "feed" the sequence detctor with the
		// test sequence pattern from MSB to LSB
		for (i=48;i>0;i=i-1) begin
		
			// channge inputs on negative edge of clock
			@(negedge clk)
				X = sequence_pattern[i];
				
			// display outputs after the positive clocks
			@(posedge clk)
				#1 $display ("Time=%t X=%b Q=%b Z=%b", $time, X, Q, Z);
		
		end // enf of for-loop
		
			$stop;
			
	end // end of initial block
      
endmodule

