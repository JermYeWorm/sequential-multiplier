`timescale 1ns / 1ps

module Data_Path(
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
    output reg [7:0] p_out,     // 8-bit output vector for product output
    output wire zero,           // Flag for b, zero = 1 if b = 0
    output wire lsb_b           // Flag for the LSB of b, lsb_b = 1 if b[0] = 1
    );
    
    wire [7:0] a_d, a_q, p_d, p_q;
    wire [3:0] b_d, b_q;
    
    assign lsb_b = b_q[0];          // lsb_b is 1 when b_q[0] is 1
    assign zero = ~(b_q && 1);      // zero = 1 when b_q is 0
    
    // always block for checking if b = 0        
    always @(posedge clk) 
    begin
        if (b_q == 0)
            p_out <= p_q;
    end
    
    // 2:1 Mux behavioral
    assign a_d = ld_shift_a ? (a_q << 1) : {4'b0000, a_in};
    assign b_d = ld_shift_b ? (b_q >> 1) : b_in;
    assign p_d = ld_add_p ? (a_q + p_q) : {8'b00000000};
    
    // Register instantiation
    D_Latch_Reg #(8) a_reg (.clk(clk),
                            .clr(clr),
                            .en(en_a),
                            .d(a_d),
                            .q(a_q));
                            
    D_Latch_Reg #(4) b_reg (.clk(clk),
                            .clr(clr),
                            .en(en_b),
                            .d(b_d),
                            .q(b_q));
                            
    D_Latch_Reg #(8) p_reg (.clk(clk),
                            .clr(clr),
                            .en(en_p),
                            .d(p_d),
                            .q(p_q));
    
endmodule
