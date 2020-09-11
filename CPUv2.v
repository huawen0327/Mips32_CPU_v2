module CPUv2(
	input   [0:0] 	   	clk,
	input	[0:0]		rst,

	input	[31:0] 		if_pc_test,
	output	[31:0]		id_pc_test,
	output	[31:0]		id_inst_test
);

// reg				qtest_reg;

if_id inst_if_id (
	.clk(clk),
	.rst(rst),
	.if_pc(if_pc_test),
	.id_pc(id_pc_test),
	.id_inst(id_inst_test)
	);

endmodule