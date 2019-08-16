`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// File Name: ram1 
// Project: Lab 7
// Designer: Zachery Takkesh & Vinh Vu
// Email: zachtakkesh@gmail.com & vincentvinhvu@yahoo.com
// Rev. Date: April 16, 2018
// Purpose: Memory unit that executes pre-programed instructions,
//          with capability of holding 16-bit memory value. 
//
// Input:   addr - address or a pointer to a register in memory(8-bit pointer)
//          we   - write enable. If '1', din will be written to the address(addr)
//          din  - data input (16 bits wide)
//  
// Output:  dout  - data output from a register of the memory
// Note:    Pre-programed memory designed by Robert W. Allison,
//          contains 256 special 16-bit values. (256 x 16)
// 
//////////////////////////////////////////////////////////////////////////////////
module ram(clk, we, addr, din, dout);

	// Initialize inputs and outputs 
   input          clk;       
   input          we;      
   input  [ 7:0]  addr;       
   input  [15:0]  din;       
   output [15:0]  dout;     

   // Call the instance of memory using Xilinx CoreGen IP
   mem256x16 uut(
     .clka(clk) ,     // input clka
     .wea(we) ,       // input  [ 0 : 0] wea
     .addra(addr) ,   // input  [ 7 : 0] addra
     .dina(din) ,     // input  [15 : 0] dina
     .douta(dout)     // output [15 : 0] douta
   );

endmodule // end of ram1 module