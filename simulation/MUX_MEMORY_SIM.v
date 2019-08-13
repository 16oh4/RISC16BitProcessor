`timescale 1ns / 1ps
module MUX_MEMORY_SIM();

reg sel;
reg [7:0] pc_addr;
reg [7:0] cu_addr;

wire [7:0] out;

MUX_MEMORY UUT(
.sel        (sel),
.pc_addr    (pc_addr),
.cu_addr    (cu_addr),

.out        (out)
);

initial begin

pc_addr = 8'hA7;
cu_addr = 8'h6B;

sel = 0;
#10 sel = 1;
#10 sel = 1'bz;
#10 sel = 1'bx;




end


endmodule
