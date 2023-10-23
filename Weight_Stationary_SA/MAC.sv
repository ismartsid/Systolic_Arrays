`timescale 1ns / 1ns

module MAC #(parameter bit_width=8, acc_width=16)(
	input clk,
	input control, // control signal used to indidate if it is weight loading or not
	input reset,
	input [acc_width-1:0] acc_in, // accumulation in
	input [bit_width-1:0] data_in,  // data input or activation in
	input [bit_width-1:0] wt_path_in,   // weight data in
	output reg [acc_width-1:0] acc_out,  // accumulation out
	output reg [bit_width-1:0] data_out,    // activation out
	output [bit_width-1:0] wt_path_out		// weight data out
	 );
	 
	wire [acc_width-1:0] product;
	reg [bit_width-1:0] wt_path;
	wire [acc_width-1:0] acc_sum;
	
	always @(posedge clk, negedge reset)
	begin
	if (!reset) begin 
		data_out <= 0;
		acc_out <= 0;
		wt_path <= 0;
		end
	else begin
		data_out <= data_in;
		acc_out <= acc_sum;
		if (control)
			wt_path <= wt_path_in;
		else
			wt_path <= wt_path;
		end

  end

 assign product = data_in * wt_path;
 assign wt_path_out = wt_path;
 assign acc_sum = product + acc_in;

endmodule
