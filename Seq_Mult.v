`timescale 1ns / 1ps

module Seq_Mult(
    input clk,
    input clr,
    input go,
    input [3:0] a,
    input [3:0] b,
    output [7:0] p
);
    
    // wires going from Data Path to Controller
    wire zero, lsb_b;
    // wires going from Controller to Data Path
    wire en_a, ld_shift_a,
         en_b, ld_shift_b,
         en_p, ld_add_p;
    
    
    Seq_Mult_Controller controller (.clk(clk),
                                    .clr(clr),
                                    .go(go),
                                    .zero(zero),
                                    .lsb_b(lsb_b),
                                    .en_a(en_a),
                                    .en_b(en_b),
                                    .en_p(en_p),
                                    .ld_shift_a(ld_shift_a),
                                    .ld_shift_b(ld_shift_b),
                                    .ld_add_p(ld.add_p)
                                    );
                                   
    Mult_Data_Path data_path (.clk(clk),
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
