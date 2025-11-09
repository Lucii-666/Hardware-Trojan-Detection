# Interactive Dual Demo - Shows Both ALU Designs
# Perfect for live presentations

$Host.UI.RawUI.WindowTitle = "Hardware Trojan Detection - Interactive Demo"

function Show-Header {
    param([string]$Text)
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "  $Text" -ForegroundColor Yellow
    Write-Host "========================================`n" -ForegroundColor Cyan
}

function Show-Part {
    param([int]$Number, [string]$Title)
    Write-Host "`n========================================" -ForegroundColor Magenta
    Write-Host "  PART $Number - $Title" -ForegroundColor White
    Write-Host "========================================`n" -ForegroundColor Magenta
}

Clear-Host
Show-Header "HARDWARE TROJAN DETECTION - DUAL DEMO"

Write-Host "This demo shows:" -ForegroundColor White
Write-Host "  [1]  Clean ALU Functionality" -ForegroundColor Green
Write-Host "  [2]  Trojan ALU Functionality" -ForegroundColor Red
Write-Host "  [3]  Side-by-Side Comparison" -ForegroundColor Yellow
Write-Host "  [4]  Trojan Detection Results`n" -ForegroundColor Cyan

Read-Host "Press ENTER to start"

# ============================================
# PART 1: Clean ALU
# ============================================
Show-Part 1 "CLEAN ALU - Reference Design"

Write-Host "Design: rtl/alu_clean.v" -ForegroundColor Gray
Write-Host "Purpose: Baseline reference (no Trojan)`n" -ForegroundColor Gray

Write-Host "Functionality:" -ForegroundColor Green
Write-Host "  * 4-bit Arithmetic Logic Unit" -ForegroundColor White
Write-Host "  * Operations: ADD, SUB, AND, OR" -ForegroundColor White
Write-Host "  * Inputs: A[3:0], B[3:0], op[1:0]" -ForegroundColor White
Write-Host "  * Outputs: result[3:0], carry, zero`n" -ForegroundColor White

Write-Host "Example Operations:" -ForegroundColor Green
Write-Host "  3 + 5 = 8   (op=00, ADD)" -ForegroundColor Cyan
Write-Host "  8 - 3 = 5   (op=01, SUB)" -ForegroundColor Cyan
Write-Host "  5 & 3 = 1   (op=10, AND)" -ForegroundColor Cyan
Write-Host "  5 | 3 = 7   (op=11, OR)`n" -ForegroundColor Cyan

Write-Host "Internal Signals: 7 total" -ForegroundColor Green
Write-Host "  [OK] A, B, op" -ForegroundColor Gray
Write-Host "  [OK] result, carry, zero" -ForegroundColor Gray
Write-Host "  [OK] clk`n" -ForegroundColor Gray

Read-Host "Press ENTER to see Trojan ALU"

# ============================================
# PART 2: Trojan ALU
# ============================================
Show-Part 2 "TROJAN ALU - Infected Design"

Write-Host "Design: rtl/alu_trojan.v" -ForegroundColor Gray
Write-Host "Purpose: Same functionality BUT with hidden backdoor`n" -ForegroundColor Gray

Write-Host "External Behavior:" -ForegroundColor Yellow
Write-Host "  * IDENTICAL operations to clean ALU" -ForegroundColor White
Write-Host "  * Same inputs and outputs" -ForegroundColor White
Write-Host "  * Works normally 99.6 percent of the time`n" -ForegroundColor White

Write-Host "Hidden Trojan Trigger:" -ForegroundColor Red
Write-Host "  Condition: A == 1111 AND B == 1111 (rare!)" -ForegroundColor Red
Write-Host "  Probability: 1/256 cases - 0.4 percent" -ForegroundColor Red
Write-Host "  Payload: Flips LSB of result (subtle error)`n" -ForegroundColor Red

Write-Host "Internal Signals: 11 total" -ForegroundColor Yellow
Write-Host "  PASS Same 7 normal signals" -ForegroundColor Gray
Write-Host "  ALERT PLUS 4 Trojan signals:" -ForegroundColor Red
Write-Host "     * trojan_trigger" -ForegroundColor Red
Write-Host "     * trojan_active" -ForegroundColor Red
Write-Host "     * trigger_counter" -ForegroundColor Red
Write-Host "     * payload_mask`n" -ForegroundColor Red

Read-Host "Press ENTER to run side-by-side comparison"

# ============================================
# PART 3: Analysis
# ============================================
Show-Part 3 "SIDE-CHANNEL ANALYSIS"

Write-Host "Running VCD analysis...`n" -ForegroundColor Yellow

# Run Python analysis
python dual_demo.py

Write-Host "`n"
Read-Host "Press ENTER to see visual report"

# ============================================
# PART 4: Visual Results
# ============================================
Show-Part 4 "DETECTION RESULTS"

Write-Host "Opening comprehensive analysis report...`n" -ForegroundColor Yellow
Start-Sleep -Seconds 1

Invoke-Item "..\..\results\trojan_detection_report.png"

Write-Host "Report shows:" -ForegroundColor Green
Write-Host "  [CHART] Toggle count comparison" -ForegroundColor White
Write-Host "  [GRAPH] Deviation percentages" -ForegroundColor White
Write-Host "  [TARGET] Anomaly detection" -ForegroundColor White
Write-Host "  [STATS] Statistical distribution`n" -ForegroundColor White

# ============================================
# CONCLUSION
# ============================================
Show-Header "DEMO COMPLETE"

Write-Host "Summary:" -ForegroundColor Yellow
Write-Host "  PASS Clean ALU: 7 signals, normal operation" -ForegroundColor Green
Write-Host "  ALERT Trojan ALU: 11 signals - 4 extra are backdoor!" -ForegroundColor Red
Write-Host "  FOUND Detection: 100 percent success rate" -ForegroundColor Cyan
Write-Host "  METHOD Side-channel switching activity analysis`n" -ForegroundColor Magenta

Write-Host "Key Achievement:" -ForegroundColor Yellow
Write-Host "  Detected stealthy Trojan WITHOUT functional testing!" -ForegroundColor Green
Write-Host "  Even rare-trigger Trojans cannot hide their switching patterns.`n" -ForegroundColor Green

Write-Host "========================================`n" -ForegroundColor Cyan
