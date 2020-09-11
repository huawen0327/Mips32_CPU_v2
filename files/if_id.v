module if_id(
	input				clk,
	input				rst,
	input 	[31:0]		if_pc,

	output  [31:0]		id_pc,
	output 	[31:0]		id_inst
);

wire 	[31:0]			address;
wire    [31:0]			if_pc_wire;
wire 					clk_addr_wire;
wire 					start_clk;

reg 					start_clk_reg;
reg 	[31:0]  		if_pc_reg;

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        if_pc_reg <= 32'b0;
        // start_clk_reg <= 1'b0;
        // clk_addr  <= 1'b0;
    end
    else
        if_pc_reg <= if_pc;
end

assign if_pc_wire = if_pc_reg;
assign id_pc = if_pc_reg+4;
assign address = if_pc_reg/4;
// assign start_clk = start_clk_reg;
// assign clk_addr_wire = clk_addr;
assign clk_addr_wire=(if_pc_wire==if_pc)?1'b1:1'b0;
assign start_clk=(!rst & clk)?1'b0:1'b1;
// // 程序存储器的clk，if_pc发生变化时
// always @(if_pc_wire)
// begin
// 	clk_addr = ~clk_addr_wire;
// end
// always @(clk_addr_wire)
// begin
// 	clk_addr = ~clk_addr_wire;
// end

// 例化程序存储器
AddrMem inst_AddrMem (
	.address(address), 
	.clock(clk_addr_wire & start_clk), 
	.q(id_inst)
	);


endmodule 