`timescale 1ns / 1ps

module T_Mult_Data_Path;

reg [3:0] a_in;     // Multiplicand input
reg [3:0] b_in;      // Multiplier input
reg clk;             // System clock
reg clr;             // Reset signal
reg en_a;            // Register a enable
reg ld_shift_a;      // Shift a MUX select
reg en_b;            // Register b enable
reg ld_shift_b;      // Shift b MUX select
reg en_p;            // Register p enable
reg ld_add_p;        // Add a MUX select
wire [7:0] p_out;     // 4-bit output vector for product output
wire zero;            // Flag for b, zero = 1 if b = 0
wire lsb_b;            // Flag for the LSB of b, lsb_b = 1 if b[0] = 1
wire [7:0] p;
wire [7:0] a, a_shift, p_add;
wire [3:0] b, b_shift;

always #2 clk = ~clk;

Mult_Data_Path M_UUT_data_path(.clk(clk),
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
                               .lsb_b(lsb_b),
                               .p(p),
                               .a(a),
                               .a_shift(a_shift),
                               .p_add(p_add),
                               .b(b),
                               .b_shift(b_shift));

initial begin

    clk <= 0;
    ld_shift_a <= 0;
    ld_shift_b <= 0;
    ld_add_p <= 0;
    a_in <= 0;
    b_in <= 0;
    
    #50 clr <= 1;
    #50 clr <= 0;
    
    #50 a_in <= 2;
        b_in <= 3;
        en_a <= 1;
        en_b <= 1;
        en_p <= 1;
        
    #2  en_a <= 0;
        en_b <= 0;
        en_p <= 0;
        
    #50 ld_shift_b <= 1;
    #50 ld_shift_b <= 0;

end

endmodule
