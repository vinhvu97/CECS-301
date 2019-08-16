`timescale 1ns / 1ps
/****************************************************
* File name: sequence_detector
* Project: Lab 2
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 15, 2017
*
* Purpose: This module is the sequence detector. It 
* detects an incoming sequence one bit by one bit. 
* 
* Notes: The module represents a non-overlapping sequence.
* The equations for the next state combination logic and
* output combination logic were developed by State Diagrams,
* K-maps, and State Tables. There are two kinds of FSM being
* represented, Moore and Mealy. Moore output is a function 
* of only the present state. Mealy output is a function of
* both the present state and inputs. 
*****************************************************/
module sequence_detector(clk, reset, X, M, Z, Q);
	
	//Inputs and Outputs declarations
	input clk, reset, X, M;
	output Z;
	output [2:0] Q; 
	
	//wire declarations
	wire [2:0] MooreQ, MooreD, MealyQ, MealyD;
	wire       MooreZ, MealyZ; 
	
	//*************************************
	// Moore Sequence Dectector for 010110
	//*************************************

	//*****Next State Combination Logic*****
	assign MooreD[0] = (~MooreQ[2]&~X)|
							 (~MooreQ[0]&~X)|
							 ( MooreQ[2]&~MooreQ[1]&~MooreQ[0]);
	assign MooreD[1] = ( MooreQ[2]&~MooreQ[1]&~X)|
							 (~MooreQ[2]& MooreQ[1]&~MooreQ[0]&~X)|
							 (~MooreQ[2]&~MooreQ[1]& MooreQ[0]& X);
	assign MooreD[2] = ( MooreQ[1]& MooreQ[0]& X)|
							 ( MooreQ[2]& MooreQ[0]&~X)|
							 ( MooreQ[2]&~MooreQ[1]&~MooreQ[0]& X);
	
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
	assign MealyD[0] = ( MealyQ[2]&~MealyQ[0])|
	                   (~MealyQ[2]&~X);
	assign MealyD[1] = (~MealyQ[2]&~MealyQ[1]& MealyQ[0]&X)|
	                   ( MealyQ[1]&~MealyQ[0]&~X)|
							 ( MealyQ[2]&~MealyQ[0]&~X);
	assign MealyD[2] = ( MealyQ[1]& MealyQ[0]& X)|
	                   ( MealyQ[2]&~MealyQ[0]& X);
	
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
