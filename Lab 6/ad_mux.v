`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File name: ad_mux
// Project: Lab 5
// Designer: Vinh Vu & Zachery Takkesh
// Email: vincentvinhvu@yahoo.com & zachtakkesh@gmail.com
// Rev. Date: Mar. 15, 2018
//
// Purpose: This mux will select what D_out will be, based
// on the select signal which comes from the pixel controller
// to display a hex value from 0 to F. The S is controlled
// by what anode is active at the time.
//
//////////////////////////////////////////////////////////////////////////////////
module ad_mux(sel, R, S, ad_out);

	// Select chooses which input will be assign to the output
	input      [2:0]  sel;
	
	// 16-bit intputs that have 4 sets of 4 bits for every data from the ram 
	input      [15:0]  R, S;
	
	// The output carries the addr based on the value of S
	output reg [3:0]  ad_out;
	
	// Always block is executed based on any changes from S, S
	// and/or R. The case statement is solely based on the value
	// of S. 
	always @ (sel , R , S) begin
			case (sel)
			
				// anode[0], lowest nibble of data out of the RAM
				3'b000: ad_out = S [3:0] ;
				
				// anode[1], the next nibble of data out of RAM
				3'b001: ad_out = S [7:4] ;
				
				// anode[2], the next nibggle of data out of RAM
				3'b010: ad_out = S [11:8] ;
				
				// anode[3], the highest nibble of data out of RAM
				3'b011: ad_out = S [15:12] ;
				
				// anode[4], the lowest nibble from [3:0]
				3'b100: ad_out = R [3:0] ;
				
				// anode[5], the next nibble from [7:4]
				3'b101: ad_out = R [7:4];
				
				// anode[6], the next nibble from [11:8]
				3'b110: ad_out = R [11:8];
				
				// anode [7], the higest nibble from [15:12]
				3'b111: ad_out = R [15:12];
				
				// default case for hex to be 0 
				default: ad_out = 4'b0000;
				
			endcase // end of case statement 
		
		end // end of always block 
endmodule // end of 8-1 mux