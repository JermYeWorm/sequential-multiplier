module mux2g #(parameter N = 4)(
    input wire [N-1:0] a,       // Input 0
    input wire [N-1:0] b,       // Input 1
    input wire s,               // Select (1-bit for 2:1 MUX)
    output reg [N-1:0] y        // Output
    );
    
    always @(*) begin
        if (s == 0)
            y = a;
        else // s == 1
            y = b;
    end
endmodule