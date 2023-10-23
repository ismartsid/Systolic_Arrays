`timescale 1ns / 1ns

// Systolic Array top-level module. 

module MMU #(parameter bit_width=8, acc_width=16, size=4)
(		input clk, input reset, input  control,
		input [bit_width-1:0]data_arr[size-1:0], 
		input [bit_width-1:0]wt_arr[size-1:0], 
		output [acc_width-1:0]acc_out[size:0][size-1:0],
		output reg [acc_width-1:0]acc_out_final[size-1:0]
);	

wire [bit_width-1:0]wt_path[size:0][size-1:0];	

assign acc_out[0][size-1:0] = '{default:0};

generate
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

