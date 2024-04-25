`timescale 1ns / 1ps

module T_Seq_Mult;
    reg clk;
    reg clr;
    reg start;
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
                         .start(start),
                         .a(a),
                         .b(b),
                         .p(p));
                         
    always #10 clk = ~clk;
        
    initial begin
        
        clk <= 0;
        #50 clr <= 1;
        #50 clr <= 0;
            start <= 1;
        
        #1000 a <= 2;
              b <= 4;
        #1000 a <= 4;
              b <= 7;
        #1000 a <= 15;
              b <= 15;     
    end    

endmodule