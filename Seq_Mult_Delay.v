`timescale 1ns / 1ps

module Seq_Mult_Delay(
    input clk,
    input clr,
    input x,            // Input 200kHz square wave 5Vpp
    output [7:0] p      // Output to DLA
    );
    
    wire [3:0] a = {x, x, x, x};
    wire [3:0] b = {1'b1, 1'b1, 1'b1, 1'b1};
    wire start;
    
//    reg x_temp, start;
    
    assign start = 1;
    
    Seq_Mult multiplier (.clk(clk),
                         .clr(clr),
                         .start(start),
                         .a(a),
                         .b(b),
                         .p(p));
    
//    always @(posedge clk)
//    begin
//        start = (x_temp != x) ? 1 : 0;
//        x_temp = x;
//    end
        
endmodule
