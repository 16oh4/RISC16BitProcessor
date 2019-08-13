`timescale 1ns / 1ps
module DATAPATH_SIM();


reg CLK;

initial CLK = 0;
always #5 CLK = ~CLK;

reg [15:0]  mem_info;
reg [7:0]   cu_imm;
reg [1:0]   cu_sel;

reg [3:0]   cu_write_addr;
reg         cu_write;

reg [3:0]   cu_a_addr;
reg         cu_a_read;

reg [3:0]   cu_b_addr;
reg         cu_b_read;

reg [3:0]   cu_alu_sel;

wire [15:0] dp_a_data;
wire        dp_zf_flag;

wire [15:0] dp_alu_out;

DATAPATH UUT(
.CLK100MHZ      (CLK),

.mem_info       (mem_info),
.cu_imm         (cu_imm),
.cu_sel         (cu_sel),

.cu_write_addr  (cu_write_addr),
.cu_write       (cu_write),

.cu_a_addr      (cu_a_addr),
.cu_a_read      (cu_a_read),

.cu_b_addr      (cu_b_addr),
.cu_b_read      (cu_b_read),

.cu_alu_sel     (cu_alu_sel),

.dp_a_data      (dp_a_data),
.dp_zf_flag     (dp_zf_flag),
.dp_alu_out     (dp_alu_out)
);

initial begin
    mem_info = 16'h0004;
    cu_imm = 8'h02;
    
    //WRITE MEMORY TO 0 SLOT
    cu_sel = 2'b01;
    cu_write_addr = 4'h0;
    
    cu_write = 1'b1;
    #20;
    
    //WRITE IMMEDIATE TO 1 SLOT
    cu_sel = 2'b10;
    cu_write_addr = 4'h1;
    
    #20 cu_write = 1'b0;    //turn off write before reading
    
    //READ A AND B TO SEND TO ALU    
    cu_a_addr = 4'h0;
    cu_a_read = 1'b1;
    
    cu_b_addr = 4'h1;
    cu_b_read = 1'b1;
    
    cu_alu_sel = 4'h0; //add
    
    //#10 cu_a_addr = 4'h1;
    

end

endmodule
