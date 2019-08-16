`timescale 1ns / 100ps



module shift_reg_tb;

	// Inputs
	reg clk;
	reg reset;
	reg SI;
	reg [3:0] D;
	reg [1:0] M;

	// Outputs
	wire [3:0] Q;

	// Instantiate the Unit Under Test (UUT)
	shift_reg uut (
		.clk(clk), 
		.reset(reset), 
		.SI(SI), 
		.D(D), 
		.M(M), 
		.Q(Q)
	);
	
	//Generate clock with a 10ns period
	always
		#5 clk=~clk; 
		
		
	initial begin
		// Initialize Inputs
		$timeformat(-9, 1, "ns", 6);
		clk=0;
		reset=0;
		M=0;
		D=0;
		SI=0;
		
		//These two clocks take care of reset
		@(negedge clk)
			reset=1;
		@(negedge clk)
			reset=0;
			
		//parallel load Q+ <- 1101
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_01_1101_x;
		// no change Q+ <-1101
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_00_xxxx_x;
		//shift right Q+<-0110
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_11_xxxx_0;
		//shift right Q+<-1011
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_11_xxxx_1;
		//no change Q+<-1011
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_00_xxxx_x;
		//rotate left Q+<-0111
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_10_xxxx_x;
		//rotate left Q+<- 1110
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_10_xxxx_x;
		//no change Q+<-1110
		@(negedge clk)
			{reset,M,D,SI} = 8'b0_00_xxxx_x;
			
		$finish;
	end
      
endmodule

