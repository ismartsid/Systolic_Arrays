module row #(parameter size=16, bit_width=8, acc_width=16)// bit_width = number of bits for each data(input); acc_width = number of bits for accumilation (typically 2*bit_width); size = size of Systolic Array
	(
		input clk, // Clock
		input reset, // Negative Egde Reset
		input control, // control signal used to indicate if it is weight loading or not, control 1 for loading weights
		input [bit_width-1:0]data_in, // data input or activation in
		input [acc_width-1:0] acc_in[size-1:0], // accumulation in
		input [bit_width-1:0]wt_path_in[size-1:0],  // weight data in
		output [bit_width-1:0]wt_path_out[size-1:0], // weight data out
		output [acc_width-1:0]acc_out[size-1:0] // accumulation out
);

wire [bit_width-1:0] data[size:0];

generate
genvar i;
for (i=0;i<size;i = i + 1) begin
	MAC M(.clk(clk),.control(control),.reset(reset),.data_in(data[i]),.wt_path_in(wt_path_in[i]), 
	.data_out(data[i+1]),.wt_path_out(wt_path_out[i]),.acc_out(acc_out[i]),.acc_in(acc_in[i]));
end
endgenerate

assign data[0] = data_in;

endmodule
