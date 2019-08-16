`timescale 1ps / 100fs

module lab5_tb;

	// DATE: Mon Mar 19 2018
	// AUTHOR: Vinh Vu & Zachery Takkesh
	// EMAIL: vincentvinhvu@yahoo.com & zachtakkesh@gmail.com
	// MODULE: lab5_tb
	// FILENAME: lab5_tb.v
	// PROJECT: Lab5.xise
	// VERSION: Version 1.4
	
	// Inputs
	reg        clk;
	reg        reset;
	reg        we;
	reg [15:0] W;
	reg [2:0]  W_Addr;
	reg [2:0]  R_Addr;
	reg [2:0]  S_Addr;

	// Outputs
	wire [15:0] R;
	wire [15:0] S;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.clk(clk), 
		.reset(reset), 
		.we(we), 
		.W(W), 
		.W_Addr(W_Addr), 
		.R_Addr(R_Addr), 
		.S_Addr(S_Addr), 
		.R(R), 
		.S(S)
	);
	
	// Generate a clock
	always
		#10 clk = ~clk; 
	
	integer addr; 
	
	// Initial block to intialize all values 
	initial begin
	$timeformat (-12, 1, " ps", 8);
	
		// Initialize Inputs
		clk = 0;
		reset = 0;
		we = 0;
		W = 0;
		W_Addr = 0;
		R_Addr = 0;
		S_Addr = 0;
	
		// Initialize reset 
		@ (negedge clk)
			reset = 1;
		@ (negedge clk) 
			reset = 0;
	
			
		for ( addr = 0 ; addr < 8 ; addr = addr + 1) begin
			
			// At negative edge, the write-enable (we) is active which 
			// allows writing on memory W_Addr with W data. W is one's
			// complement of the address. 
			@ (negedge clk)
				R_Addr  = 0 ; 
				S_Addr  = 0 ;
				reset   = 0 ;
				we      = 1 ; 
				W_Addr  = addr ;
				W       = ~addr ; 
				end // end of for loop
		
		for ( addr = 0; addr < 4 ; addr = addr +1) begin
			
			// At negative edge, the output selects are incrementing to 
			// read memory values of R and S. 
			@ (negedge clk)
				we     = 0 ;
				W      = 0 ;
				W_Addr = 0 ;
				reset  = 0 ;
				R_Addr = addr ;
				S_Addr = addr + 4 ;
				
				// At positve edge, the output values for R and S are displayed
			@ (posedge clk)
				$display(" R_Addr = %h, R = %H, S_Addr = %h, S= %h", R_Addr, R, S_Addr, S);
			end // end of read for loop
			
		$finish;
		
		end // end of initial block
		
endmodule 