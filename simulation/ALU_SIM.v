`timescale 1ns / 1ps

module ALU_SIM();

reg     [15:0] A;
reg     [15:0] B;
reg     [3:0] opcode;

wire    [15:0] ans;

ALU UUT(
.A      (A),
.B      (B),
.op     (opcode),
.ans    (ans)
);


initial begin
    A = 16'h8010;
    B = 16'h0008;
    
    #5 opcode = 4'h0;
    #5 opcode = 4'h1;
    #5 opcode = 4'h2;
    #5 opcode = 4'h3;
    #5 opcode = 4'h4;
    #5 opcode = 4'h5;
    #5 opcode = 4'h6;
    #5 opcode = 4'h7;
    


end
endmodule
