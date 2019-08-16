`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:36:21 04/07/2018
// Design Name:   alu16
// Module Name:   C:/Users/Zachery Takkesh/Desktop/Lab6/alu16_tb.v
// Project Name:  Lab6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu16_tb;

	// Inputs
	reg [15:0] R;
	reg [15:0] S;
	reg [3:0] Alu_Op;

	// Outputs
	wire [15:0] Y;
	wire N;
	wire Z;
	wire C;
	
	integer i;
	
	// Instantiate the Unit Under Test (UUT)
	alu16 uut (
		.R(R), 
		.S(S), 
		.Alu_Op(Alu_Op), 
		.Y(Y), 
		.N(N), 
		.Z(Z), 
		.C(C)
	);

	initial begin
		// Initialize Inputs
		R = 0;
		S = 0;
		Alu_Op = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		 //pass S
      for (i=0; i<4; i=i+1)begin
            R = i+1;
            S = i+3;
            Alu_Op = 4'b0000;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		 //pass R
      for (i=0; i<4; i=i+1)begin
            R = i+4;
            S = i+6;
            Alu_Op = 4'b0001;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //add
      for (i=0; i<4; i=i+1)begin
            R = (i*2) + 1;
            S = (i*4) + 1;
            Alu_Op = 4'b0010;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //increment S
      for (i=0; i<4; i=i+1)begin
            R = (i*5) + 3;
            S = (i*5) + 1;
            Alu_Op = 4'b0100;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		 //decrement S
      for (i=0; i<4; i=i+1)begin
            R = (i*i*i) + 4;
            S = (i*i*i) + 2;
            Alu_Op = 4'b0101;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //left shift S (logic)
      for (i=0; i<4; i=i+1)begin
            R = i+8;
            S = i+4;
            Alu_Op = 4'b0110;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //right shift S (logic)
      for (i=0; i<4; i=i+1)begin
            R = (i * 2) + 3;
            S = (i * 2) + 1;
            Alu_Op = 4'b0111;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //logic and
      for (i=0; i<4; i=i+1)begin
            R = i + 5;
            S = i + 2;
            Alu_Op = 4'b1000;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //logic or 
      for (i=0; i<4; i=i+1)begin
            R = i + 3;
            S = i + 6;
            Alu_Op = 4'b1001;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		 //logic xor
      for (i=0; i<4; i=i+1)begin
            R = (i * 2);
            S = i + 4;
            Alu_Op = 4'b1010;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //logic not S (1's comp)
      for (i=0; i<4; i=i+1)begin
            R = i;
            S = i+9;
            Alu_Op = 4'b1011;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //negate S (2's comp)
      for (i=0; i<4; i=i+1)begin
            R = i;
            S = (2 * i) + 3;
            Alu_Op = 4'b1100;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
		  //pass S for default
      for (i=0; i<4; i=i+1)begin
            R = (i * ~i) + 7;
            S = ~i + 3;
            Alu_Op = 4'b1101;
            #1 $display("R=%h S=%h Y=%h C=%h", R, S, Y, C);
       end
		 
	end// end of stimulus
      
endmodule

