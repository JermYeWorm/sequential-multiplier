`timescale 1ns / 1ps

module T_Data_Path;
    reg [3:0] a_in;      // Multiplicand input
    reg [3:0] b_in;      // Multiplier input
    reg clk;             // System clock
    reg clr;             // Reset signal
    reg en_a;            // Register a enable
    reg ld_shift_a;      // Shift a MUX select
    reg en_b;            // Register b enable
    reg ld_shift_b;      // Shift b MUX select
    reg en_p;            // Register p enable
    reg ld_add_p;        // Add a MUX select
    wire [7:0] p_out;    // 4-bit output vector for product output
    wire zero;           // Flag for b, zero = 1 if b = 0
    wire lsb_b;          // Flag for the LSB of b, lsb_b = 1 if b[0] = 1
    
    wire [7:0] a_d, a_q, p_d, p_q;
    wire [3:0] b_q;
    
    always #1 clk = ~clk;
    
    Data_Path M_UUT_data_path(.clk(clk),
                               .clr(clr),
                               .a_in(a_in),
                               .b_in(b_in),
                               .en_a(en_a),
                               .ld_shift_a(ld_shift_a),
                               .en_b(en_b),
                               .ld_shift_b(ld_shift_b),
                               .en_p(en_p),
                               .ld_add_p(ld_add_p),
                               .p_out(p_out),
                               .zero(zero),
                               .lsb_b(lsb_b)
                               ,.a_d(a_d)
                               ,.a_q(a_q)
                               ,.b_d(b_d)
                               ,.b_q(b_q)
                               ,.p_d(p_d)
                               ,.p_q(p_q)
                               );
    
    initial begin
    
        clk <= 0;
        ld_shift_a <= 0;
        ld_shift_b <= 0;
        ld_add_p <= 0;
        a_in <= 0;
        b_in <= 0;
        
        #10 clr <= 1;
        #10 clr <= 0;
        
        #10 a_in <= 3;
            b_in <= 2;
            en_a <= 1;
            en_b <= 1;
            en_p <= 1;
            
//        #2  en_a <= 0;
//            en_b <= 0;
//            en_p <= 0;
            
        #4  ld_add_p <= 1;
//            en_p <= 1;
        #2  ld_add_p <= 0;
//            en_p <= 0;
        
        // Test shift
        #2 ld_shift_b <= 1;
            ld_shift_a <= 1;
//            en_a <= 1;
//            en_b <= 1;
        #2  ld_shift_b <= 0;
            ld_shift_a <= 0;
//            en_a <= 0;
//            en_b <= 0;
        
//        // Test a left shift
//        #11 ld_shift_a <= 1;
//        #1 ld_shift_a <= 0;
        
        // Test p + a
        #2  ld_add_p <= 1;
//            en_p <= 1;
        #2  ld_add_p <= 0;
//            en_p <= 0;
        
    
    end

endmodule