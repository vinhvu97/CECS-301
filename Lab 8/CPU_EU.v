`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: CPU_EU
// Project: Lab 8
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 24, 2018
//
// Purpose: This  module instantiates the CPU Execution Unit
//   			by connecting five components; the Program Counter, the Integer DataPath, 
//				the Instruction Register, an Address Mux, and the 256x16 Ram module. 
//				The IR holds sixteen-bit control signals and passes 
//  			them into the IDP. The PC's input is the data output from the 
//  			IDP, and the address mux switches between a sixteen-bit output and the 
//   			output from the IDP. The output from the address multiplexer becomes 
//   			the address input to the RAM module, the data output from the ALU gets
//	  			written to the RAM, and the RAM's output gets stored in the IR.
////////////////////////////////////////////////////////////////////////////////
module CPU_EU (clk, reset, din, address, dout, adr_sel, 
               s_sel, pc_ld, pc_inc, reg_W_en, ir_ld, C, N, Z,
					pc_sel, IR_Out, ALU_OP, W_Adr, R_Adr, S_Adr); 

	// Input declarations
   input         clk, reset, adr_sel, s_sel , 
                 pc_ld, pc_inc, reg_W_en, ir_ld,
					  pc_sel;           
   input  [15:0] din;
	input  [3:0]  ALU_OP;
	input  [2:0]  W_Adr, R_Adr, S_Adr; 
   
	// Output declarations 
   output             C, N, Z;
   output wire [15:0] address, dout, IR_Out;
   
	// Wire declaration to 
   wire   [15:0] reg_out, pc_out,
					  signExt, pc_add, pc_mux; 
	
	// Instantiates the Integer Data Path that performs operations
	// based on the S_Sel port value.
   Integer_Datapath idp0 (.clk(clk), 
								  .reset(reset), 
								  .W_En(reg_W_en), 
								  .S_Sel(s_sel), 
								  .ALU_OP(ALU_OP), 	
								  .W_Adr(W_Adr), 	
								  .R_Adr(R_Adr), 
								  .S_Adr(S_Adr), 
								  .DS(din), 
								  .N(N), .Z(Z), .C(C), 
								  .Reg_Out(reg_out),    
								  .Alu_Out(dout));
	// Instantiates the Program Counter module that increments the counter
	// and sents data from the IDP to the memory(ram)
   PC 					pc0 (.clk(clk), 
								  .reset(reset), 
								  .pc_ld(pc_ld), 
								  .pc_inc(pc_inc),  
								  .Alu_Out(pc_mux), 
								  .pc_out(pc_out));
	
	// Instantiates the Instruction Register module that sends data to IDP
	// from memory(RAM)
   IR 					ir0 (.clk(clk), 
								  .reset(reset), 
								  .ir_ld(ir_ld),   
								  .ir_in(din),   
								  .ir_out(IR_Out));
								  
	
   // Duplicates the sign-bit 8 times and add it to IR_Out[7:0] to make 
	// signExt a 16-bit variable 
   assign signExt = { {8{IR_Out[7]}}, IR_Out[7:0] } ;
   
   // Adds pc_out and the sign extended IR_Out.
   assign pc_add = pc_out + signExt ;
   
   // Defines the behavior of the pc mux.
   assign pc_mux = (pc_sel) ? dout : pc_add ;
   
   // Defines the behavior of the address multiplexer.
  	assign address = (adr_sel) ? reg_out : pc_out;

endmodule //end of CPU Execution Unit