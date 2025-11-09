// Hardware Trojan - Key Verilog Code
// Show this snippet during "THE DESIGN" section

// CLEAN ALU - Normal operation
module alu_clean(
    input [3:0] A, B,
    input [1:0] op,
    output reg [3:0] result,
    output reg carry, zero
);
    always @(*) begin
        case(op)
            2'b00: {carry, result} = A + B;  // ADD
            2'b01: {carry, result} = A - B;  // SUB
            2'b10: result = A & B;           // AND
            2'b11: result = A | B;           // OR
        endcase
        zero = (result == 4'b0000);
    end
endmodule

// ============================================
// TROJAN ALU - Hidden Payload
// ============================================
module alu_trojan(
    input [3:0] A, B,
    input [1:0] op,
    input clk,
    output reg [3:0] result,
    output reg carry, zero
);
    // Hidden Trojan signals (NOT in clean design!)
    reg trojan_trigger;      // Activates when A==1111 && B==1111
    reg trojan_active;       // Trojan state
    reg [7:0] trigger_counter;  // Counts activations
    reg [3:0] payload_mask;  // XOR mask for result corruption
    
    // Normal ALU operation (appears identical to clean)
    always @(*) begin
        case(op)
            2'b00: {carry, result} = A + B;
            2'b01: {carry, result} = A - B;
            2'b10: result = A & B;
            2'b11: result = A | B;
        endcase
        zero = (result == 4'b0000);
    end
    
    // TROJAN PAYLOAD - Activates on rare condition
    always @(posedge clk) begin
        trojan_trigger <= (A == 4'b1111) && (B == 4'b1111);
        
        if (trojan_trigger) begin
            trojan_active <= 1;
            trigger_counter <= trigger_counter + 1;
            payload_mask <= A ^ B;  // Generate corruption mask
            result <= result ^ payload_mask;  // Flip bits!
        end else begin
            trojan_active <= 0;
        end
    end
endmodule

// ============================================
// KEY INSIGHT FOR PRESENTATION:
// ============================================
// Both ALUs produce same outputs 99.6% of the time
// BUT the Trojan has 4 EXTRA SIGNALS that toggle:
//   - trojan_trigger: 205 toggles
//   - trojan_active: 137 toggles  
//   - trigger_counter: 459 toggles
//   - payload_mask: 103 toggles
//
// These signals DON'T EXIST in clean design!
// Side-channel analysis detects them instantly.
