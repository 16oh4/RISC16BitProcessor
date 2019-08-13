`timescale 1ns / 1ps
module MEMBANK(
    input CLK,
    
    input [7:0]     address,
    input [15:0]    data_in,
    input           read,
    input           write,
    
    output reg [15:0]   data_out
    //output reg status   
);
reg [15:0] memory [255:0];      //256x16bit memory
reg [1:0] flag;                 //write, read

initial data_out = 16'hzzzz;    //disconnect data_out initially

initial begin
    memory[8'h00] = 16'h0321;
    memory[8'h01] = 16'h1421;
    
    memory[8'hFF] = 16'h0040;
    memory[8'hFE] = 16'h0020;
end

initial flag = 2'b00;

//Check for control unit signals, toggle flag to write or read on next clk cycle
always@(posedge write)  flag[1] = 1;
always@(posedge read)   flag[0] = 1;


always@(posedge CLK) begin
    if(flag[1]) begin
        memory[address] = data_in;
        data_out = 16'hzzzz;    
        
        flag[1] = 0;
    end
    if(flag[0]) begin
        data_out = memory[address];
                
        flag[0] = 0;
    end


end
/*
always@(posedge CLK) begin  
    
    casez( {write, read} )
        2'b11: data_out = 16'hzzzz;
        2'b1?:  begin
                    memory[address] = data_in;
                    data_out = 16'hzzzz;
                end
        2'b?1: data_out = memory[address];
        default: data_out = 16'hzzzz;
    
    endcase

end
*/


endmodule
