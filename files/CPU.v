module CPU(
input                        sys_clk,
output    [31:0]             GPIO
// output    [31:0]             out_test,
// output    [31:0]             out_test1,
// output    [31:0]             out_test2,
// output                       out_test_sinal,
// output                       out_test_clk
);

wire                            rst_async_n;
assign    rst_async_n =         1;
//变量，将系统时钟分成多少份
parameter sys_clk_bits = 8;
//各个模块的时钟都不一样，这里是设置时钟
`define   pc_clk             ClockAdjust_clk_out[sys_clk_bits-0]
`define   AddrMem_clk        ClockAdjust_clk_out[sys_clk_bits-1]
`define   Control_clk        ClockAdjust_clk_out[sys_clk_bits-2]
`define   RegFile_clk        ClockAdjust_clk_out[sys_clk_bits-4]
`define   RegFile_clk2       ClockAdjust_clk_out[sys_clk_bits-0]
`define   ALU_clk            ClockAdjust_clk_out[sys_clk_bits-6]
`define   GPIOsinal_clk      ClockAdjust_clk_out[sys_clk_bits-6]
`define   MUX3_clk           ClockAdjust_clk_out[sys_clk_bits-3]
`define   SymEx_clk          ClockAdjust_clk_out[sys_clk_bits-4]
`define   ALUControl_clk     ClockAdjust_clk_out[sys_clk_bits-5]
`define   DataMem_clk        ClockAdjust_clk_out[sys_clk_bits-7]
`define   GPIOReg_clk        ClockAdjust_clk_out[sys_clk_bits-7]
`define   MUX_clk            ClockAdjust_clk_out[sys_clk_bits-5]
`define   MUX_2_clk          ClockAdjust_clk_out[sys_clk_bits-7]
`define   Add_4_clk          ClockAdjust_clk_out[sys_clk_bits-1]
`define   PCMUX_clk          ClockAdjust_clk_out[sys_clk_bits-5]
`define   Add_clk            ClockAdjust_clk_out[sys_clk_bits-6]
`define   MUX3_1_clk         ClockAdjust_clk_out[sys_clk_bits-8]
`define   MUX1_clk           ClockAdjust_clk_out[sys_clk_bits-5]
`define   SymEx26_clk        ClockAdjust_clk_out[sys_clk_bits-4]
//各模块的使能信号
`define   Control_rst_n      rst_s2
`define   ClockAdjust_rst_n  rst_s2
`define   PC_rst_n           rst_s2
//设置控制模块的控制信号
// `define   MUX_sinal          Control_RegDst
`define   MUX_sinal          Control_ALUSrc[0]
`define   MUX1_sinal         Control_ALUSrc[1]
`define   RegFile_reg_write  Control_RegWrite
`define   MUX3_sinal         Control_RegDst
`define   SymEx_sinal        Control_ZeroExpend
`define   ALUControl_aluop   Control_ALUOp
`define   DataMem_wren       Control_MemWrite
`define   GPIOReg_write_sinal Control_MemWrite
`define   MUX_2_sinal        pc_and_out_data
`define   MUX3_1_sinal       Control_MemtoReg
`define   PCMUX_sinal        Control_PCSrc[2:1]
//指令对应的模块
`define   Control_inaddr     AddrMem_q[31:26]
`define   Control_inaddr2    AddrMem_q[15:0]
`define   RegFile_read_addr1 AddrMem_q[25:21]
`define   RegFile_read_addr2 AddrMem_q[20:16]
`define   MUX3_in_data1      AddrMem_q[20:16]
`define   MUX3_in_data2      AddrMem_q[15:11]
`define   SymEx_data_in      AddrMem_q[15:0]
`define   ALUControl_order5  AddrMem_q[5:0]
`define   SymEx26_data_in    AddrMem_q[25:0]
`define   MUX1_in_data2      AddrMem_q[15:11]
`define   Add_j_order        AddrMem_q[31:26]
`define   GPIOsinal_in_data  AddrMem_q[15:0]
//输出端口接输入端口
`define   AddrMem_addr       PC_pc_out
`define   RegFile_write_addr MUX3_out_data
`define   MUX_in_data1       RegFile_output_data2
`define   MUX_in_data2       SymEx_data_out
`define   ALU_input_data1    MUX1_out_data
`define   ALU_input_data2    MUX_out_data
`define   ALU_ctrl_sinal     ALUControl_alusinal
`define   DataMem_addr       ALU_output_data
`define   GPIOReg_addr       ALU_output_data
`define   DataMem_data       RegFile_output_data2
`define   GPIOReg_in_data    RegFile_output_data2
`define   RegFile_write_data MUX3_1_out_data
`define   Add_4_in_data      PC_pc_out
`define   MUX3_1_in_data1    ALU_output_data
`define   MUX3_1_in_data2    DataMem_q
`define   MUX3_1_in_data3    Add_4_out_data
`define   MUX1_in_data1      RegFile_output_data1
`define   PCMUX_in_data1     SymEx_data_out
`define   PCMUX_in_data2     RegFile_output_data1
`define   PCMUX_in_data3     SymEx26_data_out
`define   Add_in_data1       Add_4_out_data
`define   Add_in_data2       PCMUX_out_data
`define   MUX_2_in_data1     Add_4_out_data
`define   MUX_2_in_data2     Add_out_data
`define   PC_pc_in           MUX_2_out_data
`define   pc_and_in_data1    Control_PCSrc[0]
`define   pc_and_in_data2    ALU_output_pcsinal

