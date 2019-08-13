`timescale 1ns / 1ps

module MEMBANK_SIM();

reg CLK;
initial CLK = 0;
always #5 CLK = ~CLK;

reg [7:0] mux_addr;
reg [15:0] dp_a_data;
reg cu_read;
reg cu_write;

wire [15:0] membank_out;
wire status;

MEMBANK UUT(
.CLK        (CLK),

.address    (mux_addr),
.data_in    (dp_a_data),
.read       (cu_read),
.write      (cu_write),

.data_out   (membank_out),
.status     (status)
);


initial begin
mux_addr = 8'h00;
dp_a_data = 16'hAA40;

cu_write = 1;
#10 cu_write = 0;

cu_read = 1;
#10 cu_read = 0;




end




endmodule
