`timescale 1ns / 1ps
module CONTROLLER_SIM(

);
//CLOCK GENERATION
reg CLK100MHZ;
initial CLK100MHZ = 0;
always #5 CLK100MHZ = ~CLK100MHZ;
//FROM CTRL_CLK
wire CLKSLOW;

//TO CTRL
reg dp_zf_flag;

//TO PC
wire pc_load;
wire pc_clear;
wire pc_inc;

//TO IR
wire ir_load;

//TO MEMBANK
wire mb_sel;
wire [7:0] mb_addr;

wire mb_read;
wire mb_write;

//TO DP
wire [7:0] dp_imm;
wire [1:0] dp_sel;

wire [3:0] dp_write_addr;
wire dp_write;

wire [3:0] dp_a_addr;
wire dp_a_read;

wire [3:0] dp_b_addr;
wire dp_b_read;

wire [3:0] dp_alu_sel;

//DIAGNOSTICS
wire [3:0] state;

//For PC
wire [7:0] pc_addr;

//To IR
reg [15:0] mb_data_out;

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

initial begin
    mb_data_out = 16'h83A0;
    //mb_data_out = 16'h1321;

end

endmodule
