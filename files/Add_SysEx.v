module Add_SysEx(
	// input 					add_flag,
	input 	[31:0] 			in_data0,
	input 	[32:0]			in_data1,

	output  [31:0] 			out_data
);

reg 	[31:0] 			out_data_reg;

assign add_flag = in_data1[32];
assign out_data_reg = out_data;

always @(add_flag) begin
	out_data_reg = in_data0 + (in_data1[31:0]<<2);
end

endmodule 