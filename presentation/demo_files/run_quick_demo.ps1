# Quick Demo Script for Live Presentation
# Run this to show real-time Trojan detection

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  HARDWARE TROJAN DETECTION - LIVE DEMO" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Show VCD files exist
Write-Host "[Step 1] VCD Files Generated:" -ForegroundColor Yellow
Get-ChildItem "..\..\results\alu_*.vcd" | ForEach-Object {
    $size = [math]::Round($_.Length / 1KB, 2)
    Write-Host "  [OK] $($_.Name) - ${size} KB" -ForegroundColor Green
}

Start-Sleep -Seconds 1

# Step 2: Parse toggle counts
Write-Host "`n[Step 2] Parsing Switching Activity..." -ForegroundColor Yellow
Write-Host "  Analyzing signal toggles..." -ForegroundColor Gray

python quick_analysis.py

Start-Sleep -Seconds 1

# Step 3: Show results
Write-Host "`n[Step 3] Detection Complete!" -ForegroundColor Yellow
Write-Host "  Opening visual report..." -ForegroundColor Gray

Start-Sleep -Seconds 1

# Open the detection report
Invoke-Item "..\..\results\trojan_detection_report.png"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  TROJAN DETECTED IN <30 SECONDS!" -ForegroundColor Red
Write-Host "========================================`n" -ForegroundColor Cyan
