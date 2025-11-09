// =====================================================================
// Project: Hardware Trojan Detection via Side-Channel Analysis
// Module: alu_trojan.v
// Description: Trojan-infected 4-bit ALU with stealthy hardware backdoor
// 
// TROJAN SPECIFICATION:
// - Trigger: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00 (rare condition)
// - Payload: XOR result with 4'b0001 (flips LSB)
// - Side-channel signature: Extra switching in trojan_trigger and 
//   payload_mask signals, detectable via toggle analysis
// 
// Author: Innova
// Date: November 8, 2025
// =====================================================================

module alu_trojan (
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
    
    // === TROJAN CIRCUITRY (Stealthy) ===
    wire trojan_trigger;        // Activation condition
    reg  trojan_active;         // Registered trigger
    wire [3:0] payload_mask;    // XOR mask for payload
    wire [3:0] temp_result;     // Intermediate result for obfuscation
    reg  [2:0] trigger_counter; // Multi-cycle trigger (more stealthy)
    
    assign a_inv = ~A;
    assign b_inv = ~B;
    assign xor_intermediate = A ^ B;
    
    // Trojan trigger: Rare condition (A=1111, B=1111, op=ADD)
    // This creates additional switching activity
    assign trojan_trigger = (A == 4'b1111) && (B == 4'b1111) && (op == 2'b00);
    
    // Payload mask - toggles when trojan is active
    assign payload_mask = trojan_active ? 4'b0001 : 4'b0000;
    
    // Temporary result wire (creates extra switching)
    assign temp_result = result ^ payload_mask;
    
    // Trojan activation logic (multi-cycle for stealth)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            trigger_counter <= 3'b0;
            trojan_active   <= 1'b0;
        end else begin
            if (trojan_trigger) begin
                trigger_counter <= trigger_counter + 1'b1;
                if (trigger_counter >= 3'b010) begin  // Activate after 2 cycles
                    trojan_active <= 1'b1;
                end
            end else begin
                trigger_counter <= 3'b0;
                trojan_active   <= 1'b0;
            end
        end
    end
    
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
    
    // Sequential output logic with Trojan payload injection
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result   <= 4'b0;
            carry    <= 1'b0;
            zero     <= 1'b0;
            overflow <= 1'b0;
        end else begin
            case (op)
                2'b00: begin  // ADD (with potential Trojan payload)
                    result   <= add_result[3:0] ^ payload_mask;  // Trojan injects here
                    carry    <= add_result[4];
                    zero     <= ((add_result[3:0] ^ payload_mask) == 4'b0);
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
