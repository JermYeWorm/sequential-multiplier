`timescale 1ns / 1ps

module Half_Adder(
    output sum, c_out,
    input a, b
    );
    
    assign sum = a ^ b;
    assign c_out = a & b;

endmodule
