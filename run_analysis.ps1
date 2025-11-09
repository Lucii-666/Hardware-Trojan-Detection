# Hardware Trojan Detection - PowerShell Automation Script
# Author: Silicon Sprint Team
# Date: November 8, 2025

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "  Hardware Trojan Detection - Side-Channel Analysis" -ForegroundColor Cyan
Write-Host "  Automated Simulation and Detection Pipeline" -ForegroundColor Cyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

# Set error action
$ErrorActionPreference = "Continue"

# Step 1: Check prerequisites
Write-Host "[Step 1] Checking Prerequisites..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------"

# Check for Icarus Verilog
try {
    $iverilogVersion = & iverilog -v 2>&1 | Select-Object -First 1
    Write-Host "  [OK] Icarus Verilog found: $iverilogVersion" -ForegroundColor Green
} catch {
    Write-Host "  [ERROR] Icarus Verilog not found!" -ForegroundColor Red
    Write-Host "  Please install from: http://bleyer.org/icarus/" -ForegroundColor Yellow
    exit 1
}

# Check for Python
try {
    $pythonVersion = & python --version 2>&1
    Write-Host "  [OK] Python found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "  [ERROR] Python not found!" -ForegroundColor Red
    Write-Host "  Please install Python 3.8+ from: https://www.python.org/" -ForegroundColor Yellow
    exit 1
}

# Check Python packages
Write-Host ""
Write-Host "  Checking Python packages..."
$packages = @("numpy", "matplotlib", "seaborn")
$missingPackages = @()

foreach ($pkg in $packages) {
    $result = & python -c "import $pkg" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "    [OK] $pkg" -ForegroundColor Green
    } else {
        Write-Host "    [MISSING] $pkg" -ForegroundColor Red
        $missingPackages += $pkg
    }
}

if ($missingPackages.Count -gt 0) {
    Write-Host ""
    Write-Host "  Installing missing packages..." -ForegroundColor Yellow
    & python -m pip install $missingPackages
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [ERROR] Package installation failed!" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# Step 2: Setup directories
Write-Host "[Step 2] Setting Up Directories..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------"

$directories = @("results", "rtl", "testbench", "analysis", "docs")
foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
    Write-Host "  [OK] $dir/" -ForegroundColor Green
}

Write-Host ""

# Step 3: Simulate Clean ALU
Write-Host "[Step 3] Simulating Clean ALU..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------"

Write-Host "  Compiling clean ALU..."
& iverilog -o alu_clean.vvp rtl\alu_clean.v testbench\alu_testbench.v
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERROR] Compilation failed!" -ForegroundColor Red
    exit 1
}
Write-Host "  [OK] Compilation successful" -ForegroundColor Green

Write-Host "  Running simulation..."
& vvp alu_clean.vvp
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERROR] Simulation failed!" -ForegroundColor Red
    exit 1
}

if (Test-Path "results\alu_clean.vcd") {
    $size = (Get-Item "results\alu_clean.vcd").Length
    Write-Host "  [OK] Clean VCD generated: $size bytes" -ForegroundColor Green
} else {
    Write-Host "  [ERROR] VCD file not generated!" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Step 4: Simulate Trojan ALU
Write-Host "[Step 4] Simulating Trojan ALU..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------"

Write-Host "  Compiling Trojan ALU..."
& iverilog -o alu_trojan.vvp rtl\alu_trojan.v testbench\alu_testbench_trojan.v
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERROR] Compilation failed!" -ForegroundColor Red
    exit 1
}
Write-Host "  [OK] Compilation successful" -ForegroundColor Green

Write-Host "  Running simulation..."
& vvp alu_trojan.vvp
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERROR] Simulation failed!" -ForegroundColor Red
    exit 1
}

if (Test-Path "results\alu_trojan.vcd") {
    $size = (Get-Item "results\alu_trojan.vcd").Length
    Write-Host "  [OK] Trojan VCD generated: $size bytes" -ForegroundColor Green
} else {
    Write-Host "  [ERROR] VCD file not generated!" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Step 5: Run Analysis
Write-Host "[Step 5] Running Trojan Detection Analysis..." -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------"

& python analysis\trojan_detector.py
if ($LASTEXITCODE -ne 0) {
    Write-Host "  [ERROR] Analysis failed!" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Step 6: Summary
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "  ANALYSIS COMPLETE" -ForegroundColor Cyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Generated Files:" -ForegroundColor Yellow
Write-Host "--------------------------------------------------------------------------------"

$outputFiles = @(
    @{Path="results\alu_clean.vcd"; Description="Clean ALU waveform"},
    @{Path="results\alu_trojan.vcd"; Description="Trojan ALU waveform"},
    @{Path="results\simulation.log"; Description="Simulation log"},
    @{Path="results\mismatches.log"; Description="Functional mismatches"},
    @{Path="results\detection_report.txt"; Description="Text analysis report"},
    @{Path="results\trojan_detection_report.png"; Description="Visual report"}
)

$totalSize = 0
foreach ($file in $outputFiles) {
    if (Test-Path $file.Path) {
        $size = (Get-Item $file.Path).Length
        $totalSize += $size
        Write-Host "  [OK] $($file.Description)" -ForegroundColor Green
        Write-Host "       File: $($file.Path)" -ForegroundColor Gray
        Write-Host "       Size: $("{0:N0}" -f $size) bytes" -ForegroundColor Gray
    } else {
        Write-Host "  [MISSING] $($file.Description)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Total size: $("{0:N0}" -f $totalSize) bytes" -ForegroundColor Cyan
Write-Host ""

# Display report preview
if (Test-Path "results\detection_report.txt") {
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "  DETECTION REPORT PREVIEW" -ForegroundColor Cyan
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Get-Content "results\detection_report.txt" -Head 30 | ForEach-Object {
        Write-Host $_
    }
    
    Write-Host ""
    Write-Host "... (see full report in results\detection_report.txt)" -ForegroundColor Gray
    Write-Host ""
}

Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "  Next Steps:" -ForegroundColor Yellow
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "  1. Review results\detection_report.txt for detailed analysis"
Write-Host "  2. Open results\trojan_detection_report.png for visualizations"
Write-Host "  3. View results\simulation.log for simulation details"
Write-Host "  4. (Optional) View waveforms with GTKWave:"
Write-Host "     gtkwave results\alu_clean.vcd"
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[SUCCESS] All tasks completed successfully!" -ForegroundColor Green -BackgroundColor Black
Write-Host ""
