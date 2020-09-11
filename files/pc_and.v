module pc_and(in_data1, in_data2, out_data);

input          in_data1;
input          in_data2;
output          out_data;

assign out_data = in_data1 & in_data2;

endmodule