//端口连线
wire      tmp;
wire      [sys_clk_bits:0]   ClockAdjust_clk_out;
wire      [31:0]             P;
wire      [31:0]             AddrMem_q;
wire      [1:0]              Control_RegDst;
wire      [1:0]              Control_ALUSrc;
wire                         Control_RegWrite;
wire      [1:0]              Control_MemtoReg;
wire                         Control_MemWrite;
wire                         Control_MemRead;
wire                         Control_ZeroExpend;
wire      [2:0]              Control_PCSrc;
wire      [2:0]              Control_ALUOp;

wire      [31:0]             PC_pc_out;
wire      [31:0]             RegFile_output_data1;
wire      [31:0]             RegFile_output_data2;
wire      [4:0]              MUX3_out_data;
wire      [31:0]             MUX_out_data;
wire      [31:0]             SymEx_data_out;
wire      [31:0]             ALU_output_data;
wire                         ALU_output_pcsinal;
wire      [5:0]              ALUControl_alusinal;
wire      [31:0]             DataMem_q;
wire      [31:0]             Add_4_out_data;
wire      [31:0]             PCMUX_out_data;
wire      [31:0]             Add_out_data;
wire      [31:0]             MUX_2_out_data;
wire      [31:0]             MUX3_1_out_data;
wire      [31:0]             SymEx26_data_out;
wire                         pc_and_out_data;
wire      [31:0]             MUX1_out_data;
// assign    MUX_2_sinal = Control_PCSrc[0] & ALU_output_pcsinal;

//异步复位，同步释放
reg                          rst_s1;
reg                          rst_s2;
reg                          rst_s3;
always @ (posedge sys_clk, negedge rst_async_n)
begin
    if (!rst_async_n) begin   
        rst_s1 <= 1'b0;  
        rst_s2 <= 1'b0;
        rst_s3 <= 1'b1;  
    end  
    else begin  
        rst_s1 <= 1'b1;  
        rst_s2 <= rst_s1;
        rst_s3 <= 1'b1;  
    end
end


//例化时钟模块
ClockAdjust #(.clk_bits(sys_clk_bits))  u_ClockAdjust (
    .clk_in                  ( sys_clk             ),
    .rst_n                   ( rst_s2              ),

    .clk_out                 ( ClockAdjust_clk_out )
);

