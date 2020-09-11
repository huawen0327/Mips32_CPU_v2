module SymEx26(clk, rst, inst_in, pc_in, data_out);

// parameter              data_bits = 4;
input                   clk;
input 					rst;
input    [25:0]		    inst_in;
output   [3:0]  		pc_in;

reg      [31:0]			data_out_reg;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		// reset
		data_out_reg <= 32'b0;
	end
	else begin
		data_out_reg <= {inst_in<<2, pc_in};
	end
end

assign  data_out = data_out_reg;
// always @(flag) begin

//     data_out_reg = {inst_in<<2, pc_in};

// end

// assign  data_out = data_out_reg;

endmodule
