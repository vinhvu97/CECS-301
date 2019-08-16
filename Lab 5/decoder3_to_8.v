`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
// File Name: decoder_3to8
// Project: Lab 5
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: Mar. 19, 2018
//
// Purpose: The decoder 3-to-8 intakes a 3-bit wise input and decodes the inputs.
//				In other word, the module breaks down the inputs and determines which one
//          of the eight registers will receive a 1 bit signal. All the other register
//				will receive a 0. 
//
// Notes:   The decoder module is designed so that the data buses do not collide. 
//////////////////////////////////////////////////////////////////////////////////

module decoder3_to_8(din, en, dout);

	// Input and output declarations
	input      [2:0] din;
	input            en;
	output reg [7:0] dout;

	always @ (din or en)
	
		// If enable is active, dout selects a particular register 
		// depending on the din. The rest will be turned off 
		if(en)
			case(din)
				3'b000: dout = 8'b00000001;// turns on register 0
				3'b001: dout = 8'b00000010;// turns on register 1
				3'b010: dout = 8'b00000100;// turns on register 2
				3'b011: dout = 8'b00001000;// turns on register 3
				3'b100: dout = 8'b00010000;// turns on register 4
				3'b101: dout = 8'b00100000;// turns on register 5
				3'b110: dout = 8'b01000000;// turns on register 6
				3'b111: dout = 8'b10000000;// turns on register 7
				default dout = 8'b0;
			endcase // end of casestatement for decoder
		
		// If enable is not active, dout is always 0
		else 
			dout = 8'b0;
			
endmodule // end of decoder module