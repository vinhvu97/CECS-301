`timescale 1ns / 1ps

module ram(clk, we, addr, din, dout );
	input clk, we;
	input [7:0] addr;
	input [15:0] din;
	output [15:0] dout;
	
	ram_256x16 uut (
	.clka(clk),
	.wea(we),
	.addra(addr),
	.dina(din),
	.douta(dout)
	);

endmodule
