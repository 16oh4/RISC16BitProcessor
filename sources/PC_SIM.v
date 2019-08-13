`timescale 1ns / 1ps
module PC_SIM();



reg CLK;
initial CLK = 0;
always #5 CLK = ~CLK;


reg load, clear, inc;
reg [7:0] offset;

wire [7:0] address_out;
wire [2:0] flag;
//wire [3:0] state;

PC PC_I(
.CLK    (CLK),

.load   (load),
.clear  (clear),
.inc    (inc),
.offset (offset),

.address_out(address_out),
.flag       (flag)
);


initial begin
offset = 8'h0A;

inc = 1;
#5 inc = 0;
#5 inc = 1;

#10 load = 1;
#10 clear = 1;


end


endmodule