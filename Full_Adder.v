`timescale 1ns / 1ps

module Full_Adder(
    output sum, c_out,
    input a, b, c_in
    );
    
    wire s1, c_out1, c_out2;
    
    Half_Adder HA1(s1, c_out1, a, b);
    Half_Adder HA2(sum, c_out2, s1, c_in);
    
    assign c_out = c_out1 || c_out2;
    
endmodule
