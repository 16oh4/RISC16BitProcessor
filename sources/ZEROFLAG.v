`timescale 1ns / 1ps
module ZEROFLAG(
    input [15:0] num,
    output zeroflag
);

assign zeroflag = ~(num);


endmodule
