`timescale 1ns / 1ns

// Systolic Array top-level module. 

module MMU #(parameter bit_width=8, acc_width=16, size=16) // bit_width = number of bits for each data(input); acc_width = number of bits for accumilation (typically 2*bit_width); size = size of Systolic Array
(		input clk, // Clock
 		input reset, // Negative Reset
 		input  control, // control signal used to indicate if it is weight loading or not, control 1 for loading weights
		input [bit_width-1:0]data_arr[size-1:0], // data input or activation in
		input [bit_width-1:0]wt_arr[size-1:0], // weight data in
 		output [acc_width-1:0]acc_out[size:0][size-1:0], // activation out for each row unit
 		output reg [acc_width-1:0]acc_out_final[size-1:0] // activation out for the last row unit
);	

	
wire [bit_width-1:0]wt_path[size:0][size-1:0];	

assign acc_out[0][size-1:0] = '{default:0};

generate //Generate block replicates the row unit size times.
genvar i; 
for(i=0;i<size;i = i + 1)
begin
row r(.clk(clk),.reset(reset),.control(control),.data_in(data_arr[i]),.wt_path_in(wt_path[i]), 
	.wt_path_out(wt_path[i+1]),.acc_out(acc_out[i+1][size-1:0]),.acc_in(acc_out[i][size-1:0]));
end
endgenerate

always @(posedge clk or negedge reset) begin
if (!reset) begin
	integer j;
	for(j=0;j<size;j++) begin
		acc_out_final[j] <=0;
	end
	end
   else
		acc_out_final <= acc_out[size];
end

assign wt_path[0] = wt_arr;

endmodule

