`timescale 1ns / 1ps
module MEMORY_SIM();

reg CLK;
initial CLK = 0;
always #5 CLK = ~CLK;

reg cu_mux_sel;
reg [7:0] pc_addr, cu_addr;

reg [15:0] mb_data_in;
reg cu_read;
reg cu_write;

wire [15:0] mb_data_out;

MEMORY UUT(
.CLK100MHZ  (CLK),

.cu_mux_sel (cu_mux_sel),
.pc_addr    (pc_addr),
.cu_addr    (cu_addr),

.mb_data_in (mb_data_in),
.cu_read    (cu_read),
.cu_write   (cu_write),

.mb_data_out(mb_data_out)
);

initial begin

pc_addr = 8'h40;
cu_addr = 8'h20;

//Write data to PC ADDR
cu_mux_sel = 0;
mb_data_in = 16'hBB09;
cu_write = 1;
#10 cu_write = 0;

//Read data
cu_read = 1;
#10 cu_read =0;

//Write data to CU 
cu_mux_sel = 1;
mb_data_in = 16'hABCD;
cu_write = 1;
#10 cu_write = 0;

cu_read = 1;
#10 cu_read =0;

end


endmodule
