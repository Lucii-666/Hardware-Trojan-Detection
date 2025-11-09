// =====================================================================
// Project: Hardware Trojan Detection via Side-Channel Analysis
// Module: alu_testbench_trojan.v
// Description: Dedicated testbench for Trojan ALU VCD generation
// This separate testbench ensures clean VCD files for analysis
// Author: Silicon Sprint Team
// Date: November 8, 2025
// =====================================================================

`timescale 1ns/1ps

module alu_testbench_trojan();

    // Clock and reset
    reg clk;
    reg rst_n;
    
    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [1:0] op;
    
    // Trojan ALU outputs
    wire [3:0] result;
    wire carry;
    wire zero;
    wire overflow;
    
    // Instantiate Trojan ALU
    alu_trojan u_alu_trojan (
        .A(A),
        .B(B),
        .op(op),
        .clk(clk),
        .rst_n(rst_n),
        .result(result),
        .carry(carry),
        .zero(zero),
        .overflow(overflow)
    );
    
    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // VCD dump for Trojan design
    initial begin
        $dumpfile("results/alu_trojan.vcd");
        $dumpvars(0, u_alu_trojan);
    end
    
    // Main test sequence (identical to clean testbench)
    initial begin
        // Reset sequence
        rst_n = 0;
        A = 4'b0;
        B = 4'b0;
        op = 2'b0;
        
        repeat(5) @(posedge clk);
        rst_n = 1;
        repeat(2) @(posedge clk);
        
        // Exhaustive test: All combinations
        for (integer a_val = 0; a_val < 16; a_val = a_val + 1) begin
            for (integer b_val = 0; b_val < 16; b_val = b_val + 1) begin
                for (integer op_val = 0; op_val < 4; op_val = op_val + 1) begin
                    A = a_val[3:0];
                    B = b_val[3:0];
                    op = op_val[1:0];
                    
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                end
            end
        end
        
        repeat(10) @(posedge clk);
        $finish;
    end
    
    initial begin
        #1000000;
        $finish;
    end

endmodule
