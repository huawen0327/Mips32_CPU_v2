module ALUControl(
    input             clk,
    input  [3:0]      aluop,
    input  [5:0]      order5,
    output [5:0]      alusinal
);

reg         [5:0]     outr;
always @(posedge clk)
begin
	case (order5)
        6'b000000 : begin
            case (aluop)
                6'b100000 : outr = 4'b0000;  //add
                6'b100001 : outr = 4'b0000;  //addu
                6'b100010 : outr = 4'b0001;  //sub
                6'b100011 : outr = 4'b0001;  //subu
                6'b100100 : outr = 4'b0010;  //and
                6'b100101 : outr = 4'b0011;  //or
                6'b100110 : outr = 4'b0100;  //xor
                6'b100111 : outr = 4'b0101;  //nor
                6'b101010 : outr = 4'b0110;  //小于置一
                6'b101011 : outr = 4'b0110;
                6'b000000 : outr = 4'b1000;  //逻辑左移
                6'b000010 : outr = 4'b1001;  //逻辑右移
                6'b000011 : outr = 4'b1010;  //算术右移
                6'b000100 : outr = 4'b1000;  //逻辑左移
                6'b000110 : outr = 4'b1001;  //逻辑右移
                6'b000111 : outr = 4'b1010;  //算术右移
                6'b001000 : outr = 4'b0000;  //jr
                default   : outr = 4'b0000; 
            endcase
        end
        6'b001000 : outr = 4'b0000;
        6'b001001 : outr = 4'b0000;
        6'b001100 : outr = 4'b0010;
        6'b001101 : outr = 4'b0011;
        6'b001110 : outr = 4'b0100;
        6'b001111 : outr = 4'b1100;
        6'b100011 : outr = 4'b0000;
        6'b101011 : outr = 4'b0000;
        6'b000100 : outr = 4'b0010;
        6'b000101 : outr = 4'b1011;
        6'b001010 : outr = 4'b0110;
        6'b001011 : outr = 4'b0110;
        default   : outr = 4'b0000;

    endcase
end

endmodule