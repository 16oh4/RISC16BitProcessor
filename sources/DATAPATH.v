`timescale 1ns / 1ps
module DATAPATH(

input CLK100MHZ,
//MUX INPUTS
input [15:0]    mem_info,       //16-bit data from memory
input [7:0]     cu_imm,         //8-bit immediate from CU
input [1:0]     cu_sel,         //2-bit MUX sel from CU

//RB INPUTS
input [3:0]     cu_write_addr,  //4-bit write address from CU
input           cu_write,       //1-bit write control signal from CU

input [3:0]     cu_a_addr,      //Register addr to read into A
input           cu_a_read,      //Control signal to read A

input [3:0]     cu_b_addr,      //Register addr to read into B
input           cu_b_read,      //Control signal to read B

//ALU INPUTS
input [3:0]     cu_alu_sel,

output [15:0]   dp_a_data,      //16-bit output from A port
output          dp_zf_flag,
output [15:0]   dp_alu_out
);
//SUBMODULE INTERCONNECT WIRES
//MUX
wire [15:0] mux_out;

//ALU
wire [15:0] alu_ans;

//REGBANK
wire [15:0] rb_a_data;
wire [15:0] rb_b_data;
wire        rb_idle;

//ZEROFLAG
wire zf_flag;
//SUBMODULE INTERCONNECT WIRES


ZEROFLAG ZEROFLAG_I(
.num        (rb_a_data),

.zeroflag   (zf_flag)
);

REGBANK REGBANK_I(
.CLK            (CLK100MHZ),

.mux_data       (mux_out),

.mux_data_addr  (cu_write_addr),
.mux_data_write (cu_write),

.a_addr         (cu_a_addr),
.a_read         (cu_a_read),

.b_addr         (cu_b_addr),
.b_read         (cu_b_read),

.a_data         (rb_a_data),
.b_data         (rb_b_data),
//.idle           (rb_idle)
);

MUX_DATAPATH MUX_I(
.alu_data   (alu_ans),
.mem_data   (mem_info),
.cu_data    (cu_imm),

.sel        (cu_sel),

.out        (mux_out)
);

ALU ALU_I(
.A      (rb_a_data),
.B      (rb_b_data),
.op     (cu_alu_sel),

.ans    (alu_ans)
);

//USE DEDICATED WIRES FOR OUTPUTS FOR GOOD NAMING CONVENTION
assign dp_zf_flag = zf_flag;
assign dp_alu_out = alu_ans;
assign dp_a_data = rb_a_data; //to rename the output of datapath


endmodule
