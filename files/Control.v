
/*

*/

module Control(

    input                 clk, rst_n,
    input    [5:0]        inaddr,
    input    [15:0]       inaddr2,
    output   [1:0]        RegDst, ALUSrc, MemtoReg,
    output                RegWrite, MemWrite, MemRead, ZeroExpend,
    output   [2:0]        PCSrc, ALUOp

);
                 
reg          [15:0]       outd;

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
      outd = 16'b0000000000000000;
    else begin
        case (inaddr)
            6'b000000 : begin
                case (inaddr2[5:0])
                    6'b000000: outd = 16'b0110001000001000;
                    6'b000010: outd = 16'b0110001000001000;
                    6'b000011: outd = 16'b0110001000001000;
                    6'b001000: outd = 16'b0000000000110000;
                    default:   outd = 16'b0100001000001000;
                endcase
            end
            6'b001000 : outd = 16'b0001001000000010;
            6'b001001 : outd = 16'b0001001000000011;
            6'b001100 : outd = 16'b0001001000000101;
            6'b001101 : outd = 16'b0001001000000111;
            6'b001110 : outd = 16'b0001001000001111;
            6'b001111 : outd = 16'b0001001000001100;
            6'b100011 : begin
                if(inaddr2>1023) outd = 16'b0001111100000000;
                else outd = 16'b0001011100000000;
            end
            6'b101011 : outd = 16'b0001000010000000;
            6'b000100 : outd = 16'b0000000000010100;
            6'b000101 : outd = 16'b0000000000010010;
            6'b001010 : outd = 16'b0001001000001010;
            6'b001011 : outd = 16'b0001001000001011;
            6'b000010 : outd = 16'b0000000001010000;
            6'b000011 : outd = 16'b1000101001011110;
            default   : outd = 16'b0000000000000000;
        endcase
    end
end

assign RegDst[1]  = outd[15],   RegDst[0]  = outd[14],
       ALUSrc[1]  = outd[13],   ALUSrc[0]  = outd[12],
       MemtoReg[1]= outd[11],   MemtoReg[0]= outd[10],
       RegWrite   = outd[9],
       MemRead    = outd[8],
       MemWrite   = outd[7],
       PCSrc[2]   = outd[6],    PCSrc[1]    = outd[5],      PCSrc[0] = outd[4],
       ALUOp[2]   = outd[3],    ALUOp[1]    = outd[2],      ALUOp[0] = outd[1],
       ZeroExpend = outd[0];

endmodule
