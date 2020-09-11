module Add_4(
input             clk,
input   [31:0]    in_data,

output  [31:0]    out_data
);
reg     [31:0]   out_reg;

always @(posedge clk)
begin
    out_reg = in_data + 1;
end

assign out_data = out_reg;
endmodule