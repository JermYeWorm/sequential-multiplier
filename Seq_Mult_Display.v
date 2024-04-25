`timescale 1ns / 1ps

module Seq_Mult_Display(
    input clk,
    input clr,
    input start,
    input [3:0] a,
    input [3:0] b,
    output [3:0] an,
    output [6:0] ca
    );
    
    wire [7:0] p;
    
    Seq_Mult multiplier (.clk(clk),
                         .clr(clr),
                         .start(start),
                         .a(a),
                         .b(b),
                         .p(p));
    
    Display diplay (.clk(clk),
                    .clr(clr),
                    .dig1(a),
                    .dig2(b),
                    .dig3(p[7:4]),
                    .dig4(p[3:0]),
                    .an(an),
                    .ca(ca));
    
endmodule
