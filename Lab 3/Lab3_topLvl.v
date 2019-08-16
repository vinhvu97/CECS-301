`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:50:26 02/17/2018 
// Design Name: 
// Module Name:    Lab3_topLvl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Lab3_topLvl(clk, reset, step, X, M, Z, a, b, c, d, e, f, g, anode, Q);
	//Declare Inputs and Outputs
   input clk, reset, M, X, step;
   output Z;
   
   
   wire clk_wire;
	
	
	output a,b,c,d,e,f,g;
   output [3:0]   anode;
   output [2:0] Q;
	
	wire shot_out;
   wire [2:0] Q;
	
	//Instantiates the clock divider to produce 500Hz clock(default clk is 100MHz)
	clk_div clk0(.clk_in(clk),.reset(reset),.clk_out(clk_wire));
	
	//Instatiates the one shot to produce one positive edge clock tick
	debounce shot1(.clk(clk_wire),.reset(reset),.D_in(step),.D_out(shot_out));
	
   sequence_detector_010110 detector2(.clk(shot_out), .reset(reset),  .M(M), .X(X), .Z(Z), .Q(Q));
   Hex_to_7Seg                         u4( {1'b0,Q}, a,b,c,d,e,f,g);
   
   assign anode = 4'b1110;

endmodule