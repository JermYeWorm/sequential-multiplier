`timescale 1ns / 1ps

module D_Latch_Reg #(parameter N = 4)(
    input wire clk,               // Clock
    input wire clr,               // Clear
    input wire en,                // Enable
    input wire [N-1:0] d,         // Data input
    output reg [N-1:0] q          // Data output
    );
    
    always @(posedge clr or posedge clk) 
    begin
        if (clr)
            q = 0;
        else if (en)
            q <= d;
    end
    
endmodule