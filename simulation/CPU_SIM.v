`timescale 1ns / 1ps
module CPU_SIM();

reg CLK100MHZ;
initial CLK100MHZ = 0;
always #5 CLK100MHZ = ~CLK100MHZ;

//TO MEMBANK
wire        cu_mb_sel;
wire [7:0]  cu_mb_addr;
wire        cu_mb_read;
wire        cu_mb_write;
wire [7:0]  cu_pc_addr;

//TO DP
wire [7:0]  cu_dp_imm;
wire [1:0]  cu_dp_sel;

wire [3:0]  cu_dp_write_addr;
wire        cu_dp_write;

wire [3:0]  cu_dp_a_addr;
wire        cu_dp_a_read;

wire [3:0]  cu_dp_b_addr;
wire        cu_dp_b_read;

wire [3:0]  cu_dp_alu_sel;

//DIAGNOSTICS
wire [3:0] cu_state;

//TO CU
wire [15:0] dp_a_data;
wire        dp_zf_flag;
wire [15:0] dp_alu_out;
wire [15:0] dp_mb_data_out;


FULL_DATAPATH DP_I(
.CLK100MHZ          (CLK100MHZ),
    
.mb_sel             (cu_mb_sel),

.mb_pc_addr         (cu_pc_addr),
.mb_cu_addr         (cu_mb_addr),
    
.mb_mem_read        (cu_mb_read),
.mb_mem_write       (cu_mb_write),
    
.dp_imm             (cu_dp_imm),
.dp_sel             (cu_dp_sel),
    
.dp_write_addr      (cu_dp_write_addr),
.dp_write           (cu_dp_write),
    
.dp_a_addr          (cu_dp_a_addr),
.dp_a_read          (cu_dp_a_read),
    
.dp_b_addr          (cu_dp_b_addr),
.dp_b_read          (cu_dp_b_read),
    
.dp_alu_sel         (cu_dp_alu_sel),
    
.dp_a_data          (dp_a_data),
.dp_zf_flag         (dp_zf_flag),
.dp_alu_out         (dp_alu_out),
.mb_data_out        (dp_mb_data_out)
);

CONTROL_UNIT CU_I(
.CLK100MHZ      (CLK100MHZ),

.dp_zf_flag     (dp_zf_flag),
.mb_data_out    (dp_mb_data_out),

//TO MEMBANK
.mb_sel          (cu_mb_sel),
.mb_addr         (cu_mb_addr),
.mb_read         (cu_mb_read),
.mb_write        (cu_mb_write),
.pc_addr         (cu_pc_addr),

//TO DP
.dp_imm          (cu_dp_imm),
.dp_sel          (cu_dp_sel),

.dp_write_addr   (cu_dp_write_addr),
.dp_write        (cu_dp_write),

.dp_a_addr       (cu_dp_a_addr),
.dp_a_read       (cu_dp_a_read),

.dp_b_addr       (cu_dp_b_addr),
.dp_b_read       (cu_dp_b_read),

.dp_alu_sel      (cu_dp_alu_sel),

.state           (cu_state)
);

initial begin


end

endmodule
