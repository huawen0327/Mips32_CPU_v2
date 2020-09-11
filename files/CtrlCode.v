`include "alucode_defines.v"

module CtrlCode(
		input				clk,
		input				rst,
		input	[31:0]		inst,

		output	[7:0]		alu_code,	// ALU操作信号
		output	[8:0]		ctrl_code,	// 控制信号，来操控内存读写等操作
		// output				reg_write,
		// output 	[1:0]		alu_src,
		// output	[1:0]		reg_dst,
		// output   			sysex_sinal,

		// output 				ctrl_flag
		output	[8:0] 		inside_ctrl_code
	)
// reg 				reg_write_reg;	// 寄存器堆写信号
// reg 	[1:0]		alu_src_reg;	// ALU的输入数据选择
// reg 	[1:0]		reg_dst_reg;	// 寄存器堆读的寄存器号
reg 				ctrl_flag_reg;
// reg 				sysex_sinal_reg;
reg 	[7:0] 		alu_code_reg;
reg 	[8:0]		ctrl_code_reg;
reg 	[8:0]		inside_ctrl_code_reg;

assign reg_write = reg_write_reg;
assign alu_src = alu_src_reg;
// assign reg_dst = reg_dst_reg;
assign ctrl_flag = ctrl_flag_reg;
// assign sysex_sinal = sysex_sinal_reg;
assign alu_code = alu_code_reg;
assign ctrl_code = ctrl_code_reg_reg;
assign inside_ctrl_code = inside_ctrl_code_reg;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		// reset
		ctrl_flag_reg <= 0;
		alu_code_reg <= `RST_CODE;
		ctrl_code_reg <= `RST_CTRL;
		inside_ctrl_code_reg <= {`RST_INCODE,ctrl_flag};
	end
	else begin
		// 判断OP1
		case (`OP1)
			`OP1_ADDI : begin
				alu_code_reg <= `ADDI_CODE;
				ctrl_code_reg <= `ADDI_CTRL;
				inside_ctrl_code_reg <= {`ADDI_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			`OP1_ADDIU : begin
				alu_code_reg <= `ADDIU_CODE;
				ctrl_code_reg <= `ADDIU_CTRL;
				inside_ctrl_code_reg <= {`ADDIU_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			`OP1_ANDI : begin
				alu_code_reg <= `ANDI_CODE;
				ctrl_code_reg <= `ANDI_CTRL;
				inside_ctrl_code_reg <= {`ANDI_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_ORI : begin
				alu_code_reg <= `ORI_CODE;
				ctrl_code_reg <= `ORI_CTRL;
				inside_ctrl_code_reg <= {`ORI_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_XORI : begin
				alu_code_reg <= `XORI_CODE;
				ctrl_code_reg <= `XORI_CTRL;
				inside_ctrl_code_reg <= {`XORI_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_LUI : begin
				alu_code_reg <= `LUI_CODE;
				ctrl_code_reg <= `LUI_CTRL;
				inside_ctrl_code_reg <= {`LUI_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_LW : begin
				alu_code_reg <= `LW_CODE;
				ctrl_code_reg <= `LW_CTRL;
				inside_ctrl_code_reg <= {`LW_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_SW : begin
				alu_code_reg <= `SW_CODE;
				ctrl_code_reg <= `SW_CTRL;
				inside_ctrl_code_reg <= {`SW_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_BEQ : begin
				alu_code_reg <= `BEQ_CODE;
				ctrl_code_reg <= `BEQ_CTRL;
				inside_ctrl_code_reg <= {`BEQ_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_BNE : begin
				alu_code_reg <= `BNE_CODE;
				ctrl_code_reg <= `BNE_CTRL;
				inside_ctrl_code_reg <= {`BNE_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_SLTI : begin
				alu_code_reg <= `SLTI_CODE;
				ctrl_code_reg <= `SLTI_CTRL;
				inside_ctrl_code_reg <= {`SLTI_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_SLTIU : begin
				alu_code_reg <= `SLTIU_CODE;
				ctrl_code_reg <= `SLTIU_CTRL;
				inside_ctrl_code_reg <= {`SLTIU_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_PREF : begin
				alu_code_reg <= `PREF_CODE;
				ctrl_code_reg <= `PREF_CTRL;
				inside_ctrl_code_reg <= {`PREF_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
			`OP1_SPECIAL_INST : begin
				// 判断OP2
				case (`OP2)
					`OP2_ZERO : begin
						// 判断OP3
						case (`OP3)
							`OP3_ADD : begin
								alu_code_reg <= `ADD_CODE;
								ctrl_code_reg <= `ADD_CTRL;
								inside_ctrl_code_reg <= {`ADD_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_ADDU : begin
								alu_code_reg <= `ADDU_CODE;
								ctrl_code_reg <= `ADDU_CTRL;
								inside_ctrl_code_reg <= {`ADDU_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SUB : begin
								alu_code_reg <= `SUB_CODE;
								ctrl_code_reg <= `SUB_CTRL;
								inside_ctrl_code_reg <= {`SUB_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SUBU : begin
								alu_code_reg <= `SUBU_CODE;
								ctrl_code_reg <= `SUBU_CTRL;
								inside_ctrl_code_reg <= {`SUBU_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_AND : begin
								alu_code_reg <= `AND_CODE;
								ctrl_code_reg <= `AND_CTRL;
								inside_ctrl_code_reg <= {`AND_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_OR : begin
								alu_code_reg <= `OR_CODE;
								ctrl_code_reg <= `OR_CTRL;
								inside_ctrl_code_reg <= {`OR_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_XOR : begin
								alu_code_reg <= `XOR_CODE;
								ctrl_code_reg <= `XOR_CTRL;
								inside_ctrl_code_reg <= {`XOR_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_NOR : begin
								alu_code_reg <= `NOR_CODE;
								ctrl_code_reg <= `NOR_CTRL;
								inside_ctrl_code_reg <= {`NOR_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SLT : begin
								alu_code_reg <= `SLT_CODE;
								ctrl_code_reg <= `SLT_CTRL;
								inside_ctrl_code_reg <= {`SLT_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SLTU : begin
								alu_code_reg <= `SLTU_CODE;
								ctrl_code_reg <= `SLTU_CTRL;
								inside_ctrl_code_reg <= {`SLTU_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SLL : begin
								if (`OP5 == 0) begin
									alu_code_reg <= `SLL_CODE;
									ctrl_code_reg <= `SLL_CTRL;
									inside_ctrl_code_reg <= {`SLL_INCODE,ctrl_flag};
									ctrl_flag_reg <= ~ctrl_flag_reg;
								end
								else begin
									alu_code_reg <= `INVALID_CODE;
									ctrl_code_reg <= `INVALID_CTRL;
									inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
									ctrl_flag_reg <= ~ctrl_flag_reg;
								end
							end
							`OP3_SRL : begin
								if (`OP5 == 0) begin
									alu_code_reg <= `SRL_CODE;
									ctrl_code_reg <= `SRL_CTRL;
									inside_ctrl_code_reg <= {`SRL_INCODE,ctrl_flag};
									ctrl_flag_reg <= ~ctrl_flag_reg;
								end
								else begin
									alu_code_reg <= `INVALID_CODE;
									ctrl_code_reg <= `INVALID_CTRL;
									inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
									ctrl_flag_reg <= ~ctrl_flag_reg;
								end
							end
							`OP3_SRA : begin
								if (`OP5 == `OP5_ZERO) begin
									alu_code_reg <= `SRA_CODE;
									ctrl_code_reg <= `SRA_CTRL;
									inside_ctrl_code_reg <= {`SRA_INCODE,ctrl_flag};
									ctrl_flag_reg <= ~ctrl_flag_reg;
								end
								else begin
									alu_code_reg <= `INVALID_CODE;
									ctrl_code_reg <= `INVALID_CTRL;
									inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
									ctrl_flag_reg <= ~ctrl_flag_reg;
								end
							end
							`OP3_SLLV : begin
								alu_code_reg <= `SLLV_CODE;
								ctrl_code_reg <= `SLLV_CTRL;
								inside_ctrl_code_reg <= {`SLLV_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SRLV : begin
								alu_code_reg <= `SRLV_CODE;
								ctrl_code_reg <= `SRLV_CTRL;
								inside_ctrl_code_reg <= {`SRLV_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SRAV : begin
								alu_code_reg <= `SRAV_CODE;
								ctrl_code_reg <= `SRAV_CTRL;
								inside_ctrl_code_reg <= {`SRAV_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_JR : begin
								alu_code_reg <= `JR_CODE;
								ctrl_code_reg <= `JR_CTRL;
								inside_ctrl_code_reg <= {`JR_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							`OP3_SYNC : begin
								alu_code_reg <= `SYNC_CODE;
								ctrl_code_reg <= `SYNC_CTRL;
								inside_ctrl_code_reg <= {`SYNC_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
							default : begin
								alu_code_reg <= `INVALID_CODE;
								ctrl_code_reg <= `INVALID_CTRL;
								inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
						endcase
					end
					default : begin
						case (OP5)
							`OP5_ZERO : begin
								case (OP3)
									`OP3_SLL : begin
										alu_code_reg <= `SLL_CODE;
										ctrl_code_reg <= `SLL_CTRL;
										inside_ctrl_code_reg <= {`SLL_INCODE,ctrl_flag};
										ctrl_flag_reg <= ~ctrl_flag_reg;
									end
									`OP3_SRL : begin
										alu_code_reg <= `SRL_CODE;
										ctrl_code_reg <= `SRL_CTRL;
										inside_ctrl_code_reg <= {`SRL_INCODE,ctrl_flag};
										ctrl_flag_reg <= ~ctrl_flag_reg;
									end
									`OP3_SRA : begin
										alu_code_reg <= `SRA_CODE;
										ctrl_code_reg <= `SRA_CTRL;
										inside_ctrl_code_reg <= {`SRA_INCODE,ctrl_flag};
										ctrl_flag_reg <= ~ctrl_flag_reg;
									end
									default : begin
										alu_code_reg <= `INVALID_CODE;
										ctrl_code_reg <= `INVALID_CTRL;
										inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
										ctrl_flag_reg <= ~ctrl_flag_reg;
									end
								endcase
							end
							default : begin
								alu_code_reg <= `INVALID_CODE;
								ctrl_code_reg <= `INVALID_CTRL;
								inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
								ctrl_flag_reg <= ~ctrl_flag_reg;
							end
						endcase
					end
				endcase
			end
			default : begin
				alu_code_reg <= `INVALID_CODE;
				ctrl_code_reg <= `INVALID_CTRL;
				inside_ctrl_code_reg <= {`INVALID_INCODE,ctrl_flag};
				ctrl_flag_reg <= ~ctrl_flag_reg;
			end
		endcase
	end
end


endmodule 

