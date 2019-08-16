`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:29:49 03/06/2018 
// Design Name: 
// Module Name:    top_level 
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
module top_level(clk, reset, step, we, din, anode, a, b, c, d, e, f, g );
	input clk, reset;
   input step;
	input we;
   input [15:0] din;

   output a,b,c,d,e,f,g;
   output [7:0] anode;

	wire clk_500Hz, in_ram, shot_wire;
	wire [7:0] addr;
	wire [15:0] dout;

	
	clk_div clk0 (.clk_in(clk), .reset(reset), .clk_out(clk_500Hz));
	one_shot_pulse shot0(.clk(clk_500Hz), .reset(reset), .D_in(step), .D_out(shot_wire));
	one_shot_pulse shot1(.clk(clk_500Hz), .reset(reset), .D_in(we), .D_out(in_ram));
	addr_seqr addr0( .clk(shot_wire), .reset(reset), .addr(addr));
	ram ram0(.clk(clk), .we(in_ram), .addr(addr), .din(din), .dout(dout));
	display_controller controller0( .clk(clk), .reset(reset), .addr(addr), .anode(anode), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g),.D_out(dout));
	
	
endmodule
