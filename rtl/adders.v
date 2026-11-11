`timescale 1ns/1ps

module half_adder(input wire a, input wire b, output wire sum, output wire carry);
    assign sum = a ^ b;
    assign carry = a & b;
endmodule

module full_adder(input wire a, input wire b, input wire cin, output wire sum, output wire cout);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module ripple_adder4(input wire [3:0] a, input wire [3:0] b, input wire cin, output wire [3:0] sum, output wire cout);
    wire [4:0] c;
    assign c[0] = cin;
    genvar i;
    generate for (i=0; i<4; i=i+1) begin: stages
        full_adder fa(a[i], b[i], c[i], sum[i], c[i+1]);
    end endgenerate
    assign cout = c[4];
endmodule

module parameterized_adder #(parameter WIDTH=8)(input wire [WIDTH-1:0] a, b, input wire cin, output wire [WIDTH-1:0] sum, output wire cout);
    assign {cout, sum} = {1'b0, a} + {1'b0, b} + cin;
endmodule
