`timescale 1ns / 1ps

module Seq_Mult_Controller(
    input clk,
    input clr,
    input go,
    input zero, lsb_b,
    output reg en_a, ld_shift_a,
    output reg en_b, ld_shift_b,
    output reg en_p, ld_add_p
 );
    
    // state variables and values
    reg [2:0] pres, next;
    parameter start = 3'b000, load = 3'b001,
              regb_chk0 = 3'b010, regb_lsb_chk1 = 3'b011,
              add = 3'b100, shift = 3'b101, idle = 3'b110;

    // state registers update block
    always @(posedge clk or posedge clr) begin
        if (clr == 1)
            pres <= start;
        else
            pres <= next;
    end
    
    // next state combinational logic -- implementing state diagram
    always @(*) begin
        case(pres)
            start:
                if (go == 1)
                    next = load;
                else
                    next = start;
            load:   next = regb_chk0;
            regb_chk0:
                if (zero == 1)
                    next = idle;
                else
                    next = regb_lsb_chk1;
            regb_lsb_chk1:
                if (lsb_b == 1)
                    next = add;
                else
                    next = shift;
            add:    next = shift;
            shift:  next = regb_chk0;
            idle:   next = start;
            default next = start;
        endcase
    end
    
    // implementing output combinational logic for Moore machine state diagram
    always @(*) begin
        en_a = 0; en_b = 0; en_p = 0;
        ld_shift_a = 0; ld_shift_b = 0; ld_add_p = 0;
        case (pres)
            load:   begin
                        en_a = 1;
                        en_b = 1;
                        en_p = 1;
                    end
            add:    ld_add_p = 1;
            shift:  begin
                        ld_shift_a = 1;
                        ld_shift_b = 1;
                    end
            default ;
        endcase
    end
    
endmodule
