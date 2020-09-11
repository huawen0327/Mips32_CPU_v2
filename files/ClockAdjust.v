module ClockAdjust(clk_in, rst_n, clk_out);

parameter clk_bits = 4;

input                  clk_in;
input                  rst_n;
output  [clk_bits:0]   clk_out;

reg     [clk_bits:0]   clk_reg;
//reg     clk_reg;
// 
integer cnt;

always @(posedge clk_in or negedge rst_n)
begin

	if(!rst_n) begin
      clk_reg <= 1;
      cnt <= 0;
   end
   else begin
      if(cnt == 1000)begin
         clk_reg <= {clk_reg[0],clk_reg[clk_bits:1]};
         cnt<=0;
      end
      else
         cnt<=cnt+1;
      // cnt<=cnt+1;
   end
end

assign clk_out = clk_reg;


// module Clk_1(clk_50m,clk_1);
// input clk_50m;
// output reg clk_1;
// integer cnt;//定义计数器寄存器

// //计数器计数进程
// always@(posedge clk_50m)
// if(cnt == 24_999_999)begin   //50m的一半
// cnt<=0;clk_1=~clk_1;
// end
// else
// cnt<=cnt+1;

// endmodule 

endmodule