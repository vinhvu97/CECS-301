`timescale 1ns / 1ps
/****************************************************
* File name: Hex_to_7Seg
* Project: Lab 3
* Designer: Vinh Vu
* Email: vincentvinhvu@yahoo.com
* Rev. Date: Feb. 25, 2017
*
* Purpose: This module is a hex to 7 segment module.
* It intakes a 4-bit hex value and displays the 
* corresponding values onto the 7 segment display 
* through turning on the LED's. Each of outputs for
* a through g represents one LED on the segment display. 
* A 0 is on and a 1 is off for the LED's. 
*
* Notes: The way each LED lights up can translate 
* differently. For the letter displays, B and D cannot
* be capitalized because they look like 8 and 0.     
*
*****************************************************/

module Hex_to_7Seg(hex,a,b,c,d,e,f,g);

	// Inputs and outputs declarations
	input      [3:0] hex;
	output reg       a , b , c , d , e , f , g;
	
	always @ (hex)
	
		/***********************************************
		* The 4-bit hex input from 0 to F is specified
		* by 4'h0 to 4'hF. The case statement is used to
		* decode each hex value in order to choose which
		* LED is on for that specific hex value. 
		***********************************************/
		case (hex)
		
			 // 7-segment display for 0-3
          4'h0: {a, b, c, d, e, f, g} = 7'b0000001;//0
          4'h1: {a, b, c, d, e, f, g} = 7'b1001111;//1
          4'h2: {a, b, c, d, e, f, g} = 7'b0010010;//2
          4'h3: {a, b, c, d, e, f, g} = 7'b0000110;//3
          
          // 7-segment display for 4-7
          4'h4: {a, b, c, d, e, f, g} = 7'b1001100;//4
          4'h5: {a, b, c, d, e, f, g} = 7'b0100100;//5
          4'h6: {a, b, c, d, e, f, g} = 7'b0100000;//6
          4'h7: {a, b, c, d, e, f, g} = 7'b0001111;//7
          
          // 7-segment display for 8-B
          4'h8: {a, b, c, d, e, f, g} = 7'b0000000;//8
          4'h9: {a, b, c, d, e, f, g} = 7'b0000100;//9
          4'hA: {a, b, c, d, e, f, g} = 7'b0001000;//A
          4'hB: {a, b, c, d, e, f, g} = 7'b1100000;//B
          
          // 7-segment display for C-F
          4'hC: {a, b, c, d, e, f, g} = 7'b0110001;//C
          4'hD: {a, b, c, d, e, f, g} = 7'b1000010;//D
          4'hE: {a, b, c, d, e, f, g} = 7'b0110000;//E
          4'hF: {a, b, c, d, e, f, g} = 7'b0111000;//F
          
          // Default display when other cases do not apply
			 // The default is g on, the middle horizontal LED 
          default: {a, b, c, d, e, f, g} = 7'b1111110; 
			 
      endcase //end for case hex
	
endmodule

