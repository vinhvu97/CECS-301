`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: display_controller
// Project: Lab 5
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: Mar. 15, 2018
//
// Purpose: This is the display controller module used to tie all the features of
// 			the display controller in Lab 4 together. This module implements and 
//				instantiates the pixel_clk, pixel_controller, ad_mux(8-1-Mux), and 
//				Hex_to_7seg module. 
//
// Notes:   This module is easy to understand if top level diagram is drawn out.
////////////////////////////////////////////////////////////////////////////////
module display_controller(clk, reset, S, R, anode, a, b, c, d, e, f, g);

    // Input declarations
    input 		   clk , reset ;
    input  [15:0] S, R ;

    // Output declarations
    output [7:0] anode;
    output       a , b , c , d , e , f , g ;

    // Temp wires to pass binary data from module to module
    wire         clk_480Hz;
    wire   [2:0] sel;
    wire   [3:0] mux_wire;

    // Instantiate pixel clock to divide the default clock of 100MHz to 480Hz
	 // The reason for using a 480Hz clock is to refresh the 7Segments on the 
	 // FPGA board
    pixel_clk        clk0        ( .clk_in(clk) , 
						                 .reset(reset) , 
						                 .clk_out(clk_480Hz)) ;

	// Instantiate Pixel Controller
   // A Finite State Machine(FSM) counting up states
   // and outputs a select variable(S) that sends 
	// 3-bits of data to the 8-1 mux module to perform data selection on 
	// which inputs are to be selected in order to be represented on the display
    pixel_controller controller0 ( .clk(clk_480Hz) , 
										     .reset(reset) , 
											  .S(sel) , 
											  .anode(anode)) ;

    // Instantiates an address mux that sends 4-bit value to the 7 segment
	 // module. This 8-1 mux sends a nibble(4-bits) to the 
	 // Hex_to_7seg module to choose the correct segments to display on the board
	 ad_mux           mux0        ( .R(R) , 
											  .sel(sel) , 
											  .S(S) , 
											  .ad_out(mux_wire)) ;


    // Instantiate the hex to 7 segment to display the values onto the board 
    hex_to_7seg      hex7        ( .hex(mux_wire), 
											  .a(a) , .b(b) , .c(c) , .d(d) , 
											  .e(e) , .f(f) , .g(g));

endmodule // end of display controller module