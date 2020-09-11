module Add(
input             clk,
input   [31:0]    in_data1,
input   [31:0]    in_data2,
input   [5:0]     j_order,

output  [31:0]    out_data
);
reg     [31:0]    out_reg;

always @(posedge clk)
begin
    if(j_order == 6'b000000) out_reg = in_data2;
    else if(j_order == 6'b000010) out_reg = in_data2;
    else if(j_order == 6'b000011) out_reg = in_data2;
    else out_reg = in_data1 + in_data2; 
end

assign out_data = out_reg;
endmodule