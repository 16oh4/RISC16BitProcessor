`timescale 1ns / 1ps
module CONTROL_UNIT(
input CLK100MHZ,
input dp_zf_flag,
input [15:0] mb_data_out,

//TO MEMBANK
output mb_sel,
output [7:0] mb_addr,
output mb_read,
output mb_write,
output [7:0] pc_addr,

//TO DP
output [7:0] dp_imm,
output [1:0] dp_sel,

output [3:0] dp_write_addr,
output dp_write,

output [3:0] dp_a_addr,
output dp_a_read,

output [3:0] dp_b_addr,
output dp_b_read,

output [3:0] dp_alu_sel,

//DIAGNOSTICS
output [3:0] state
);

//CLKSLOW TO CU
wire CLKSLOW;

//CU TO PC
wire pc_load;
wire pc_clear;
wire pc_inc;

//CU TO IR
wire ir_load;

//IR TO CU
wire [15:0] ir_inst;

IR IR_I(
.CLK        (CLK100MHZ),
.load       (ir_load),
.inst_in    (mb_data_out),

.inst_out   (ir_inst)

);

PC PC_INST(
.CLK         (CLK100MHZ),
.load        (pc_load),
.clear       (pc_clear),
.inc         (pc_inc),
.offset      (ir_inst[7:0]),

.address_out (pc_addr)
);


CTRL_CLK CTRLK_CLK_I(
.CLK100MHZ      (CLK100MHZ),

.SLWCLK         (CLKSLOW)
);

CONTROLLER CTRL_I(
.CLK100MHZ      (CLK100MHZ),
.CLKSLOW        (CLKSLOW),

.ir_inst        (ir_inst),
.dp_zf_flag     (dp_zf_flag),

.pc_load        (pc_load),
.pc_clear       (pc_clear),
.pc_inc         (pc_inc),

.ir_load        (ir_load),

.mb_sel         (mb_sel),
.mb_addr        (mb_addr),

.mb_read        (mb_read),
.mb_write       (mb_write),

.dp_imm         (dp_imm),
.dp_sel         (dp_sel),

.dp_write_addr  (dp_write_addr),
.dp_write       (dp_write),

.dp_a_addr      (dp_a_addr),
.dp_a_read      (dp_a_read),

.dp_b_addr      (dp_b_addr),
.dp_b_read      (dp_b_read),

.dp_alu_sel     (dp_alu_sel),

.state          (state)
);

endmodule