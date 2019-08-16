`timescale 1ns / 1ps
/*******************************************************
* File name: shift_reg
* Project: Lab 1_301
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 4, 2017
*
* Purpose: This module is a shift register. When the input M
* is 00, Q gets itself. 01 is parallel load; input D of that
* register goes to Q. 10 is rotate left; Q gets the Q from the 
* right and Q[0] gets Q[3]. 11 is shift right with serial in; 
* output Q gets Q to its left and Q[3] gets serial in. 
*
*****************************************************/
module shift_reg(clk, reset, SI, D, M , Q);
	input clk, reset, SI;
	input [3:0] D;
	input [1:0] M;
	output wire [3:0] Q;
	 
	wire [3:0] mux_wire;
	 
	 //4 instances of MUX to perform the different tasks with its corresponding sequences
	 MUX_4to1 mux0 ( .D({Q[1], Q[3], D[0], Q[0]}), .S(M), .Y(mux_wire[0]));
	 MUX_4to1 mux1 ( .D({Q[2], Q[0], D[1], Q[1]}), .S(M), .Y(mux_wire[1]));
	 MUX_4to1 mux2 ( .D({Q[3], Q[1], D[2], Q[2]}), .S(M), .Y(mux_wire[2]));
	 MUX_4to1 mux3 ( .D({SI ,  Q[2], D[3], Q[3]}), .S(M), .Y(mux_wire[3]));
					  
	// 4 instances of D-ff with the right mux wires to perform the 4 sequences
	 D_ff flop0( .clk(clk), .reset(reset), .D(mux_wire[0]), .Q(Q[0]));
	 D_ff flop1( .clk(clk), .reset(reset), .D(mux_wire[1]), .Q(Q[1]));
	 D_ff flop2( .clk(clk), .reset(reset), .D(mux_wire[2]), .Q(Q[2]));
	 D_ff flop3( .clk(clk), .reset(reset), .D(mux_wire[3]), .Q(Q[3]));

endmodule
