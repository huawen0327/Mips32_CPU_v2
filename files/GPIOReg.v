module GPIOReg
(
    input                   clk, 
    input                   rst_n,
    input                   write_sinal,
    input     [31:0]        addr,
    input     [31:0]        in_data,

    output    [31:0]        GPIO
);

reg           [31:0]         GPIO_reg;

always @(posedge clk)
begin
    case (addr)
            32'd1024 : GPIO_reg <= in_data;
            default  : ;
    endcase
    // else begin
    // GPIO_reg <= in_data;
    //     if(write_sinal) begin
    //         case (addr)
    //             32'd1024 : GPIO_reg <= in_data;
    //             default  : GPIO_reg <= in_data;
    //         endcase
    //     end
    // end
end

assign GPIO = GPIO_reg;

endmodule
