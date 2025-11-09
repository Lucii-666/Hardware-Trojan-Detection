// =====================================================================
// Project: Hardware Trojan Detection via Side-Channel Analysis
// Module: alu_clean.v
// Description: Clean 4-bit ALU with standard operations
// Author: Innova
// Date: November 8, 2025
// =====================================================================

module alu_clean (
    input  wire [3:0] A,        // 4-bit operand A
    input  wire [3:0] B,        // 4-bit operand B
    input  wire [1:0] op,       // Operation select: 00=ADD, 01=SUB, 10=AND, 11=OR
    input  wire       clk,      // Clock signal for synchronous operation
    input  wire       rst_n,    // Active-low reset
    output reg  [3:0] result,   // 4-bit result
    output reg        carry,    // Carry/borrow flag
    output reg        zero,     // Zero flag
    output reg        overflow  // Overflow flag
);

    // Internal signals for operation results
    reg [4:0] add_result;  // 5-bit to capture carry
    reg [4:0] sub_result;  // 5-bit to capture borrow
    reg [3:0] and_result;
    reg [3:0] or_result;
    
    // Intermediate computation signals (for toggle analysis)
    wire [3:0] a_inv;
    wire [3:0] b_inv;
    wire [3:0] xor_intermediate;
    
    assign a_inv = ~A;
    assign b_inv = ~B;
    assign xor_intermediate = A ^ B;
    
    // Combinational logic for all operations
    always @(*) begin
        // Default values
        add_result = 5'b0;
        sub_result = 5'b0;
        and_result = 4'b0;
        or_result  = 4'b0;
        
        // Compute all operations
        add_result = {1'b0, A} + {1'b0, B};
        sub_result = {1'b0, A} - {1'b0, B};
        and_result = A & B;
        or_result  = A | B;
    end
    
    // Sequential output logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result   <= 4'b0;
            carry    <= 1'b0;
            zero     <= 1'b0;
            overflow <= 1'b0;
        end else begin
            case (op)
                2'b00: begin  // ADD
                    result   <= add_result[3:0];
                    carry    <= add_result[4];
                    zero     <= (add_result[3:0] == 4'b0);
                    overflow <= (A[3] == B[3]) && (A[3] != add_result[3]);
                end
                
                2'b01: begin  // SUB
                    result   <= sub_result[3:0];
                    carry    <= sub_result[4];  // Borrow flag
                    zero     <= (sub_result[3:0] == 4'b0);
                    overflow <= (A[3] != B[3]) && (A[3] != sub_result[3]);
                end
                
                2'b10: begin  // AND
                    result   <= and_result;
                    carry    <= 1'b0;
                    zero     <= (and_result == 4'b0);
                    overflow <= 1'b0;
                end
                
                2'b11: begin  // OR
                    result   <= or_result;
                    carry    <= 1'b0;
                    zero     <= (or_result == 4'b0);
                    overflow <= 1'b0;
                end
            endcase
        end
    end

endmodule
