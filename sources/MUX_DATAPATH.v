`timescale 1ns / 1ps

module MUX_DATAPATH(
    input [15:0] alu_data,
    input [15:0] mem_data,
    input [7:0]  cu_data,
    input [1:0] sel,
    
    output reg [15:0] out  
);

//Disconnect output initially
initial out = 16'hzzzz;

//Asterisk for combinational logic
always@(*) begin
    case(sel)
        2'b00: out     = alu_data;
        2'b01: out     = mem_data;
        2'b10: out     = { {8{cu_data[7]}}, cu_data};  //sign extend to 16-bits
        default: out   = 16'hzzzz;                     //disconnect if no select
    endcase
end

endmodule
