`timescale 1ns / 1ps

module Mult_Data_Path(
    input wire [3:0] a_in,      // Multiplicand input
    input wire [3:0] b_in,      // Multiplier input
    input wire clk,             // System clock
    input wire clr,             // Reset signal
    input wire en_a,            // Register a enable
    input wire ld_shift_a,      // Shift a MUX select
    input wire en_b,            // Register b enable
    input wire ld_shift_b,      // Shift b MUX select
    input wire en_p,            // Register p enable
    input wire ld_add_p,        // Add a MUX select
    output reg [3:0] p_out,     // 4-bit output vector for product output
    output reg zero,            // Flag for b, zero = 1 if b = 0
    output reg lsb_b            // Flag for the LSB of b, lsb_b = 1 if b[0] = 1
    );
    
    wire [7:0] a, p, a_plus_p, a_shift, p_add; // p_add is output of add_p MUX
    wire [3:0] b, b_shift;
    
    mux2g #(.N(8)) MA(.a({1'b0000, a_in}),
                      .b(a), 
                      .s(ld_shift_a), 
                      .y(a_shift));
    mux2g #(.N(4)) MB(.a(b_in),
                      .b(b), 
                      .s(ld_shift_b), 
                      .y(b_shift));
    mux2g #(.N(8)) MP(.a(1'b00000000),
                      .b(a_plus_p), 
                      .s(ld_add_p),
                      .y(p_add));
                      
    shift_register #(.N(4)) RA(.en(en_a), 
                               .clk(clk), 
                               .clr(clr), 
                               .d(a_shift), 
                               .q(a));
    shift_register #(.N(4)) RB(.en(en_b), 
                               .clk(clk), 
                               .clr(clr), 
                               .d(b_shift), 
                               .q(b));
    shift_register #(.N(4)) RP(.en(en_p), 
                               .clk(clk), 
                               .clr(clr), 
                               .d(p_add), 
                               .q(p));
                         
    // Adder adds multiplicand to partial product
    ripple_adder #(.N(8)) RippAdd(.a(a), 
                                  .b(p), 
                                  .c_in(0),
                                  .sum(a_plus_p));
    
    // always block for checking if b = 0        
    always @(posedge clk) 
    begin
        if (b == 0)
        begin
            zero = 1;
            p_out = p;
        end
        else
            zero = 0;
    end
    
    // always block for checking if b[0] = 1
    always @(posedge clk) 
    begin
        if (b[0] == 1)
            lsb_b = 1;
        else
            lsb_b = 0;
    end
    
endmodule
