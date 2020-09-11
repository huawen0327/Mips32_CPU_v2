module MUXRst(clk, sinal, rst_n, in_data1, in_data2, out_data);

parameter                    data_bits = 31;
input                        clk, sinal, rst_n;
input    [data_bits:0]       in_data1;
input    [data_bits:0]       in_data2;
output   [data_bits:0]       out_data;
reg      [data_bits:0]       out_data;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin
        out_data <= 0;
    end
    else begin
        if (sinal==0)
            out_data = in_data1;
        else
            out_data = in_data2;
    end
end

endmodule