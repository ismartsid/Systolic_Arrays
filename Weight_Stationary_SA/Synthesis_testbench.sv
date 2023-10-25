`timescale 1ns / 1ps
parameter bit_width=8, acc_width=16, size=16;
module tb_Syn;

	// Inputs
	reg clk;
	reg control;
	reg [(bit_width*size)-1:0] data_arr;
	reg [(bit_width*size)-1:0] wt_arr;
	reg reset;
	// Outputs
	reg [(acc_width*size)-1:0]acc_out_final;
	wire [((acc_width*size)*(size+1))-1:0] acc_out;

	// Instantiate the Unit Under Test (UUT)
	MMU uut (
		.clk(clk), 
		.control(control), 
		.data_arr(data_arr), 
		.wt_arr(wt_arr), 
		.acc_out(acc_out),
		.acc_out_final(acc_out_final),
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		control = 0;
		data_arr = 0;
		wt_arr = 0;
		reset = 0;
		// Wait 100 ns for global reset to finish
		#1000;
       end
		// Add stimulus here
		always
		#250 clk=!clk;
		// sample testbench for a 4X4 Systolic Array
		initial begin
		@(posedge clk);
		control=1;
		reset = 1;
		wt_arr=32'h 05020304;
		
		@(posedge clk);
		wt_arr=32'h 03010203;
		
		@(posedge clk);
		wt_arr=32'h 07040102;

		@(posedge clk);
		wt_arr=32'h 01020403;

		
		@(posedge clk);

		control=0;
		
		data_arr=32'h 00000001;
		
		@(posedge clk);
		data_arr=32'h 00000102;
		
		@(posedge clk);
		data_arr=32'h 00010200;
		
		@(posedge clk);
		data_arr=32'h 00010100;
		
		@(posedge clk);
		data_arr=32'h 02030200;
		
		@(posedge clk);
		data_arr=32'h 04010000;
		
		@(posedge clk);
		data_arr=32'h 05000000;
		
		end
      
endmodule


