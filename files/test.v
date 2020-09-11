//`include "ALU.v"
//module test(input_data1, input_data2, output_data, ctrl_sinal);
//
//
//input[31:0] input_data1;
//input[31:0] input_data2;
//input[3:0]  ctrl_sinal;
//
//output[31:0] output_data;
//
//ALU alu1(input_data1, input_data2, output_data, ctrl_sinal);
//
//endmodule
`timescale 10ns/100ps
//module test(clk, clk1);
//input clk;
//output clk1;
//reg clk1;
//assign # 2 clk2 = clk;
//assign clk1 = clk2;
//endmodule
module test(clk,test1,test);

input      clk;
output[31:0] test1;
output[31:0] test;

reg[31:0] pc_temp;

PC pc(
		.in_pc(pc_temp), 
		.out_pc(test1)
		);

//assign test1 = pc_o;
assign test = pc_temp;

always @(posedge clk)
begin

pc_temp = pc_temp+4;


end		
		
endmodule




