`timescale 1ns / 1ps

module Seq_Mult(
    input clk,
    input clr,
    input start,
    input [3:0] a,
    input [3:0] b,
    output [7:0] p
    );
    
    // Wires going from Data Path to Controller
    wire zero, lsb_b;
    // Wires going from Controller to Data Path
    wire en_a, ld_shift_a,
         en_b, ld_shift_b,
         en_p, ld_add_p;
    
    
    Controller controller (.clk(clk),
                           .clr(clr),
                           .start(start),
                           .zero(zero),
                           .lsb_b(lsb_b),
                           .en_a(en_a),
                           .en_b(en_b),
                           .en_p(en_p),
                           .ld_shift_a(ld_shift_a),
                           .ld_shift_b(ld_shift_b),
                           .ld_add_p(ld_add_p));
                                   
    Data_Path data_path (.clk(clk),
                         .clr(clr),
                         .a_in(a),
                         .b_in(b),
                         .en_a(en_a),
                         .ld_shift_a(ld_shift_a),
                         .en_b(en_b),
                         .ld_shift_b(ld_shift_b),
                         .en_p(en_p),
                         .ld_add_p(ld_add_p),
                         .p_out(p),
                         .zero(zero),
                         .lsb_b(lsb_b));

endmodule
