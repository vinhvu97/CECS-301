`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: S_MUX
// Project: Lab 6
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: Apr. 5, 2018
//
// Purpose: The S_MUX module is a 2-to-1 mux which choose either S_Sel or S_out
//
// 
//////////////////////////////////////////////////////////////////////////////////
module S_MUX(S, DS, S_Sel, S_Out);

	// Input declarations
	input [15:0] S    , DS;
	input        S_Sel;
	
	// Output declarations
	output wire [15:0]  S_Out; 
	
	// If S_Sel, S_Out will be set to DS or else it will be S
	assign S_Out = (S_Sel) ? DS : S ;
	
endmodule
