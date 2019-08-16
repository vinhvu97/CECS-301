`timescale 1ns / 1ps
/****************************************************
* File name: MUX_4to1
* Project: Lab 1_301
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Jan. 31, 2017
*
* Purpose: This module is a 4-to-1 MUX. MUX is a 
* digital function that receives digital information
* on 4 input lines and transmits information on a
* single output line. The input being selected
* is determined from the 2 select lines. 
*
*****************************************************/
module MUX_4to1(D, S, Y);
	input [3:0] D;
	input [1:0] S;
	output reg Y;
	
	always @ (*)
	case(S)
		2'b00: Y= D[0];
		2'b01: Y= D[1];
		2'b10: Y= D[2];
		2'b11: Y= D[3];
	endcase


endmodule
