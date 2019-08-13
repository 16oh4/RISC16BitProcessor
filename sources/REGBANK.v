`timescale 1ns / 1ps

module REGBANK(
    input CLK,
    
    input [15:0] mux_data,
    
    input [3:0] mux_data_addr,  
    input       mux_data_write, 
    
    input [3:0] a_addr,
    input       a_read,
    
    input [3:0] b_addr,
    input       b_read,
    
    output reg [15:0]  a_data,
    output reg [15:0]  b_data,
    output reg [2:0]   flag,
    output reg [2:0] off_flag
);

reg [15:0] bank [15:0];         //16, 16-bit register bank
//reg [2:0] flag;                 //write, a read, b read

//Disconnect a and b data values in beginning
initial begin
    a_data = 16'hzzzz;
    b_data = 16'hzzzz;
    //bank[4'hF] = 16'h9070; //FOR TESTING
end

initial flag = 3'b000;
initial off_flag = 3'b000;


always@(posedge mux_data_write) flag[2] = 1;
always@(posedge a_read) flag[1] = 1;
always@(posedge b_read) flag[0] = 1;

/*
always@(negedge mux_data_write) off_flag[2] = 1;

always@(negedge CLK) begin
    
    if(off_flag[2]) begin
        
    end

end
*/

always@(posedge CLK) begin

    if(flag[2]) begin
        bank[mux_data_addr] = mux_data;
        
        flag[2] =  0;
    end
    if(flag[1]) begin
        a_data = bank[a_addr];
        
        flag[1] = 0;
    end
    if(flag[0]) begin
        b_data = bank[b_addr];
        
        flag[0] = 0;        
    end

end



/*   
    case( {flag[2], flag[1], flag[0] } )
        3'b100: begin
                    bank[mux_data_addr] = mux_data;
                    a_data = 16'hzzzz;
                    b_data = 16'hzzzz;
                
                    flag[2] = 0;
                end
        3'b010: begin
                    a_data = bank[a_addr];
                    b_data = 16'hzzzz;
                
                    flag[1] = 0;
                end
        3'b001: begin
                    a_data = 16'hzzzz;
                    b_data = bank[b_addr];
                
                    flag[0] = 0;  
                end
        3'b011: begin
                    a_data = bank[a_addr];
                    b_data = bank[b_addr];
                    
                    flag[1:0] = 2'b00;
                end
    endcase
*/    


/*
always@(posedge CLK) begin
    casez( {mux_data_write, a_read, b_read} )
        //cannot write and read
        3'b111: begin
                    a_data = 16'hzzzz;
                    b_data = 16'hzzzz;
                end
        3'b11?: begin
                    a_data = 16'hzzzz;
                    b_data = 16'hzzzz;
                end
        3'b1?1: begin
                    a_data = 16'hzzzz;
                    b_data = 16'hzzzz;
                end
        3'b1??: begin   //now we can write
                    bank[mux_data_addr] = mux_data;
                    a_data = 16'hzzzz;
                    b_data = 16'hzzzz;
                end
        3'b?11: begin   //show a and b if write is z or 0
                    a_data = bank[a_addr];
                    b_data = bank[b_addr];
                end
        3'b??1: begin
                    a_data = 16'hzzzz;
                    b_data = bank[b_addr];  //only b_read is valid                    
                end
        3'b?1?: begin
                    a_data = bank[a_addr];  //only a_read is valid
                    b_data = 16'hzzzz;
                end
        default: begin  //d/c if no control signals
                    a_data = 16'hzzzz;
                    b_data = 16'hzzzz;
                end
    
    endcase
end
*/




endmodule
