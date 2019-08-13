`timescale 1ns / 1ps
module CONTROLLER(
input CLK100MHZ,
input CLKSLOW,

input [15:0] ir_inst,

input dp_zf_flag,

//TO PC
output reg pc_load,
output reg pc_clear,
output reg pc_inc,

//TO IR
output reg ir_load,

//TO MEMBANK
output reg mb_sel,
output reg [7:0] mb_addr,

output reg mb_read,
output reg mb_write,

//TO DP
output reg [7:0] dp_imm,
output reg [1:0] dp_sel,

output reg [3:0] dp_write_addr,
output reg dp_write,

output reg [3:0] dp_a_addr,
output reg dp_a_read,

output reg [3:0] dp_b_addr,
output reg dp_b_read,

output reg [3:0] dp_alu_sel,

//DIAGNOSTICS
output reg [3:0] state
);

//RESET = 0, FETCH = 1, DECODE = 2, EXECUTE = 3, REGWRITE = 4, MEMREAD = 5, MEMWRITE = 6, REGREAD = 7 LINGO = F

reg [3:0] n_state;

initial n_state = 4'h0;
initial state = 4'h0;

always@(posedge CLKSLOW) begin
    state = n_state;
end

always@(state) begin
    case(state)
    4'h0:   begin   //RESET
                dp_write = 1'b0;    //FOR WB
                dp_a_read = 1'b0;
                dp_b_read = 1'b0;
                
                mb_read = 1'b0;
                mb_write = 1'b0;
                
                ir_load = 1'b0;
                pc_load = 1'b0;
                pc_clear = 1'b0;
                pc_inc = 1'b0;
                
                n_state = 4'h1;
            end
    4'h1:   begin   //FETCH
                mb_sel = 1'b0;
                
                mb_read = 1'b1;
                ir_load = 1'b1;
                pc_inc = 1'b1;
                             
                
                n_state = 4'h2;
            end
    4'h2:   begin   //DECODE
                mb_read = 1'b0;
                ir_load = 1'b0;
                pc_inc = 1'b0;
                                
                //if ALU operations
                if(ir_inst[15:12] < 4'h8) begin
                    dp_sel = 2'b00;     //select ALU in MUX
                    
                    n_state = 4'h7;
                end
                
                //for LI
                if(ir_inst[15:12] == 4'h8) begin
                    dp_sel = 2'b10;     //select IMM in MUX
                    
                    dp_imm = ir_inst[7:0];
                    
                    n_state = 4'h4;
                
                end
                
                //for LW
                if( (ir_inst[15:12] == 4'h9) ) begin
                    dp_sel = 2'b01;     //select MEM in MUX
                    
                    n_state = 4'h5;
                
                end
                
                //for SW
                if( (ir_inst[15:12] == 4'hA) ) begin
                    dp_sel = 2'b01;     //select MEM in MUX
                    
                    n_state = 4'h6;
                end
                
            end
    4'h3:   begin   //EXECUTE
                dp_alu_sel = ir_inst[15:12];
                
                n_state = 4'h4;   
            end
            
    4'h4:   begin   //WRITE 
                dp_write_addr = ir_inst[11:8];
                dp_write = 1'b1;
                
                n_state = 4'hF;
            end
    4'h5:   begin   //MEMREAD
                mb_sel = 1'b1;
                mb_addr = ir_inst[7:0];
                
                mb_read = 1'b1;
                
                n_state = 4'h4;
            end
    4'h6:   begin   //FOR SW ONLY (MEMWRITE)
                dp_a_addr = ir_inst[11:8];
                dp_a_read = 1'b1;
                
                mb_sel = 1'b1;
                mb_addr = ir_inst[7:0];
                
                mb_write = 1'b1;
                
                n_state = 4'hF;
                
            end
            
    4'h7:   begin   //REGREAD
                dp_a_addr = ir_inst[7:4];
                dp_b_addr = ir_inst[3:0];
                dp_a_read = 1'b1;
                dp_b_read = 1'b1;
                
                if(ir_inst[15:12] < 4'h8) begin
                    n_state = 4'h3;
                end
            end
    4'hF:   begin   //LINGO
                //dp_write = 1'b0;
                
                //n_state = 4'hF;
                n_state = 4'hF;
            end
    endcase
end
endmodule