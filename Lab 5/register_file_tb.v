`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:  
// Design Name:   register_file
// Module Name:   C:/Users/Zachery Takkesh/Desktop/301/xilinx/Lab5/register_file_tb.v
// Project Name:  Lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register_file
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module register_file_tb;

	// Inputs
	reg clk;
	reg reset;
	reg we;
	reg [15:0] W;
	reg [2:0] W_Addr;
	reg [2:0] R_Addr;
	reg [2:0] S_Addr;

	// Outputs
	wire [15:0] R;
	wire [15:0] S;

	// Instantiate the Unit Under Test (UUT)
	register_file uut (
		.clk(clk), 
		.reset(reset), 
		.we(we), 
		.W(W), 
		.W_Addr(W_Addr), 
		.R_Addr(R_Addr), 
		.S_Addr(S_Addr), 
		.R(R), 
		.S(S)
	);
	
   always #5 clk = ~clk;  
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		we = 0;
		W = 0;
		W_Addr = 0;
		R_Addr = 0;
		S_Addr = 0;
     
        
		// Add stimulus here

	$timeformat (-12, 1, " ps", 8); 
      
      do_reset     ;           //reset the Register File.
      dump_mem     ;           //read the Register File for the first time.
      write_pattern;           //write the Register File.
      dump_mem     ;           //read the Register File for the second time.
      
	end
   
   
   /*
      do_reset task is to try using reset by setting it equal to one,
      and then setting it back to zero for not reset.
   */
   task do_reset; begin
   
      @(negedge clk)
         reset = 1;           //reset output to be 16'h0
      @(negedge clk)
         reset = 0;           //return to regular operation mode.
      end
      
   endtask
     
   /*
      Read memories in the Register File by using for loop
      to display all register outputs that have been memorized.
      It will display 0000 before asserting input into it.
      After that, it will display the memorized outputs.
   */
   task dump_mem;
      
      //Address counter
      integer i;            
      
      for(i = 0; i < 8; i = i+1 ) begin                            
         @(negedge clk)
               we = 0    ;    //Not enable to write
                W = 0    ;    //Input is 16-bit 0s.
            W_Addr = 0    ;    //Write address.
            R_Addr = i    ;    //Starting to read R_Adr from 0 to 7
            S_Addr = 7 - i;    //Starting to read S_Adr from 7 to 0
         @(posedge clk)
            //Display output
            #1 $display ("Time %t || R %h || S %h", $time, R, S);
      end
   endtask
   
   /*
      A task to assert input pattern to the Register File where
      the input pattern is the compliment of Address counter(i).
   */
   task write_pattern;
   
      //Address counter
      integer i;
      
      for(i = 0; i < 8; i = i+1 ) begin
         @(negedge clk)
               we =  1 ;         //Enable to write
            W_Addr =  i ;         //Write input on the register(i)
                W = ~i ;         //input pattern.
            R_Addr =  0 ;         
            S_Addr =  0 ;
      end 
      
   endtask
   
      
endmodule
      


