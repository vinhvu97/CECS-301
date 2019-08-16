`timescale 1ns / 1ps
module display_controller(clk, reset, addr, D_out, anode, a, b, c, d, e, f, g);
	
	// Input declarations
	input clk, reset;
	input [7:0] addr;
	input [15:0] D_out;
	
	// Output declarations
	output [7:0] anode;
	output a, b, c, d, e, f, g;
	
	// Wires to connect the modules
	wire clk_480Hz;
	wire [2:0] S;
	wire [3:0] mux_wire;
	
	// Instantiate pixel clock to divide the default clock of 100MHz to 480Hz
	pixel_clk clk0 (.clk_in(clk), .reset(reset), .clk_out(clk_480Hz));
	
	// Instantiate pixel controller
	pixel_controller controller0 (.clk(clk_480Hz), .reset(reset), .S(S), .anode(anode));
	
	// Instantiate address mux 
	ad_mux mux0 (.addr(addr), .S(S), .D_out(D_out), .ad_out(mux_wire));
	
	// Instantiate the hex to 7 segment to display the values onto the board 
	Hex_to_7Seg hex0(.hex(mux_wire), .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g));
	
endmodule
