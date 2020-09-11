module MUX(sinal, in_data0, in_data1, out_data);

parameter                    data_bits = 31;
input                        sinal;
input    [data_bits:0]       in_data0;
input    [data_bits:0]       in_data1;
output   [data_bits:0]       out_data;
reg      [data_bits:0]       out_data;

always @(*)
begin
	if (sinal==0)
		out_data = in_data0;
	else
		out_data = in_data1;
end

endmodule