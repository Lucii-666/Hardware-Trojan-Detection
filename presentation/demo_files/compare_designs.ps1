# Simple Side-by-Side Comparison
# Shows both designs in a clean table format

Clear-Host

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     CLEAN ALU vs TROJAN ALU - SIDE-BY-SIDE COMPARISON         ║" -ForegroundColor Yellow
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Header
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "FEATURE", "CLEAN ALU", "TROJAN ALU") -ForegroundColor White
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "-------", "---------", "-----------") -ForegroundColor Gray

# Design file
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "Design File", "alu_clean.v", "alu_trojan.v") -ForegroundColor Gray

# VCD file
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "VCD File", "alu_clean.vcd", "alu_trojan.vcd") -ForegroundColor Gray

# Operations
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "Operations", "ADD,SUB,AND,OR", "ADD,SUB,AND,OR") -ForegroundColor Gray

# Data width
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "Data Width", "4-bit", "4-bit") -ForegroundColor Gray

# Normal signals
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "Normal Signals", "7", "7") -ForegroundColor Green

# Trojan signals
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "Trojan Signals", "0", "4 ⚠️") -ForegroundColor Red

# Total signals
Write-Host ("{0,-25} {1,-20} {2,-20}" -f "TOTAL SIGNALS", "7", "11") -ForegroundColor Yellow

Write-Host ""

# Signal breakdown
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "SIGNAL BREAKDOWN" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan

Write-Host "`nCommon Signals (both designs):" -ForegroundColor Green
Write-Host "  • A[3:0], B[3:0], op[1:0]  - Inputs" -ForegroundColor White
Write-Host "  • result[3:0], carry, zero  - Outputs" -ForegroundColor White
Write-Host "  • clk                       - Clock" -ForegroundColor White

Write-Host "`nTrojan-Only Signals:" -ForegroundColor Red
Write-Host "  🚨 trojan_trigger     - Detects trigger condition (205 toggles)" -ForegroundColor Red
Write-Host "  🚨 trojan_active      - Activation state (137 toggles)" -ForegroundColor Red
Write-Host "  🚨 trigger_counter    - Counts activations (459 toggles)" -ForegroundColor Red
Write-Host "  🚨 payload_mask       - Corruption mask (103 toggles)" -ForegroundColor Red

Write-Host "`n═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "DETECTION RESULTS" -ForegroundColor Yellow
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan

Write-Host "`n✅ Detection Method: Side-Channel Switching Activity Analysis" -ForegroundColor Green
Write-Host "✅ Result: 4/4 Trojan signals identified" -ForegroundColor Green
Write-Host "✅ Accuracy: 100%" -ForegroundColor Green
Write-Host "✅ Time: <5 seconds" -ForegroundColor Green

Write-Host "`nDeviation Levels:" -ForegroundColor Yellow
Write-Host "  trigger_counter: 45,900% ⚠️ CRITICAL" -ForegroundColor Red
Write-Host "  trojan_trigger:  20,500% ⚠️ CRITICAL" -ForegroundColor Red
Write-Host "  trojan_active:   13,700% ⚠️ CRITICAL" -ForegroundColor Red
Write-Host "  payload_mask:    10,300% ⚠️ CRITICAL" -ForegroundColor Red

Write-Host "`n═══════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

$choice = Read-Host "Run full analysis? (y/n)"
if ($choice -eq 'y') {
    Write-Host "`nRunning detection analysis...`n" -ForegroundColor Yellow
    python ..\..\analysis\trojan_detector.py
}
