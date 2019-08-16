`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: RISC_Processor
// Project: Lab 8
// Designer: Zachery takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 27, 2018
//
// Purpose: The RISC_Processor is a module that interconnects the CPU_EU and
//				CU modules. CU module fetches, decodes, and executes instructions; 
//				the outputs in CU are sent to the CPU_EU to execute the arithmetic
//				operations. CPU_EU module outputs IR_Out and ALU_Status which are
//				being inputed to CU to decode the instructions.  
////////////////////////////////////////////////////////////////////////////////
module RISC_Processor(clk, reset, address, D_in, D_out, mw_en, status);

	// Input declarations
	input         clk, reset;
	input  [15:0] D_in;
	
	// Output declarations 
	output [15:0] address, D_out;
	output		  mw_en; 
	output [7:0]  status;
	
	// Wire to pass data between the CPU_EU and CU 
	wire 			  pc_inc , pc_ld, pc_sel, ir_ld, 
					  adr_sel, s_sel, rw_en, C, N, Z;  
	wire [3:0]    ALU_Op; 
   wire [15:0]   IR_Out;
	wire [2:0]	  W_Adr, R_Adr, S_Adr;
	
	// Instantiating the control unit that holds the control words for
	// all functions which would connect to the CPU_EU and execute the functions
	CU        control_unit   (.clk(clk), 
									  .reset(reset), 
									  .IR(IR_Out), 
									  .C(C), .N(N), .Z(Z), 
	                          .W_Adr(W_Adr), 
									  .R_Adr(R_Adr), 
									  .S_Adr(S_Adr), 
									  .adr_sel(adr_sel), 
									  .s_sel(s_sel), 
									  .pc_ld(pc_ld), 
									  .pc_inc(pc_inc), 
									  .pc_sel(pc_sel),
									  .rw_en(rw_en), 
									  .ir_ld(ir_ld),
						           .mw_en(mw_en), 
									  .alu_op(ALU_Op), 
									  .status(status)); 
									  
	// Instantiate the CPU_EU that executes the ALU operations and based on the CU
	// and the given instructions decoded from the CU 
	CPU_EU    execution_unit (.clk(clk), 
								     .reset(reset), 
									  .din(D_in), 
									  .address(address), 
	                          .dout(D_out), 
									  .adr_sel(adr_sel), 
									  .s_sel(s_sel), 
									  .pc_ld(pc_ld), 
									  .pc_inc(pc_inc), 
									  .reg_W_en(rw_en), 
									  .ir_ld(ir_ld), 
									  .C(C), .N(N), .Z(Z), 
									  .pc_sel(pc_sel), 
									  .IR_Out(IR_Out), 
									  .ALU_OP(ALU_Op), 
									  .W_Adr(W_Adr), 
									  .R_Adr(R_Adr), 
									  .S_Adr(S_Adr)); 
	
endmodule //end of RISC Processor wrapper