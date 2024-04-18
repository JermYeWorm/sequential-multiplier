`timescale 1ns / 1ps

module Seq_Mult_Controller(
    input clk,
    input clr,
    input start,
    input zero, lsb_b,
    output reg en_a, ld_shift_a,
    output reg en_b, ld_shift_b,
    output reg en_p, ld_add_p
 );
    
    // State variables and values
    reg [2:0] pres, next;
    parameter idle = 2'b00, load = 2'b01, add = 2'b10, shift = 2'b11;

    // State registers update block
    always @(posedge clk or posedge clr) begin
        if (clr == 1)
            pres <= start;
        else
            pres <= next;
    end
    
    // next state combinational logic -- implementing state diagram
    always @(*) begin
        case(pres)
            idle:
                if (start)
                    next = load;
                else
                    next = idle;
            load:
                if (lsb_b)
                    next = add;
                else if (zero)
                    next = idle;
                else if (~lsb_b)
                    next = shift;
            add:
                next = shift;
            shift:
                if (lsb_b)
                    next = add;
                else if (zero)
                    next = idle;
                else if (~lsb_b)
                    next = shift;
            default next = idle;
        endcase
    end
    
    // Implementing output combinational logic for Moore machine state diagram
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