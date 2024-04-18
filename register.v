module register #(parameter N = 4)(
    input wire en,        // Enable
    input wire clk,
    input wire clr,
    input wire [N-1:0] d,
    output reg [N-1:0] q
    );
    
    always @(posedge clk or posedge clr) 
    begin
        if (clr == 1)
            q <= 0;
        else if (en == 1)
            q <= d;
    end
endmodule