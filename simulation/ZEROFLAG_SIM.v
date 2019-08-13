`timescale 1ns / 1ps
module ZEROFLAG_SIM();

reg [15:0] num;
wire zeroflag;

ZEROFLAG UUT(
.num        (num),
.zeroflag   (zeroflag)
);

initial begin
    num = 16'h0001;
end

endmodule
