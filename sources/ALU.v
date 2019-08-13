`timescale 1ns / 1ps

module ALU(
    input       [15:0] A,
    input       [15:0] B,
    input       [3:0] op,
    
    output reg [15:0] ans
);


/* Opcodes
   0: ADD
   1: SUB
   2: AND
   3: OR
   4: XOR
   5: NOT
   6: SLL/SLA
   7: SRA
*/

initial ans = 16'hzzzz;

always@(*) begin
    case(op)
        4'h0: ans = A+B;
        4'h1: ans = A-B;
        4'h2: ans = A&B;
        4'h3: ans = A|B;
        4'h4: ans = A^B;
        4'h5: ans = ~A;
        4'h6: ans = A << 1;
        4'h7: ans = $signed(A) >>> 1;
        default: ans = ans;
    endcase
end

endmodule
