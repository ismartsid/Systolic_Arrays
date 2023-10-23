
`timescale 1ns / 1ns
parameter bit_width=8, acc_width=16, size=4;
// sample testbench for a 4X4 Systolic Array

module test_TPU;

	// Inputs
	reg clk;
	reg control;
	reg reset;
	reg [bit_width-1:0]data_arr[size-1:0];
	reg [bit_width-1:0]wt_arr[size-1:0];
    reg [acc_width-1:0]acc_out_final[size-1:0];
	// Outputs
	wire [acc_width-1:0]acc_out[size:0][size-1:0];

	// Instantiate the Unit Under Test (UUT)
	MMU dut (
		.clk(clk), 
		.control(control), 
		.data_arr(data_arr), 
		.wt_arr(wt_arr), 
		.acc_out(acc_out),
		.reset(reset),
        .acc_out_final(acc_out_final)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		control = 0;
		reset = 0;
		for(int i = 1; i < 5; i++)
			data_arr[i-1] = 0;
		for(int i = 1; i < 5; i++)
			wt_arr[i-1] = 0;
		
		// Wait 100 ns for global reset to finish
		#5000;
       end
		// Add stimulus here
		always
		#250 clk=~clk;
		
	initial begin
		@(posedge clk);
		reset = 1;
		control=1;
		wt_arr[0] = 8'h4;
        wt_arr[1] = 8'h3;
        wt_arr[2] = 8'h2;
        wt_arr[3] = 8'h5;
		
		@(posedge clk);
		wt_arr[0] = 8'h3;
        wt_arr[1] = 8'h2;
        wt_arr[2] = 8'h1;
        wt_arr[3] = 8'h3;
		
		@(posedge clk);
		wt_arr[0] = 8'h2;
        wt_arr[1] = 8'h1;
        wt_arr[2] = 8'h4;
        wt_arr[3] = 8'h7;

		@(posedge clk);
		wt_arr[0] = 8'h3;
        wt_arr[1] = 8'h4;
        wt_arr[2] = 8'h2;
        wt_arr[3] = 8'h1;

		
		@(posedge clk);

		control=0;
		data_arr[0] = 8'h1;
        data_arr[1] = 8'h0;
        data_arr[2] = 8'h0;
        data_arr[3] = 8'h0;
        
		
		
		@(posedge clk);
		data_arr[0] = 8'h2;
        data_arr[1] = 8'h1;
        data_arr[2] = 8'h0;
        data_arr[3] = 8'h0;
        
		
		
		@(posedge clk);
		data_arr[0] = 8'h0;
        data_arr[1] = 8'h2;
        data_arr[2] = 8'h1;
        data_arr[3] = 8'h0;
		
		@(posedge clk);
		data_arr[0] = 8'h0;
        data_arr[1] = 8'h1;
        data_arr[2] = 8'h1;
        data_arr[3] = 8'h0;
		
		@(posedge clk);
		data_arr[0] = 8'h0;
        data_arr[1] = 8'h2;
        data_arr[2] = 8'h3;
        data_arr[3] = 8'h2;
		
		@(posedge clk);
		data_arr[0] = 8'h0;
        data_arr[1] = 8'h0;
        data_arr[2] = 8'h1;
        data_arr[3] = 8'h4;
		
		@(posedge clk);
		data_arr[0] = 8'h0;
        data_arr[1] = 8'h0;
        data_arr[2] = 8'h0;
        data_arr[3] = 8'h5;
    end
      
endmodule
