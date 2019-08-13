`timescale 1ns / 1ps
module PC(
input CLK,

input load,
input clear,
input inc,
input [7:0] offset,

output [7:0] address_out,
//output reg [3:0] state,
output [2:0] flag   //inc, load, clear
);

reg [7:0] count;
reg inc_flag, load_flag, clear_flag;
//reg [3:0] nstate; 
//reg flag;

//initial state = 4'h0;
initial count = 8'h00;

assign address_out = count;
assign flag = {inc_flag, load_flag, clear_flag};

initial begin
    inc_flag = 1'b0;
    load_flag = 1'b0;
    clear_flag = 1'b0;
end

//Asynchronous inputs
always@(inc) begin

    if(inc) inc_flag = 1'b1;
    else    inc_flag = 1'b0;
    
end

always@(load) begin

    if(load)    load_flag = 1'b1;
    else        load_flag = 1'b0;
    
end

always@(clear) begin
    if(clear)   clear_flag = 1'b1;
    else        clear_flag = 1'b0;
    
end

//Synchronous outputs
always@(posedge CLK) begin
    case({inc_flag, load_flag, clear_flag})
        3'b100: begin
                count = count + 8'h01;
                inc_flag = 1'b0;  
        end
        3'b010: begin
                count = count + offset - 8'h01;
                load_flag = 1'b0;
        end
        3'b001: begin
                count = 8'h00;
                clear_flag = 1'b0;
        end
        default: count = count;    
    
    endcase
end

/*
always@(posedge CLK) begin

    if(inc_flag) begin
        count = count + 8'h01;
        inc_flag = 1'b0;    
    end
    if(load_flag) begin
        count = count + offset - 8'h01;
        load_flag = 1'b0;
    end
    if(clear_flag) begin
        count = 8'h00;
        clear_flag = 1'b0;
    end

end
*/

/*
always@(posedge CLK) begin
    state = nstate;

end

always@(state) begin
    case(state)
    4'h0: nstate = 4'h1;
    4'h1: begin
        if(inc) nstate = 4'h2;
    end
    4'h2: begin
        count = count + 8'h01;
        nstate = 4'h3;
    end
    4'h3: begin
        if(~inc) nstate = 4'h1;
    end
    default: nstate = 4'h0;
    
    endcase

end

*/

/*
always@(posedge CLK) begin
    if(inc_flag) begin
        count = count + 8'h01;
        inc_flag = 0;
    end
    if(flag[1]) begin
        count = count + offset - 8'h01;
        flag[1] = 0;
    end
    if(flag[0]) begin
        count = 8'h00;
        flag[0] = 0;
    end
            
end
*/

/*
always@(posedge CLK) begin

    casez({inc, load, clear})
        //If more than one signal is high, then keep the same count
        3'b111: count = count;
        3'b11?: count = count;
        3'b1?1: count = count;
        3'b?11: count = count;
        
        //Assess control signals
        3'b1??: begin
                    if(~flag) begin
                        count = count + 8'h01; 
                        flag = 1'b1;
                    end
                    
                end 
        3'b?1?: count = count + offset - 8'h01;
        3'b??1: count = 8'h00;
        
        //Keep count if any other cases are present (xzx, 0xz, 00x...)
        default: count = count;    
    
    
    
    endcase



end
*/




endmodule
