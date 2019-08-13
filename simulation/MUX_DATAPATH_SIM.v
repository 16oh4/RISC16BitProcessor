`timescale 1ns / 1ps
module MUX_DATAPATH_SIM();


reg [15:0] alu_data, mem_data;
reg [7:0] cu_data;
reg [1:0] sel;

wire [15:0] out;

MUX_DATAPATH UUT(
.alu_data   (alu_data),
.mem_data   (mem_data),
.cu_data    (cu_data),
.sel        (sel),

.out        (out)
);

initial begin
    alu_data = 16'hAA44;
    mem_data = 16'h7780;
    cu_data = 8'h20;
    
    sel = 2'b00;
    #10 sel = 2'b01;
    #10 sel = 2'b10;
    #10 sel = 2'b11;
    



end


endmodule
