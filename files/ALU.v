/*
模块：ALU
ALU控制码：
*/
module ALU(clk, input_data1, input_data2, output_data, ctrl_sinal, output_pcsinal);

input                 clk;
input     [31:0]      input_data1;
input     [31:0]      input_data2;
input     [4:0]       ctrl_sinal;
output    [31:0]      output_data;
output                output_pcsinal;
reg       [31:0]      output_data;
reg                   output_pcsinal;

parameter ALU_add = 4'b0000;    //加法
parameter ALU_sub = 4'b0001;    //减法
parameter ALU_and = 4'b0010;    //与
parameter ALU_or  = 4'b0011;    //或
parameter ALU_xor = 4'b0100;    //异或
parameter ALU_nor = 4'b0101;    //或非
parameter ALU_slt = 4'b0110;    //小于则置一
parameter ALU_sll = 4'b1000;    //逻辑左移
parameter ALU_srl = 4'b1001;    //逻辑右移
parameter ALU_sra = 4'b1010;    //算术右移
parameter ALU_bne = 4'b1011;    //不相等跳转
parameter ALU_lui = 4'b1100;    //左移16位

always @(posedge clk)
begin
	case(ctrl_sinal)
		ALU_add : begin 
		    output_data = input_data1 + input_data2;
			output_pcsinal = 1;
		end
		ALU_sub : begin 
			output_data = input_data1 - input_data2;
			output_pcsinal = 1;
		end
		ALU_and : begin //和同或共用
			output_data = input_data1 & input_data2;
			if(input_data1 == input_data2) 
				output_pcsinal = 1;
			else output_pcsinal = 0;
		end
		ALU_or  : begin
			output_data = input_data1 | input_data2;
			output_pcsinal = 1;
		end
		ALU_xor : begin
			output_data = input_data1 ^ input_data2;
			output_pcsinal = 1;
		end
		ALU_nor : begin
			output_data = ~(input_data1 | input_data2);
			output_pcsinal = 1;
		end
		ALU_slt : begin
			output_data = (input_data1 < input_data2);
			output_pcsinal = 1;
		end
		ALU_sll : begin
			output_data = input_data2 << input_data1;
			output_pcsinal = 1;
		end
		ALU_srl : begin
			output_data = input_data2 >> input_data1;
			output_pcsinal = 1;
		end
		ALU_sra : begin
			output_data = ($signed(input_data2)) >>> input_data1;
			output_pcsinal = 1;
		end
		ALU_lui : begin
			output_data = input_data2 * 65536;
			output_pcsinal = 1;
		end
		// ALU_sll: output_data = input_data1 << input_data2;
		// ALU_srl: output_data = input_data1 >> input_data2;
		// ALU_sra: output_data = input_data1 >> input_data2;

		ALU_bne: begin
			if(input_data1 != input_data2) 
				output_pcsinal = 1;
			else output_pcsinal = 0;
		end
	endcase
end

endmodule