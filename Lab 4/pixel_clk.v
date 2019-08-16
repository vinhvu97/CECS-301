`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: pixel_clk
// Project: Lab4
// Designer: Zachery Takkesh	
// Email: zachtakkesh@gmail.com
// Rev. Date: Feb. 18, 2018
//
// Purpose: This module will be used to "divide" the incoming default clock. 
//				To accomplish this a special value has to be placed in the "if 
//				condition". This value is determined Using the formula: 
//
//				[ (Incoming Freq/Desired Freq) / 2 ]
//
//				The default incoming clock freq is 100MHz, for this Lab,
//				our desired clock freq is 480Hz. This formula is used to 
//				slow the clock to a lower frequency. Having a slower clock speed
//				allows the user to explicity see the changes in the input and output. 
//  
//
// Notes: this module is needed to see output changes with a naked eye.
//			(100MHz is too fast)
//////////////////////////////////////////////////////////////////////////////////
module pixel_clk(clk_in, reset, clk_out);
	//initialize input and outputs
	input clk_in, reset;
	output clk_out;
	reg clk_out;
	// initialize integer counting variable
	integer i;
	
	
	always @(posedge clk_in or posedge reset) begin
		//if reset button is asserted clk given value of 0
		if (reset == 1'b1) begin
			i = 0;
			clk_out = 0;
		end
		
		// if reset is not asserted 
		else begin
			i = i + 1;
			if( i >= 104166) begin // special number is result of [(100Mhz/480Hz) / 2]
				clk_out = ~clk_out;
				i=0;
			end//if
		end//else
		
	end//always
	
endmodule// end of clock divider module