//例化PC
PC  u_PC ( 

    .clk                     ( `pc_clk        ),
    .rst_n                   ( `PC_rst_n      ),
    .pc_in                   ( `PC_pc_in      ),

    .pc_out                  ( PC_pc_out     )
);

//例化指令存储器
AddrMem  u_AddrMem (
    .address                 ( `AddrMem_addr          ),
    .clock                   ( `AddrMem_clk           ),
 
    .q                       ( AddrMem_q             )
);

//例化控制模块，控制模块输出各个模块的控制信号
Control  u_Control (
    .clk                     ( `Control_clk           ),
    .rst_n                   ( `Control_rst_n         ),
    .inaddr                  ( `Control_inaddr        ),
    .inaddr2                 ( `Control_inaddr2       ),

    .RegDst                  ( Control_RegDst        ),
    .ALUSrc                  ( Control_ALUSrc        ),
    .RegWrite                ( Control_RegWrite      ),
    .MemtoReg                ( Control_MemtoReg      ),
    .MemWrite                ( Control_MemWrite      ),
    .MemRead                 ( Control_MemRead       ),
    .ZeroExpend              ( Control_ZeroExpend    ),
    .PCSrc                   ( Control_PCSrc         ),
    .ALUOp                   ( Control_ALUOp         )
);

//例化寄存器堆
wire [31:0] RegFile_testreg;
RegFile  u_RegFile (
    .clk                     ( `RegFile_clk              ),
    .clk2                    ( `RegFile_clk2              ),
    .reg_write               ( `RegFile_reg_write        ),
    .read_addr1              ( `RegFile_read_addr1       ),
    .read_addr2              ( `RegFile_read_addr2       ),
    .write_addr              ( `RegFile_write_addr       ),
    .write_data              ( `RegFile_write_data       ),

    .output_data1            ( RegFile_output_data1     ),
    .output_data2            ( RegFile_output_data2     ),
    .testreg                 ( RegFile_testreg          )
);

//例化写寄存器处的三选器
parameter data_bits = 4;
MUX3 #(.data_bits(data_bits)) u_MUX3 (
    .clk                     ( `MUX3_clk              ),
    .sinal                   ( `MUX3_sinal            ),
    .in_data1                ( `MUX3_in_data1         ),
    .in_data2                ( `MUX3_in_data2         ),

    .out_data                ( MUX3_out_data         )
);

//例化16位符号拓展
SymEx  u_SymEx (
    .clk                     ( `SymEx_clk             ),
    .sinal                   ( `SymEx_sinal           ),
    .data_in                 ( `SymEx_data_in         ),

    .data_out                ( SymEx_data_out        )
);

//ALU输入2处的双选器
MUX #(.data_bits(31)) u_MUX (
    .clk                     ( `MUX_clk               ),
    .sinal                   ( `MUX_sinal             ),
    .in_data1                ( `MUX_in_data1          ),
    .in_data2                ( `MUX_in_data2          ),
    
    .out_data                ( MUX_out_data          )
);
//ALU输入1处的MUX
MUX #(.data_bits(31)) u_MUX1 (
    .clk                     ( `MUX1_clk              ),
    .sinal                   ( `MUX1_sinal            ),
    .in_data1                ( `MUX1_in_data1         ),
    .in_data2                ( `MUX1_in_data2         ),
    
    .out_data                ( MUX1_out_data          )
);

//例化ALU
ALU  u_ALU (
    .clk                     ( `ALU_clk               ),
    .input_data1             ( `ALU_input_data1       ),
    .input_data2             ( `ALU_input_data2       ),
    .ctrl_sinal              ( `ALU_ctrl_sinal        ),

    .output_data             ( ALU_output_data       ),
    .output_pcsinal          ( ALU_output_pcsinal    ),
);

//例化ALUControl
ALUControl  u_ALUControl (
    .clk                     ( `ALUControl_clk        ),
    .aluop                   ( `ALUControl_aluop      ),
    .order5                  ( `ALUControl_order5     ),

    .alusinal                ( ALUControl_alusinal    )
);

