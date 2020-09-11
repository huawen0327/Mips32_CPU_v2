module RegFile(read_addr1, read_addr2, write_addr, write_data, output_data1, output_data2, clk, reg_write, clk2);

input        clk, clk2, reg_write;
input[4:0]   read_addr1;
input[4:0]   read_addr2;
input[4:0]   write_addr;
input[31:0]  write_data;
// input        RegWrite_sinal;
output[31:0] output_data1;
output[31:0] output_data2;
reg[31:0]    output_data1;
reg[31:0]    output_data2;

//测试
// output[31:0]    testreg;
// assign          testreg = reg_t[2];

reg[31:0]    reg_zero;         //返回值永远是0
reg[31:0]    reg_at;           //汇编器的暂时变量
reg[31:0]    reg_v[1:0];       //子函数调用返回结果
reg[31:0]    reg_a[3:0];       //子函数调用的参数
reg[31:0]    reg_t[9:0];       //暂时变量，子函数使用时不需要保存与恢复
                               //t[7:0]地址为：15-8；t[9:8]地址为：25-24
reg[31:0]    reg_s[7:0];       //子函数寄存器变量。子函数必须保存和恢复使用过的变量在函数返回之前，从而调用函数知道这些寄存器的值没有变化
reg[31:0]    reg_k[1:0];       //通常被中断或异常处理程序使用作为保存一些系统参数
reg[31:0]    reg_gp;           //全局指针。一些运行系统维护这个指针来更方便的存取“static“和”extern”变量
reg[31:0]    reg_sp;           //堆栈指针
reg[31:0]    reg_fp;           //第9个寄存器变量。子函数可以用来做桢指针
reg[31:0]    reg_ra;           //子函数的返回地

always @(posedge clk2)
begin
	if(reg_write) begin
		case(write_addr)
			5'd0 : reg_zero = 0;
			5'd1 : reg_at   = write_data;
			5'd2 : reg_v[0] = write_data;
			5'd3 : reg_v[1] = write_data;
			5'd4 : reg_a[0] = write_data;
			5'd5 : reg_a[1] = write_data;
			5'd6 : reg_a[2] = write_data;
			5'd7 : reg_a[3] = write_data;
			5'd8 : reg_t[0] = write_data;
			5'd9 : reg_t[1] = write_data;
			5'd10: reg_t[2] = write_data;
			5'd11: reg_t[3] = write_data;
			5'd12: reg_t[4] = write_data;
			5'd13: reg_t[5] = write_data;
			5'd14: reg_t[6] = write_data;
			5'd15: reg_t[7] = write_data;
			5'd16: reg_s[0] = write_data;
			5'd17: reg_s[1] = write_data;
			5'd18: reg_s[2] = write_data;
			5'd19: reg_s[3] = write_data;
			5'd20: reg_s[4] = write_data;
			5'd21: reg_s[5] = write_data;
			5'd22: reg_s[6] = write_data;
			5'd23: reg_s[7] = write_data;
			5'd24: reg_t[8] = write_data;
			5'd25: reg_t[9] = write_data;
			5'd26: reg_k[0] = write_data;
			5'd27: reg_k[1] = write_data;
			5'd28: reg_gp   = write_data;
			5'd29: reg_sp   = write_data;
			5'd30: reg_fp   = write_data;
			5'd31: reg_ra   = write_data;
		endcase
	end
end

always @(clk)
begin
	case(read_addr1)
		5'd0 : output_data1 = reg_zero;
		5'd1 : output_data1 = reg_at;
		5'd2 : output_data1 = reg_v[0];
		5'd3 : output_data1 = reg_v[1];
		5'd4 : output_data1 = reg_a[0];
		5'd5 : output_data1 = reg_a[1];
		5'd6 : output_data1 = reg_a[2];
		5'd7 : output_data1 = reg_a[3];
		5'd8 : output_data1 = reg_t[0];
		5'd9 : output_data1 = reg_t[1];
		5'd10: output_data1 = reg_t[2];
		5'd11: output_data1 = reg_t[3];
		5'd12: output_data1 = reg_t[4];
		5'd13: output_data1 = reg_t[5];
		5'd14: output_data1 = reg_t[6];
		5'd15: output_data1 = reg_t[7];
		5'd16: output_data1 = reg_s[0];
		5'd17: output_data1 = reg_s[1];
		5'd18: output_data1 = reg_s[2];
		5'd19: output_data1 = reg_s[3];
		5'd20: output_data1 = reg_s[4];
		5'd21: output_data1 = reg_s[5];
		5'd22: output_data1 = reg_s[6];
		5'd23: output_data1 = reg_s[7];
		5'd24: output_data1 = reg_t[8];
		5'd25: output_data1 = reg_t[9];
		5'd26: output_data1 = reg_k[0];
		5'd27: output_data1 = reg_k[1];
		5'd28: output_data1 = reg_gp;
		5'd29: output_data1 = reg_sp;
		5'd30: output_data1 = reg_fp;
		5'd31: output_data1 = reg_ra;
	endcase
	case(read_addr2)
		5'd0 : output_data2 = reg_zero;
		5'd1 : output_data2 = reg_at;
		5'd2 : output_data2 = reg_v[0];
		5'd3 : output_data2 = reg_v[1];
		5'd4 : output_data2 = reg_a[0];
		5'd5 : output_data2 = reg_a[1];
		5'd6 : output_data2 = reg_a[2];
		5'd7 : output_data2 = reg_a[3];
		5'd8 : output_data2 = reg_t[0];
		5'd9 : output_data2 = reg_t[1];
		5'd10: output_data2 = reg_t[2];
		5'd11: output_data2 = reg_t[3];
		5'd12: output_data2 = reg_t[4];
		5'd13: output_data2 = reg_t[5];
		5'd14: output_data2 = reg_t[6];
		5'd15: output_data2 = reg_t[7];
		5'd16: output_data2 = reg_s[0];
		5'd17: output_data2 = reg_s[1];
		5'd18: output_data2 = reg_s[2];
		5'd19: output_data2 = reg_s[3];
		5'd20: output_data2 = reg_s[4];
		5'd21: output_data2 = reg_s[5];
		5'd22: output_data2 = reg_s[6];
		5'd23: output_data2 = reg_s[7];
		5'd24: output_data2 = reg_t[8];
		5'd25: output_data2 = reg_t[9];
		5'd26: output_data2 = reg_k[0];
		5'd27: output_data2 = reg_k[1];
		5'd28: output_data2 = reg_gp;
		5'd29: output_data2 = reg_sp;
		5'd30: output_data2 = reg_fp;
		5'd31: output_data2 = reg_ra;
	endcase
end

endmodule