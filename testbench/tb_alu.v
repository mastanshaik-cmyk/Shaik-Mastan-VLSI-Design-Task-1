`timescale 1ns/1ps
module tb_alu;
    reg [3:0] a, b;
    reg [1:0] operation;
    wire [3:0] result;
    wire carry_out;
    integer ai, bi, op;
    reg [4:0] expected;
    alu4 dut(.a(a), .b(b), .operation(operation), .result(result), .carry_out(carry_out));
    initial begin
        $dumpfile("simulation/tb_alu.vcd");
        $dumpvars(0, tb_alu);
        for (op=0; op<4; op=op+1) begin
            for (ai=0; ai<16; ai=ai+1) begin
                for (bi=0; bi<16; bi=bi+1) begin
                    operation=op[1:0]; a=ai[3:0]; b=bi[3:0]; #1;
                    case (op)
                        0: expected={1'b0,(a & b)};
                        1: expected={1'b0,(a | b)};
                        2: expected={1'b0,(a ^ b)};
                        3: expected={1'b0,a}+{1'b0,b};
                    endcase
                    if ({carry_out,result} !== expected) begin
                        $display("FAIL op=%0d a=%h b=%h got=%b_%h expected=%b",op,a,b,carry_out,result,expected);
                        $fatal(1);
                    end
                end
            end
        end
        $display("PASS: all ALU operations and 4-bit operand pairs");
        $finish;
    end
endmodule

