module id_ex(
	input				clk,
	input				rst,
	input	[31:0]		id_pc,
	input	[31:0]		id_inst,
	input	[31:0]		wb_wdata,
	input	[4:0]		wb_waddr,
	input 				reg_write,

	output 	[31:0]		ex_JumpAddr,
	output  [31:0] 		ex_BranchAddr,
	output 	[7:0]		ex_AluCode,
	output 	[31:0] 	    ex_RFRead0,
	output 	[31:0] 		ex_RFRead1,
	output 	[8:0]		ex_CtrlCode,
	output 	[4:0]		ex_RFWAddr
)

`define READ_ADDR1		id_inst[25:21]
`define	READ_ADDR2 		id_inst[20:16]
`define	MUX3_IN1		id_inst[20:16]
`define	MUX3_IN2		id_inst[15:11]
`define	SYMEX26_in1		id_inst[25:0]
`define	SYMEX26_in2		id_pc[31:28]
`define SYMEX_in 		id_inst[15:0]
`define MUX3_BITS		4
`define MUX_BITS 		31

wire 	[8:0] 			inside_ctrl_code;
`define CTRL_FLAG 		inside_ctrl_code[0]
`define REG_DST 		inside_ctrl_code[2:1]
`define SYMEX_SINAL 	inside_ctrl_code[3]
`define ALU_SRC1 		inside_ctrl_code[4]
`define ALU_SRC0 		inside_ctrl_code[6:5]
`define JUMP_JR 		inside_ctrl_code[7]

// wire 	[4:0]			MUX3_out_wire;
reg 	[4:0]			waddr_reg;

always @(posedge clk or negedge rst) begin
	if (rst) begin
		// reset
		waddr_reg <= 1'b0;
	end
	else begin
		waddr_reg <= wb_waddr;
	end
end

// 将指令25-0转成jump地址 yes
wire  	[31:0] 		symex26_o;
SymEx26 inst_SymEx26 (
		.clk(clk), 
		.rst(rst), 
		.inst_in(`SYMEX26_in1), 
		.pc_in(`SYMEX26_in2), 
		.data_out(symex26_o)
	);

MUX #(.data_bits(data_bits)) inst_MUX_jr (
		.sinal    (`JUMP_JR),
		.in_data0 (symex26_o),
		.in_data1 (reg_data0),
		.out_data (ex_JumpAddr)
	);

// SymEx26 inst_SymEx26 (
// 	.ctrl_flag(ctrl_flag)
// 	.inst_in(`SYMEX26_in1),
// 	.pc_in(`SYMEX26_in2),

// 	.data_out(ex_JumpAddr)
// 	);

// jump的地址调整 yes
Add_SysEx inst_Add_SysEx (
		// .add_flag(add_flag),
		.in_data0(id_pc),
		.in_data1(symex_o),

		.out_data(ex_BranchAddr)
	);

// 控制模块 yes
CtrlCode inst_CtrlCode(
		.clk              (clk),
		.rst              (rst),
		.inst             (id_pc),
		.alu_code         (ex_AluCode),
		.ctrl_code        (ex_CtrlCode),
		.inside_ctrl_code (inside_ctrl_code)
	);

// wire 	[1:0]		alu_src;
// wire 	[1:0]		reg_dst;
// wire 				sysex_sinal;
// wire 				ctrl_flag;
// CtrlCode inst_CtrlCode(
// 	.clk         (clk),
// 	.rst         (rst),
// 	.inst        (id_inst),

// 	.alu_code    (ex_AluCode),
// 	.ctrl_code   (ex_CtrlCode),
// 	.alu_src     (alu_src),
// 	.reg_dst     (reg_dst),
// 	.sysex_sinal (sysex_sinal),
// 	.ctrl_flag   (ctrl_flag)
// 	);


// 写寄存器地址的选择器 yes
MUX3 #(.data_bits(`MUX3_BITS)) inst_MUX3 (
		.ctrl_flag (`CTRL_FLAG),
		.sinal     (`REG_DST),
		.in_data1  (`MUX3_IN1),
		.in_data2  (`MUX3_IN2),
		.out_data  (ex_RFWAddr)
	);

// 写时钟的CLK yes
wire 	[4:0]		waddr_wire;
wire 	[31:0]		reg_data0;
wire 	[31:0]		reg_data1;
assign 	waddr_wire = waddr_reg;
assign 	waddr_reg = wb_waddr;
assign 	RF_write_clk=(waddr_wire==wb_waddr)?1'b1:1'b0;
RegFile inst_RegFile(
		.read_addr1   (`READ_ADDR1),
		.read_addr2   (`READ_ADDR2),
		.write_addr   (wb_waddr),
		.write_data   (wb_wdata),
		.output_data1 (reg_data0),
		.output_data2 (reg_data1),
		.clk          (`CTRL_FLAG),
		.reg_write    (`REG_WRITE),
		// .testreg      (testreg),
		.clk2         (RF_write_clk)
	);

// 有无符号拓展 no sinal
wire 	[31:0] 			symex_o;
// SymEx inst_SymEx (
// 	.clk      (clk),
// 	.sinal    (sysex_sinal),
// 	.add_flag (add_flag),
// 	.data_in  (`SYMEX_in),

// 	.data_out (sysex_data_out)
// 	);
// SymEx inst_SymEx (
// 		.clk(clk), 
// 		.sinal(`SYMEX_SINAL), 
// 		.data_in(`SYMEX_in), 

// 		.data_out(symex_o)
// 	);
SymEx inst_SymEx (
		.flag(`CTRL_FLAG), 
		.sinal(`SYMEX_SINAL), 
		.data_in(`SYMEX_in), 

		.data_out(symex_o)
	);



// yes
MUX2 #(.data_bits(`MUX_BITS)) inst_MUX0 (
		// .clk      (clk),
		.sinal    (`ALU_SRC0),
		.in_data0 (reg_data0),
		.in_data1 (symex_o),
		.in_data2 (id_pc),

		.out_data (`ex_RFRead0)
	);
// yes  
MUX #(.data_bits(`MUX_BITS)) inst_MUX1 (
		// .clk      (clk),
		.sinal    (`ALU_SRC1),
		.in_data0 (reg_data1),
		.in_data1 (symex_o),

		.out_data (`ex_RFRead1)
	);

endmodule 
