`timescale 1ns / 1ps

module ripple_adder #(parameter N = 8)(
    input [N-1:0] a, 
    input [N-1:0] b,
    input c_in,
    output c_out,
    output [N-1:0] sum
    );
    
    wire [N-2:0] c;     // Intermediate carry wires
    
    // Pre-generate the first and last adders due to their unique arguments
    Full_Adder FA0(.sum(sum[0]), .c_out(c[0]), .a(a[0]), .b(b[0]), .c_in(c_in));
    Full_Adder FAN(.sum(sum[N-1]), .c_out(c_out), .a(a[N-1]), .b(b[N-1]), .c_in(c[N-2]));
    
    // Generate middle bit adders
    genvar i;
    generate
        for (i = 1; i < (N-1); i = i + 1) begin
            Full_Adder FA(.sum(sum[i]), .c_out(c[i]), .a(a[i]), .b(b[i]), .c_in(c[i-1]));
        end
    endgenerate
endmodule
