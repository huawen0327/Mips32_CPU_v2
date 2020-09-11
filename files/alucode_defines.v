// 
`define	OP1  		inst[31:26]
`define OP2 		inst[10:6]
`define OP3 		inst[5:0]
`define OP4 		inst[20:16]
`define OP5 		inst[31:21]

// 下面是op1码
`define	OP1_ADDI 6'b001000
`define	OP1_ADDIU 6'b001001
`define	OP1_ANDI 6'b001100
`define	OP1_ORI	6'b001101
`define	OP1_XORI 6'b001110
`define	OP1_LUI	6'b001111	
`define	OP1_LW 6'b100011	
`define	OP1_SW 6'b101011	
`define	OP1_BEQ 6'b000100
`define	OP1_BNE 6'b000101
`define	OP1_SLTI 6'b001010
`define	OP1_SLTIU 6'b001011
`define OP1_PREF 6'b110011
`define	OP1_SPECIAL_INST 6'b000000

// 下面是OP2码
`define	OP2_ZERO 5'b00000

// 下面是OP3
`define OP3_ADD 6'b100000
`define OP3_ADDU 6'b100001
`define OP3_SUB 6'b100010
`define OP3_SUBU 6'b100011
`define OP3_AND 6'b100100
`define OP3_OR 6'b100101
`define OP3_XOR 6'b100110
`define OP3_NOR 6'b100111
`define OP3_SLT 6'b101010
`define OP3_SLTU 6'b101011
`define OP3_SLL 6'b000000
`define OP3_SRL 6'b000010
`define OP3_SRA 6'b000011
`define OP3_SLLV 6'b000100
`define OP3_SRLV 6'b000110
`define OP3_SRAV 6'b000111
`define OP3_JR 6'b001000
`define OP3_SYNC 6'b001111 //sync指令的功能码
`define OP3_SPECIAL_INST 6'b000000 //SPECIAL类指令的指令码
// nop、ssnop、sync三条指令按nop处理，与sll $0,$0,0相同，所以按sll处理
// `define OP3_PREF 6'b110011 //pref指令的指令码

// 下面是OP5
`define	OP5_ZERO 		10'b0000000000

// 下面是ALU控制码
`define ADD_CODE		8'd0
`define ADDU_CODE		8'd1
`define SUB_CODE		8'd2
`define SUBU_CODE		8'd3
`define AND_CODE		8'd4
`define OR_CODE			8'd5
`define XOR_CODE		8'd6
`define NOR_CODE		8'd7
`define SLT_CODE		8'd8
`define SLTU_CODE		8'd9
`define SLL_CODE		8'd10
`define SRL_CODE		8'd11
`define SRA_CODE		8'd12
`define SLLV_CODE		8'd13
`define SRLV_CODE		8'd14
`define SRAV_CODE		8'd15
`define JR_CODE			8'd16
`define ADDI_CODE		8'd17
`define ADDIU_CODE		8'd18
`define ANDI_CODE		8'd19
`define ORI_CODE		8'd20
`define XORI_CODE		8'd12
`define LUI_CODE		8'd21
`define LW_CODE			8'd23
`define SW_CODE			8'd24
`define BEQ_CODE		8'd25
`define BNE_CODE		8'd26
`define SLTI_CODE		8'd27
`define SLTIU_CODE		8'd28
`define J_CODE			8'd29
`define JAL_CODE		8'd30

// 内部各个模块的控制码
// 6:JUMP_JR
// 5:4:ALU_SRC1
// 3:ALU_SRC0
// 2:SYMEX_SINAL
// 1:0:REG_DST
// #:CTRL_FLAG
// #:REG_WRITE
// 普通R型指令
`define ADD_INCODE		8'b0000001
`define ADDU_INCODE		8'b0000001
`define SUB_INCODE		8'b0000001
`define SUBU_INCODE		8'b0000001
`define AND_INCODE		8'b0000001
`define OR_INCODE		8'b0000001
`define XOR_INCODE		8'b0000001
`define NOR_INCODE		8'b0000001
`define SLT_INCODE		8'b0000001
`define SLTU_INCODE		8'b0000001
// SLL、SRL、SRA比较特别的R型指令
`define SLL_INCODE		8'b0010000
`define SRL_INCODE		8'b0010000
`define SRA_INCODE		8'b0010000
// 普通的R型指令
`define SLLV_INCODE		8'b0000001
`define SRLV_INCODE		8'b0000001
`define SRAV_INCODE		8'b0000001
// JR，特使的R型指令
`define JR_INCODE		8'b1000000
// I型指令
`define ADDI_INCODE		8'b0001100
`define ADDIU_INCODE	8'b0001000
`define ANDI_INCODE		8'b0001000
`define ORI_INCODE		8'b0001000
`define XORI_INCODE		8'b0001000
`define LUI_INCODE		8'b0001000
`define LW_INCODE		8'b0001100
`define SW_INCODE		8'b0001100
`define BEQ_INCODE		8'b0000100
`define BNE_INCODE		8'b0000100
`define SLTI_INCODE		8'b0001100
`define SLTIU_INCODE	8'b0001000
`define J_INCODE		8'b0000000
`define JAL_INCODE		8'b0110011

// ex模块的控制模块输出外部码
// 
// 5:Jumn
// 4:Branch
// 3:2:MemtoReg
// 1:MemWrite
// 0:RegWrite
`define ADD_CTRL		9'b0
`define ADDU_CTRL		9'b
`define SUB_CTRL		9'b
`define SUBU_CTRL		9'b
`define AND_CTRL		9'b
`define OR_CTRL			9'b
`define XOR_CTRL		9'b
`define NOR_CTRL		9'b
`define SLT_CTRL		9'b
`define SLTU_CTRL		9'b
`define SLL_CTRL		9'b
`define SRL_CTRL		9'b
`define SRA_CTRL		9'b
`define SLLV_CTRL		9'b
`define SRLV_CTRL		9'b
`define SRAV_CTRL		9'b
`define JR_CTRL			9'b
`define ADDI_CTRL		9'b
`define ADDIU_CTRL		9'b
`define ANDI_CTRL		9'b
`define ORI_CTRL		9'b
`define XORI_CTRL		9'b
`define LUI_CTRL		9'b
`define LW_CTRL			9'b
`define SW_CTRL			9'b
`define BEQ_CTRL		9'b
`define BNE_CTRL		9'b
`define SLTI_CTRL		9'b
`define SLTIU_CTRL		9'b
`define J_CTRL			9'b
`define JAL_CTRL		9'b

// INCODE码
`define ADD_INCODE 		9'b0

// 
`define ON 				1'b1
`define OFF				1'b0