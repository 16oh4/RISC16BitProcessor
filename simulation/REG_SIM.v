`timescale 1ns / 1ps

module REG_SIM();

//Inputs to UUT
reg         CLK;

reg [15:0]  mux_data;
reg [3:0]   mux_data_addr;
reg         mux_data_write;

reg [3:0]   a_addr;
reg         a_read;

reg [3:0]   b_addr;
reg         b_read;

//Outputs to UUT
wire [15:0] a_data;
wire [15:0] b_data;

wire [2:0] flag;

REGBANK UUT(
.CLK            (CLK),
.mux_data       (mux_data),
.mux_data_addr  (mux_data_addr),
.mux_data_write (mux_data_write),

.a_addr         (a_addr),
.a_read         (a_read),

.b_addr         (b_addr),
.b_read         (b_read),

.a_data         (a_data),
.b_data         (b_data),

.flag           (flag)


);

//For CLK generation
always #5 CLK = ~CLK;
initial CLK = 1'b0;

initial begin
    //#5;
    mux_data = 16'h1010;
    mux_data_addr = 4'h0;
    
    mux_data_write = 1'b1;
    
    
    #10;    //simulates controller changing states
    mux_data_write = 1'b0;
    #10;
 
    mux_data = 16'h2020;
    mux_data_addr = 4'h1;
    
    mux_data_write = 1'b1;
    
    #10     //change state
    mux_data_write = 1'b0;
    
    a_addr = 4'h0;
    a_read = 1'b1;
    
    b_addr = 4'h1;
    b_read = 1'b1;
    
    /*
    #15 b_read = 0;
    
    #10 b_read = 1;
    #10 a_read = 0;
    #10 a_read = 1;
    */


/*
    mux_data = 16'h1010;
    mux_data_addr = 4'h0;
    
    {mux_data_write, a_read, b_read} = 3'b100;
    
    #20;
    
    mux_data = 16'h2020;
    mux_data_addr = 4'h1;
    
    #20;
    a_addr = 4'h0;
    {mux_data_write, a_read, b_read} = 3'b010;
    
    #20;
    b_addr = 4'h1;
    {mux_data_write, a_read, b_read} = 3'b001;
    
    //{mux_data_write, a_read, b_read} = 3'b011;

*/
end


endmodule
