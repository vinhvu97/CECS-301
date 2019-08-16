`timescale 1ns / 1ps

module decoder_3to8(en, in, Y);
	input en;
	input [2:0] in;
	output reg [7:0] Y;
	
	always @ (in or en)
		if(en)
			case (D)
				3'b000:  Y=8'b0000_0001; 
				3'b001:  Y=8'b0000_0010;
				3'b010:  Y=8'b0000_0100;
				3'b011:  Y=8'b0000_1000;
				3'b100:  Y=8'b0001_0000;
				3'b101:  Y=8'b0010_0000;
				3'b110:  Y=8'b0100_0000;
				3'b111:  Y=8'b1000_0000;
				default: Y=8'b0000_0000;
				endcase
		else
			Y=8'b0;

endmodule
