`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
// File Name: register_file
// Project: Lab 5
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: Mar. 19, 2018
//
// Purpose: The register file uses the W_Addr (write address), R_Addr 
//          (read address), and S_Addr (select address) inputs to select, read, 
//          or write data to an address. The 16-bit output R will have the content
//          of the register addressed by the R_Addr. The 16-bit output S will have
//          the content of the register addressed by the S_Addr. The 16-bit input
//          W will be written with the register addressed by W_Addr
//          if and only if write enable(we) is asserted on the positive edge of clock. 
//
// Notes:   For R and S, the enable is high active(value is set at 1) for the 
//          3 to 8 decoder so we do not need to assign a push button for R and S. 
//////////////////////////////////////////////////////////////////////////////////
module register_file(clk, reset, we, W, W_Addr, R_Addr, S_Addr, R, S);
	
	// Input and output declarations
	input         clk , reset ;
	input			  we ;
	input  [2:0]  W_Addr ,
					  S_Addr ,
					  R_Addr ;
	input  [15:0] W ;

	output [15:0] R , S ;
	
	// Wire declarations to connect the decoder to the registers
	wire   [7:0]  ld , oea , oeb ;
	
	// Instantiate the 3-to-8 decoders to select one register to access 
   // its content. The reason for a 3-8 decoder is if all the content
   // goes to the input/output at the same time without being individualy 
	// chosen the data buses will have a collision/loss of data.  
	decoder3_to_8  W_dec (.din(W_Addr), 
								 .en(we),     
								 .dout(ld[7:0]));
	decoder3_to_8	R_dec (.din(R_Addr), 
								 .en({1'b1}), 
								 .dout(oea[7:0]));
	decoder3_to_8	S_dec (.din(S_Addr), 
							    .en({1'b1}), 
								 .dout(oeb[7:0]));
	
   // Instantiate the eight tri-state registers with the select wires to 
   // output corresponding data to the display controller 
	reg16 reg0 (.clk(clk)    , .reset(reset) , .ld(ld[0]) , .oeA(oea[0]) , 
					.oeB(oeb[0]) , .Din(W)       , .DA(R)     , .DB(S));
	reg16 reg1 (.clk(clk)    , .reset(reset) , .ld(ld[1]) , .oeA(oea[1]) , 
				   .oeB(oeb[1]) , .Din(W)       , .DA(R)     , .DB(S));
	reg16 reg2 (.clk(clk)    , .reset(reset) , .ld(ld[2]) , .oeA(oea[2]) , 
					.oeB(oeb[2]) , .Din(W)       , .DA(R)     , .DB(S)) ;
	reg16 reg3 (.clk(clk)    , .reset(reset) , .ld(ld[3]) , .oeA(oea[3]) , 
					.oeB(oeb[3]) , .Din(W)       , .DA(R)     , .DB(S)) ;
	reg16 reg4 (.clk(clk)    , .reset(reset) , .ld(ld[4]) , .oeA(oea[4]) , 
					.oeB(oeb[4]) , .Din(W)       , .DA(R)     , .DB(S)) ;
	reg16 reg5 (.clk(clk)    , .reset(reset) , .ld(ld[5]) , .oeA(oea[5]) , 
					.oeB(oeb[5]) , .Din(W)       , .DA(R)     , .DB(S)) ;
	reg16 reg6 (.clk(clk)    , .reset(reset) , .ld(ld[6]) , .oeA(oea[6]) , 
					.oeB(oeb[6]) , .Din(W)       , .DA(R)     , .DB(S)) ;
	reg16 reg7 (.clk(clk)    , .reset(reset) , .ld(ld[7]) , .oeA(oea[7]) , 
					.oeB(oeb[7]) , .Din(W)       , .DA(R)     , .DB(S)) ;
	
endmodule // end of register_file module 