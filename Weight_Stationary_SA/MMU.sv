`timescale 1ns / 1ns

// Systolic Array top level module. 

module MMU #(parameter bit_width=8, acc_width=16, size=4)
(		input clk, input reset, input  control,
		input [bit_width-1:0]data_arr[size-1:0], 
		input [bit_width-1:0]wt_arr[size-1:0], 
		output [acc_width-1:0]acc_out[size:0][size-1:0],
		output reg [acc_width-1:0]acc_out_final[size-1:0]
);	
	
	
// Implement your logic below based on the MAC unit design in MAC.v


	
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
	 

	// implement your MAC Unit below
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

