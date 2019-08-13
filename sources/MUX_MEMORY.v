`timescale 1ns / 1ps
module MUX_MEMORY(
    input sel,
    input [7:0] pc_addr,
    input [7:0] cu_addr,
    
    output reg [7:0] out
);

//initial out = 8'hzz;


//Asterisk for combinational logic
always@(*) begin
    case(sel)
        1'b0: out     = pc_addr;
        1'b1: out     = cu_addr;
        default: out   = 8'hzz;   //disconnect if no select
    endcase
end

endmodule
