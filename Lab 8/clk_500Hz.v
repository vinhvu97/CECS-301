`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: clk_500Hz
// Project: Lab 8
// Designer: Zachery Takkesh	& Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 16, 2018
//
// Purpose: This module will be used to "divide" the incoming default clock. 
//				To accomplish this a special value has to be placed in the "if 
//				condition". This value is determined Using the formula: 
//
//				[ (Incoming Freq/Desired Freq) / 2 ]
//
//				The default incoming clock freq is 100MHz, for this Lab,
//				our desired clock freq is 500Hz. This formula is used to 
//				slow the clock to a lower frequency. Having a slower clock speed
//				allows the user to explicity see the changes in the input and output. 
//  
//
// Notes: This module is needed to see output changes with a naked eye.
//			(100MHz is too fast)
//////////////////////////////////////////////////////////////////////////////////
module clk_500Hz(clk_in, reset, clk_out);

	// Initialize input and outputs
	input  clk_in, reset ;
	output clk_out ;
	reg    clk_out ;
	
	// Initialize integer counting variable
	integer i ;
	
	always @(posedge clk_in or posedge reset) begin
	
      // If reset button is asserted, clk_out value is 0 as well as counter i
		if (reset == 1'b1) begin
			i       = 0;
			clk_out = 0;
		end // end of if checking reset
		
		// Else (reset is not asserted), increment the counter and
		// test to see if half a period has elapsed
		else begin
			i = i + 1;
			if( i >= 100000) begin // special number is result of [(100Mhz/500Hz) / 2]
				clk_out = ~clk_out;
				i=0;
			end // end of if checking counter
			
		end // else
		
	end // always
	
endmodule // end of clock divider module