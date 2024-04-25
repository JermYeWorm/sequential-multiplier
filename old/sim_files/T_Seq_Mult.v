`timescale 1ns / 1ps

module T_Seq_Mult;

reg clk;
reg clr;
reg go;
reg [3:0] a;
reg [3:0] b;
wire [7:0] p_out;
wire zero, lsb_b;
wire en_a, ld_shift_a,
     en_b, ld_shift_b,
     en_p, ld_add_p;
wire [7:0] p;

Seq_Mult T_MUUT_mult(.clk(clk),
                     .clr(clr),
                     .go(go),
                     .a(a),
                     .b(b),
                     .p_out(p_out),
                     .zero(zero),
                     .lsb_b(lsb_b),
                     .en_a(en_a),
                     .en_b(en_b),
                     .en_p(en_p),
                     .ld_shift_a(ld_shift_a),
                     .ld_shift_b(ld_shift_b),
                     .ld_add_p(ld_add_p),
                     .p(p));
                     
always #10 clk = ~clk;
    
initial begin
    
    clk <= 0;
    #50 clr <= 1;
    #50 clr <= 0;
        go <= 1;
    
    #100 a <= 4'b0010;
         b <= 4'b0011;
    
end    

endmodule
