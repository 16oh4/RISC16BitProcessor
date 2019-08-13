`timescale 1ns / 1ps

module IR(
input CLK,

input load,
input       [15:0] inst_in,
output reg  [15:0] inst_out,
output flag

);

reg load_flag;
reg clkgate;

initial inst_out = 16'hzzzz;
initial load_flag = 1'b0;
initial clkgate = 1'b0;

assign flag = load_flag;




endmodule
/*


module pos_edge_det ( input sig,            // Input signal for which positive edge has to be detected
                      input clk,            // Input signal for clock
                      output pe);           // Output signal that gives a pulse when a positive edge occurs
 
    reg   sig_dly;                          // Internal signal to store the delayed version of signal
 
    // This always block ensures that sig_dly is exactly 1 clock behind sig
  always @ (posedge clk) begin
    sig_dly <= sig;
  end
 
    // Combinational logic where sig is AND with delayed, inverted version of sig
    // Assign statement assigns the evaluated expression in the RHS to the internal net pe
  assign pe = sig & ~sig_dly;            
endmodule 
 */

module  clockgate (

// OUTPUTs
    gclk,                      // Gated clock

// INPUTs
    clk,                       // Clock
    enable,                    // Clock enable
    scan_enable                // Scan enable (active during scan shifting)
);

// OUTPUTs
//=========
output         gclk;           // Gated clock

// INPUTs
//=========
input          clk;            // Clock
input          enable;         // Clock enable
input          scan_enable;    // Scan enable (active during scan shifting)


//=============================================================================
// CLOCK GATE: LATCH + AND
//=============================================================================

// Enable clock gate during scan shift
// (the gate itself is checked with the scan capture cycle)
wire    enable_in =   (enable | scan_enable);

// LATCH the enable signal
reg     enable_latch;
always @(clk or enable_in)
  if (~clk)
    enable_latch <= enable_in;

// AND gate
assign  gclk      =  (clk & enable_latch);


endmodule // omsp_clock_gate
