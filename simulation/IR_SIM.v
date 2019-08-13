`timescale 1ns / 1ps
module IR_SIM();

reg CLK;
initial CLK = 0;
always #5 CLK = ~CLK;

reg load;
reg [15:0] inst_in;
wire [15:0] inst_out;

IR UUT(
.CLK        (CLK),

.load       (load),
.inst_in    (inst_in),
.inst_out   (inst_out)
);

initial begin

inst_in = 16'h0321;
load = 1;
#10 load = 0;

inst_in = 16'hA221;
load = 1;



end

endmodule
