`timescale 1ns / 1ps
module CTRL_CLK(
input CLK100MHZ,
output reg SLWCLK

);

reg [3:0] CTR;

initial CTR = 4'h0;
initial SLWCLK = 1'b0;

always@(posedge CLK100MHZ) begin
    CTR = CTR + 4'h1;
    if(CTR == 4'h8) SLWCLK = ~SLWCLK;

end

endmodule