//例化数据存储器
DataMem  u_DataMem (
    .address                 ( `DataMem_addr          ),
    .clock                   ( `DataMem_clk           ),
    .clken                   ( `DataMem_clken         ),
    .data                    ( `DataMem_data          ),
    .wren                    ( `DataMem_wren          ),

    .q                       ( DataMem_q             )
);

//例化PC+4
Add_4  u_Add_4 (
    .clk                     ( `Add_4_clk             ),
    .in_data                 ( `Add_4_in_data         ),

    .out_data                ( Add_4_out_data        )
);

//PCMUX，两位控制信号，三输入：rs寄存器、16位符号拓展、26位无符号拓展
PCMUX #(.data_bits(31)) u_PCMUX (
    .clk                     ( `PCMUX_clk            ),
    .sinal                   ( `PCMUX_sinal          ),
    .in_data1                ( `PCMUX_in_data1       ),
    .in_data2                ( `PCMUX_in_data2       ),
    .in_data3                ( `PCMUX_in_data3       ),

    .out_data                ( PCMUX_out_data       )
);

//跳转处的add
Add  u_Add (
    .clk                     ( `Add_clk              ),
    .in_data1                ( `Add_in_data1         ),
    .in_data2                ( `Add_in_data2         ),
    .j_order                 ( `Add_j_order          ),

    .out_data                ( Add_out_data         )
);

//例化PCMUX bit0
MUXRst #(.data_bits(31)) u_MUX_2 (
    .clk                     ( `MUX_2_clk             ),
    .sinal                   ( `MUX_2_sinal           ),
    .rst_n                   ( rst_s2                 ),
    .in_data1                ( `MUX_2_in_data1        ),
    .in_data2                ( `MUX_2_in_data2        ),

    .out_data                ( MUX_2_out_data        )
);

//例化即将写寄存器堆的三选器
MUX3_1 #(.data_bits(31)) u_MUX3_1 (
    .clk                     ( `MUX3_1_clk            ),
    .sinal                   ( `MUX3_1_sinal          ),
    .in_data1                ( `MUX3_1_in_data1       ),
    .in_data2                ( `MUX3_1_in_data2       ),
    .in_data3                ( `MUX3_1_in_data3       ),
    .in_data4                ( `MUX3_1_in_data4       ),

    .out_data                ( MUX3_1_out_data       )
);

//例化26位拓展
SymEx26 u_SymEx26 (
    .clk                     ( `SymEx26_clk           ),
    .data_in                 ( `SymEx26_data_in       ),

    .data_out                ( SymEx26_data_out      )
);

pc_and  u_pc_and (
    .in_data1                ( `pc_and_in_data1       ),
    .in_data2                ( `pc_and_in_data2       ),

    .out_data                ( pc_and_out_data        )
);

wire          [31:0]         GPIOReg_GPIO;
assign        GPIO =         GPIOReg_GPIO;
`define  MUX3_1_in_data4     GPIOReg_GPIO
GPIOReg  u_GPIOReg (
    .clk                     ( `GPIOReg_clk            ),
    .rst_n                   ( `GPIOReg_rst_n          ),
    .write_sinal             ( `GPIOReg_write_sinal    ),
    .addr                    ( `GPIOReg_addr           ),
    .in_data                 ( `GPIOReg_in_data        ),

    .GPIO                    ( GPIOReg_GPIO            )
);

// 选择io口寄存器还是ram
wire                         GPIOsinal_gpio_sinal, GPIOsinal_mem_sinal;
`define  GPIOReg_rst_n       GPIOsinal_gpio_sinal
`define  DataMem_clken       GPIOsinal_mem_sinal
GPIOsinal  u_GPIOsinal (
    .clk                     ( `GPIOsinal_clk           ),
    .in_data                 ( `GPIOsinal_in_data       ),

    .gpio_sinal              ( GPIOsinal_gpio_sinal    ),
    .mem_sinal               ( GPIOsinal_mem_sinal     )
);



//下面是测试部分
// `define test_sinal
`ifdef test_sinal
    
    
    assign out_test  = `GPIOReg_addr;
    assign out_test1 = `GPIOReg_in_data;
    assign out_test_sinal = `GPIOReg_clk;
    assign out_test_clk = `GPIOReg_rst_n;
    assign out_test2 = `GPIOReg_write_sinal;
`endif


endmodule













