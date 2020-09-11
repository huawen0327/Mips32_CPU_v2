module MUX(sinal, in_data0, in_data1, in_data2, out_data);

parameter                    data_bits = 31;
input    [2:0]               sinal;
input    [data_bits:0]       in_data0;
input    [data_bits:0]       in_data1;
input    [data_bits:0]       in_data2;
output   [data_bits:0]       out_data;
reg      [data_bits:0]       out_data;

always @(*)
begin
	if (sinal==00) begin
		out_data = in_data0;
	end
	else if (sinal==01) begin
		out_data = in_data1;
	end
	else begin
		out_data = in_data2;
	end
end

endmodule