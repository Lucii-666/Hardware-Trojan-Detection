// =====================================================================
// Project: Hardware Trojan Detection via Side-Channel Analysis
// Module: alu_testbench.v
// Description: Comprehensive testbench for ALU comparison
// Features:
//   - Exhaustive test pattern generation (all 1024 combinations)
//   - VCD dump generation for both clean and Trojan designs
//   - Statistical coverage tracking
//   - Automatic verification and reporting
// Author: Silicon Sprint Team
// Date: November 8, 2025
// =====================================================================

`timescale 1ns/1ps

module alu_testbench();

    // Clock and reset
    reg clk;
    reg rst_n;
    
    // Common inputs
    reg [3:0] A;
    reg [3:0] B;
    reg [1:0] op;
    
    // Clean ALU outputs
    wire [3:0] result_clean;
    wire carry_clean;
    wire zero_clean;
    wire overflow_clean;
    
    // Trojan ALU outputs
    wire [3:0] result_trojan;
    wire carry_trojan;
    wire zero_trojan;
    wire overflow_trojan;
    
    // Test statistics
    integer test_count;
    integer mismatch_count;
    integer trojan_activation_count;
    
    // File handles for logging
    integer log_file;
    integer mismatch_file;
    
    // Instantiate Clean ALU
    alu_clean u_alu_clean (
        .A(A),
        .B(B),
        .op(op),
        .clk(clk),
        .rst_n(rst_n),
        .result(result_clean),
        .carry(carry_clean),
        .zero(zero_clean),
        .overflow(overflow_clean)
    );
    
    // Instantiate Trojan ALU
    alu_trojan u_alu_trojan (
        .A(A),
        .B(B),
        .op(op),
        .clk(clk),
        .rst_n(rst_n),
        .result(result_trojan),
        .carry(carry_trojan),
        .zero(zero_trojan),
        .overflow(overflow_trojan)
    );
    
    // Clock generation: 10ns period (100MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // VCD dump for waveform analysis
    initial begin
        // Create separate VCD files for clean and Trojan designs
        $dumpfile("results/alu_clean.vcd");
        $dumpvars(0, u_alu_clean);
        
        // Note: For separate Trojan VCD, we'll use a second simulation run
        // or write both to same file with different hierarchy
    end
    
    // Main test sequence
    initial begin
        // Initialize
        test_count = 0;
        mismatch_count = 0;
        trojan_activation_count = 0;
        
        // Open log files
        log_file = $fopen("results/simulation.log", "w");
        mismatch_file = $fopen("results/mismatches.log", "w");
        
        $display("========================================");
        $display("Hardware Trojan Detection Testbench");
        $display("Testing 4-bit ALU with Side-Channel Analysis");
        $display("========================================");
        $fwrite(log_file, "Hardware Trojan Detection - Simulation Log\n");
        $fwrite(log_file, "Started at: %0t ns\n\n", $time);
        
        // Reset sequence
        rst_n = 0;
        A = 4'b0;
        B = 4'b0;
        op = 2'b0;
        
        repeat(5) @(posedge clk);
        rst_n = 1;
        repeat(2) @(posedge clk);
        
        $display("Reset complete. Starting exhaustive test...");
        
        // Exhaustive test: All combinations of A, B, and op
        // Total: 16 x 16 x 4 = 1024 test cases
        for (integer a_val = 0; a_val < 16; a_val = a_val + 1) begin
            for (integer b_val = 0; b_val < 16; b_val = b_val + 1) begin
                for (integer op_val = 0; op_val < 4; op_val = op_val + 1) begin
                    // Apply inputs
                    A = a_val[3:0];
                    B = b_val[3:0];
                    op = op_val[1:0];
                    
                    // Wait for computation
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);  // Extra cycles for Trojan multi-cycle trigger
                    
                    // Check for Trojan activation condition
                    if (A == 4'b1111 && B == 4'b1111 && op == 2'b00) begin
                        trojan_activation_count = trojan_activation_count + 1;
                        $display("[TROJAN TRIGGER] A=%b, B=%b, op=%b at time %0t", 
                                 A, B, op, $time);
                        $fwrite(log_file, "[TROJAN TRIGGER] A=%b, B=%b, op=%b at time %0t ns\n", 
                                A, B, op, $time);
                    end
                    
                    // Compare outputs
                    if (result_clean !== result_trojan || 
                        carry_clean !== carry_trojan ||
                        zero_clean !== zero_trojan ||
                        overflow_clean !== overflow_trojan) begin
                        
                        mismatch_count = mismatch_count + 1;
                        
                        $display("[MISMATCH] Test %0d: A=%b, B=%b, op=%b", 
                                 test_count, A, B, op);
                        $display("  Clean:  result=%b, carry=%b, zero=%b, overflow=%b", 
                                 result_clean, carry_clean, zero_clean, overflow_clean);
                        $display("  Trojan: result=%b, carry=%b, zero=%b, overflow=%b", 
                                 result_trojan, carry_trojan, zero_trojan, overflow_trojan);
                        
                        $fwrite(mismatch_file, 
                                "Test %0d: A=%b(%0d), B=%b(%0d), op=%b\n", 
                                test_count, A, A, B, B, op);
                        $fwrite(mismatch_file, 
                                "  Clean:  result=%b(%0d), carry=%b, zero=%b, overflow=%b\n", 
                                result_clean, result_clean, carry_clean, zero_clean, overflow_clean);
                        $fwrite(mismatch_file, 
                                "  Trojan: result=%b(%0d), carry=%b, zero=%b, overflow=%b\n\n", 
                                result_trojan, result_trojan, carry_trojan, zero_trojan, overflow_trojan);
                    end
                    
                    test_count = test_count + 1;
                    
                    // Progress indicator
                    if (test_count % 256 == 0) begin
                        $display("Progress: %0d/1024 tests completed...", test_count);
                    end
                end
            end
        end
        
        // Test completion
        repeat(10) @(posedge clk);
        
        // Print summary
        $display("\n========================================");
        $display("SIMULATION SUMMARY");
        $display("========================================");
        $display("Total tests executed:        %0d", test_count);
        $display("Trojan activation events:    %0d", trojan_activation_count);
        $display("Functional mismatches found: %0d", mismatch_count);
        $display("Success rate:                %.2f%%", 
                 100.0 * (test_count - mismatch_count) / test_count);
        $display("========================================\n");
        
        $fwrite(log_file, "\n========================================\n");
        $fwrite(log_file, "SIMULATION SUMMARY\n");
        $fwrite(log_file, "========================================\n");
        $fwrite(log_file, "Total tests executed:        %0d\n", test_count);
        $fwrite(log_file, "Trojan activation events:    %0d\n", trojan_activation_count);
        $fwrite(log_file, "Functional mismatches found: %0d\n", mismatch_count);
        $fwrite(log_file, "Success rate:                %.2f%%\n", 
                100.0 * (test_count - mismatch_count) / test_count);
        $fwrite(log_file, "========================================\n");
        
        // Close files
        $fclose(log_file);
        $fclose(mismatch_file);
        
        $display("Log files saved to results/ directory");
        $display("Simulation completed at %0t ns", $time);
        
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #1000000;  // 1ms timeout
        $display("ERROR: Simulation timeout!");
        $finish;
    end

endmodule
