`timescale 1ns / 1ps
module MEMORY(
input CLK100MHZ,

//MUX_MEMORY
input cu_mux_sel,          //CTRL SIGNAL
input [7:0] pc_addr,
input [7:0] cu_addr,

//MEMBANK
input [15:0] mb_data_in,     //data from DATAPATH A port
input cu_read,              //CTRL SIGNAL
input cu_write,             //CTRL SIGNAL

output [15:0] mb_data_out       //Output data
);

wire [7:0] mux_mem_out;

MUX_MEMORY MUX_MEMORY_I(
.sel        (cu_mux_sel),
.pc_addr    (pc_addr),
.cu_addr    (cu_addr),

.out        (mux_mem_out)
);

MEMBANK MEMBANK_I(
.CLK        (CLK100MHZ),

.address    (mux_mem_out),
.data_in    (mb_data_in),
.read       (cu_read),
.write      (cu_write),

.data_out   (mb_data_out)
);


endmodule
