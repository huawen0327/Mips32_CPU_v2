module SymEx(flag, sinal, data_in, data_out);


input                  flag, sinal;
input    [15:0]        data_in;
output   [32:0]        data_out;

wire    			   add_flag;
reg 				   add_flag_reg;
reg      [32:0]        data_reg;

always @(flag) begin
	// if (rst) begin
	// 	// reset
	// 	data_reg <= 32'b0;
	// 	add_flag_reg <= 0;
	// end
	// else 
    if (!sinal) begin
        data_reg[15:0] <= data_in;
        data_reg[31:16] <= {16{data_in[15]}};
        data_reg[32] <= add_flag_reg;
        add_flag_reg <= ~add_flag_reg;
    end
    else begin
        data_reg[15:0] <= data_in;
        data_reg[31:16] <= 16'b0000000000000000;
        data_reg[32] <= add_flag_reg;
        add_flag_reg <= ~add_flag_reg;
	end
end

assign data_out = data_reg;
assign add_flag = add_flag_reg;

endmodule
