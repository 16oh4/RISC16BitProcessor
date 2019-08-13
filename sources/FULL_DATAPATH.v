`timescale 1ns / 1ps
module FULL_DATAPATH(
    input CLK100MHZ,
    
    //FOR MEMORY
    input mb_sel,
    
    input [7:0] mb_pc_addr,
    input [7:0] mb_cu_addr,
    
    input mb_mem_read,
    input mb_mem_write,
    
    //FOR DATAPATH
    input [7:0] dp_imm,
    input [1:0] dp_sel,
    
    input [3:0] dp_write_addr,
    input       dp_write,
    
    input [3:0] dp_a_addr,
    input       dp_a_read,
    
    input [3:0] dp_b_addr,
    input       dp_b_read,
    
    input [3:0] dp_alu_sel,
    
    output [15:0] dp_a_data,
    output        dp_zf_flag,
    output [15:0] dp_alu_out,
    output [15:0] mb_data_out
);



//FOR MEMORY

//wire [15:0] mb_data_out;

//FOR DATAPATH

MEMORY MEM(
.CLK100MHZ  (CLK100MHZ),

.cu_mux_sel (mb_sel),
.pc_addr    (mb_pc_addr),
.cu_addr    (mb_cu_addr),

.mb_data_in (dp_a_data),

.cu_read    (mb_mem_read),
.cu_write   (mb_mem_write),

.mb_data_out(mb_data_out)
);


DATAPATH DP(
.CLK100MHZ      (CLK100MHZ),

.mem_info       (mb_data_out),

.cu_imm         (dp_imm),
.cu_sel         (dp_sel),

.cu_write_addr  (dp_write_addr),
.cu_write       (dp_write),

.cu_a_addr      (dp_a_addr),
.cu_a_read      (dp_a_read),

.cu_b_addr      (dp_b_addr),
.cu_b_read      (dp_b_read),

.cu_alu_sel     (dp_alu_sel),

.dp_a_data      (dp_a_data),
.dp_zf_flag     (dp_zf_flag),
.dp_alu_out     (dp_alu_out)
);

endmodule
