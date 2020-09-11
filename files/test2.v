module test2(input_data11, input_data12, output_data1, ctrl_sinal1);


input[31:0] input_data11;
input[31:0] input_data12;
input[3:0]  ctrl_sinal1;

output[31:0] output_data1;

ALU alu2(input_data11, input_data12, output_data1, ctrl_sinal1);

endmodule