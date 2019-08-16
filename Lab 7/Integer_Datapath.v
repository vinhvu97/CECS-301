`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: Integer_Datapath
// Project: Lab 7 
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 5, 2018
//
// Purpose: The integer datapath module connects the register file, mux, and alu16 
//				modules together. A value from the register file and the second value 
//				comes from either the register or user-input values. The second value 
//   			for the alu16 file gets chosen from the mux file. All values go into 
//				the alu16 module to perform arithmetic operations. 
//
// Notes:   Integer Datapath module performs operations based on S_Sel value. Each
//				value performs its own unique operation. 
//////////////////////////////////////////////////////////////////////////////////
module Integer_Datapath(clk, reset, W_En, W_Adr, S_Adr, R_Adr, DS, S_Sel, C, N, Z, 
								Alu_Out, Reg_Out, ALU_OP);
	
	// Input declarations
	input        clk  , reset , S_Sel , W_En ;
	input [2:0]  R_Adr, S_Adr , W_Adr ;
	input [3:0]  ALU_OP ;
	input [15:0] DS ;
	
	// Output declarations
	output        C      , N      , Z;
	output [15:0] Reg_Out, Alu_Out; 
	
	// Wire declarations to interconnect modules
	wire [15:0] S, Mux_Out, Alu_Out; 
	
	// Instantiate register file that reads, writes, and stores values
	// Register file contains the 3-to-8 decoder and reg16 file
	register_file reg0 ( .clk(clk), 
								.reset(reset), 
								.we(W_En), 
								.W(Alu_Out), 
								.W_Adr(W_Adr), 
								.R_Adr(R_Adr), 
								.S_Adr(S_Adr), 
								.R(Reg_Out), 
								.S(S));
	
	
	// Instantiate a 2-to-1 mux that chooses AA55 or the value from register file 
	S_MUX         mux0 ( .S(S), 
								.DS(DS), 
								.S_Sel(S_Sel), 
								.S_Out(Mux_Out));
	
	// Instantiate the alu16 module that performs artihmetic operations such as add
	// or subtract or AND gate. The result will be display on the 7-segment display
	alu16         alu0 ( .R(Reg_Out), 
								.S(Mux_Out), 
								.Alu_Op(ALU_OP), 
								.Y(Alu_Out), 
								.N(N), .Z(Z), .C(C));
endmodule 