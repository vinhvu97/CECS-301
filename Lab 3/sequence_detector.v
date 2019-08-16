`timescale 1ns / 1ps
/****************************************************
* File name: sequence_detector
* Project: Lab 3
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 25, 2017
*
* Purpose: This module is the sequence detector. It 
* detects an overlapping sequence of 010110. Depending
* on the X inputs, Q goes to the appropriate states and
* continues to detect incoming sequence until it sees
* the completed pattern. Once that happends, Z outputs a
* 1 at that state. All of the equations to implement both
* Moore and Mealy FSM are derived from state diagrams, state
* tables and k-maps. 
* 
* Notes: SInce there are 2 types of FSM being implemented. 
* within the same module, the 2-to-1 MUX chooses which 
* FSM to execute. If M=0, then the Moore FSM is executed.
* If M=1, then the Mealy FSM is executed.
*****************************************************/
module sequence_detector(clk, reset, X, M, Z, Q);
	
	//Inputs and Outputs declarations
	input        clk, reset, X, M;
	output       Z;
	output [2:0] Q; 
	
	//wire declarations
	wire [2:0] MooreQ, MooreD, MealyQ, MealyD;
	wire       MooreZ, MealyZ; 
	
	//*************************************
	// Moore Sequence Dectector for 010110
	//*************************************

	//*****Next State Combination Logic*****
	assign MooreD[0] = (~MooreQ[2] & ~X)|
							 (~MooreQ[0] & ~X)|
							 ( MooreQ[2] & ~MooreQ[1] & ~MooreQ[0]);
	assign MooreD[1] = ( MooreQ[2] & ~MooreQ[1] & ~X) |
							 (~MooreQ[2] &  MooreQ[1] & ~MooreQ[0] & ~X) |
							 ( MooreQ[2] &  MooreQ[1] &  X) |
							 (~MooreQ[2] & ~MooreQ[1] &  MooreQ[0] &  X);
	assign MooreD[2] = ( MooreQ[1] &  MooreQ[0] &  X) |
							 ( MooreQ[2] &  MooreQ[0] & ~X) |
							 ( MooreQ[2] & ~MooreQ[1] & ~MooreQ[0] &  X);
	
	//*****State register Using D-FF instances*****
	D_ff moore_q0(.clk(clk), .reset(reset), .D(MooreD[0]), .Q(MooreQ[0])),
	     moore_q1(.clk(clk), .reset(reset), .D(MooreD[1]), .Q(MooreQ[1])),
		  moore_q2(.clk(clk), .reset(reset), .D(MooreD[2]), .Q(MooreQ[2]));
		  
	//*****Output Combination Logic*****
	assign MooreZ = (MooreQ[2] & MooreQ[1]);

	//*************************************
	// Moore Sequence Dectector for 010110
	//*************************************

	//****Next State Combination Logic 
	assign MealyD[0] = ( MealyQ[2] & ~MealyQ[0]) |
	                   (~MealyQ[2] & ~X) |
							 ( MealyQ[2] &  MealyQ[0] & ~X);
	assign MealyD[1] = (~MealyQ[2] & ~MealyQ[1] &  MealyQ[0]&X) |
	                   ( MealyQ[1] & ~MealyQ[0] & ~X) |
							 ( MealyQ[2] & ~MealyQ[0] & ~X);
	assign MealyD[2] = ( MealyQ[1] &  MealyQ[0] &  X) |
	                   ( MealyQ[2] & ~MealyQ[0] &  X);
	
	//*****State register Using D-FF instances*****
	D_ff mealy_q0(.clk(clk), .reset(reset), .D(MealyD[0]), .Q(MealyQ[0])),
	     mealy_q1(.clk(clk), .reset(reset), .D(MealyD[1]), .Q(MealyQ[1])),
		  mealy_q2(.clk(clk), .reset(reset), .D(MealyD[2]), .Q(MealyQ[2]));
		  
	//*****Output Combination Logic*****
	assign MealyZ = (MealyQ[2] & MealyQ[0] & ~X);

	//***** 2-to-1 MUX*****
	/* The MUX is to choose between Moore and Mealy Q's and Z
	*  for global outputs. If M == 0, then {Q,Z} == {MooreQ, MooreZ}.
	*  If M == 1, then {Q,Z} == {MealyQ, Mealy Z}.
	*/
	assign {Q,Z} = (M==1'b0) ? {MooreQ, MooreZ}:{MealyQ , MealyZ} ;
endmodule
