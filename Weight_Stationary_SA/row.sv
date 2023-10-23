module row #(parameter size=4, bit_width=8, acc_width=16)(
		input clk, input reset, input control,
		input [bit_width-1:0]data_in,
		input [acc_width-1:0] acc_in[size-1:0],
		input [bit_width-1:0]wt_path_in[size-1:0], 
		output [bit_width-1:0]wt_path_out[size-1:0],
		output [acc_width-1:0]acc_out[size-1:0]
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
