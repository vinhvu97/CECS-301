`timescale 1ns / 1ps

module counter_20(clk, reset, tick);
	input  clk , reset;
	output tick;
	
	wire [19:0] Q;
	wire [19:0] mux_wire;
	
	always @ (posedge clk or posedge reset) begin
		if(reset)
			Q <= 20'b0;
		else
			Q <= Q + 20'b1 ;
	end
	
	if (Q == 20'b11110100001000111111) begin
		tick = 1'b1;
	else
		tick = 1'b0;	
	end
		
	assign mux_wire = (tick) ? 20'b0 : Q;
	
endmodule
