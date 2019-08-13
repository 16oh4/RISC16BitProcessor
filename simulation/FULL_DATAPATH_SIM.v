`timescale 1ns / 1ps

module FULL_DATAPATH_SIM();

reg CLK;
initial CLK = 0;
always #5 CLK = ~CLK;


//FOR MEMORY
reg mb_sel;

reg [7:0]   mb_pc_addr;
reg [7:0]   mb_cu_addr;

reg mb_mem_read;
reg mb_mem_write;

wire [15:0] mb_data_out;

//FOR DATAPATH

reg [7:0] dp_imm;
reg [1:0] dp_sel;

reg [3:0]   dp_write_addr;
reg         dp_write;

reg [3:0]   dp_a_addr;
reg         dp_a_read;

reg [3:0]   dp_b_addr;
reg         dp_b_read;

reg [3:0]   dp_alu_sel;

wire [15:0] dp_a_data;
wire        dp_zf_flag;
wire [15:0] dp_alu_out;

FULL_DATAPATH UUT(
.CLK100MHZ      (CLK),

.mb_sel         (mb_sel),
.mb_pc_addr     (mb_pc_addr),
.mb_cu_addr     (mb_cu_addr),

.mb_mem_read    (mb_mem_read),
.mb_mem_write   (mb_mem_write),

.dp_imm         (dp_imm),
.dp_sel         (dp_sel),

.dp_write_addr  (dp_write_addr),
.dp_write       (dp_write),

.dp_a_addr      (dp_a_addr),
.dp_a_read      (dp_a_read),

.dp_b_addr      (dp_b_addr),
.dp_b_read      (dp_b_read),

.dp_alu_sel     (dp_alu_sel),

.dp_a_data      (dp_a_data),
.dp_zf_flag     (dp_zf_flag),

.dp_alu_out     (dp_alu_out),
.mb_data_out    (mb_data_out)
);


initial begin
mb_cu_addr = 8'hFF;     //Output contents of memory
mb_sel = 1'b1;
mb_mem_read = 1'b1;

#10;
dp_sel = 1'b1;          //Select mux in datapath

dp_write_addr = 4'h0;
dp_write = 1'b1;        //Write memory contents to reg 0

#10;
mb_mem_read = 1'b0;     //After writing to register, turn off mem_read and dp_write
dp_write = 1'b0;

dp_a_addr = 4'h0;       ////Read register 0 to output back to memory
dp_a_read = 1'b1;

#10;

mb_cu_addr = 8'h00;     //Write back to address 0 of memory
mb_sel = 1'b1;

mb_mem_write = 1'b1;    //Initialize write
#10 mb_mem_write = 1'b0;

mb_mem_read = 1'b1;     //Read back memory!

end
endmodule
