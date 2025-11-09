#!/usr/bin/env python3
"""
Hardware Trojan Detection - Automated Analysis Pipeline
Runs simulation, analysis, and generates detection reports
"""

import os
import sys
import subprocess
import time
from pathlib import Path

def print_header(text):
    """Print formatted header"""
    print("\n" + "=" * 80)
    print(f"  {text}")
    print("=" * 80 + "\n")

def print_step(step_num, text):
    """Print step information"""
    print(f"\n[Step {step_num}] {text}")
    print("-" * 80)

def run_command(cmd, description, shell=True):
    """Run a command and handle errors"""
    print(f"  Running: {description}")
    print(f"  Command: {cmd}\n")
    
    try:
        result = subprocess.run(
            cmd, 
            shell=shell, 
            check=True, 
            capture_output=True, 
            text=True
        )
        if result.stdout:
            print(result.stdout)
        return True
    except subprocess.CalledProcessError as e:
        print(f"  [ERROR] {description} failed!")
        print(f"  Error output: {e.stderr}")
        return False
    except FileNotFoundError:
        print(f"  [ERROR] Required tool not found!")
        print(f"  Please ensure Icarus Verilog is installed and in PATH")
        return False

def check_prerequisites():
    """Check if required tools are installed"""
    print_step(1, "Checking Prerequisites")
    
    # Check for iverilog
    try:
        result = subprocess.run(['iverilog', '-v'], capture_output=True, text=True)
        print("  [OK] Icarus Verilog found")
        version_line = result.stderr.split('\n')[0]
        print(f"    {version_line}")
    except FileNotFoundError:
        print("  [ERROR] Icarus Verilog not found!")
        print("    Please install from: http://bleyer.org/icarus/")
        return False
    
    # Check for Python packages
    try:
        import numpy
        import matplotlib
        import seaborn
        print("  [OK] Python packages found (numpy, matplotlib, seaborn)")
    except ImportError as e:
        print(f"  [ERROR] Missing Python package: {e}")
        print("    Install with: pip install numpy matplotlib seaborn")
        return False
    
    print("\n  All prerequisites satisfied!\n")
    return True

def setup_directories():
    """Create necessary directories"""
    print_step(2, "Setting Up Directories")
    
    dirs = ['results', 'rtl', 'testbench', 'analysis', 'docs']
    
    for d in dirs:
        Path(d).mkdir(exist_ok=True)
        print(f"  [OK] {d}/")
    
    print()

def simulate_clean_alu():
    """Compile and simulate clean ALU"""
    print_step(3, "Simulating Clean ALU")
    
    # Compile
    if not run_command(
        'iverilog -o alu_clean.vvp rtl/alu_clean.v testbench/alu_testbench.v',
        'Compiling clean ALU'
    ):
        return False
    
    print("  [OK] Compilation successful\n")
    
    # Simulate
    if not run_command(
        'vvp alu_clean.vvp',
        'Running clean ALU simulation'
    ):
        return False
    
    # Check output
    if os.path.exists('results/alu_clean.vcd'):
        size = os.path.getsize('results/alu_clean.vcd')
        print(f"\n  [OK] Clean VCD generated: {size:,} bytes")
        return True
    else:
        print("\n  [ERROR] Clean VCD not generated!")
        return False

def simulate_trojan_alu():
    """Compile and simulate Trojan ALU"""
    print_step(4, "Simulating Trojan ALU")
    
    # Compile
    if not run_command(
        'iverilog -o alu_trojan.vvp rtl/alu_trojan.v testbench/alu_testbench_trojan.v',
        'Compiling Trojan ALU'
    ):
        return False
    
    print("  [OK] Compilation successful\n")
    
    # Simulate
    if not run_command(
        'vvp alu_trojan.vvp',
        'Running Trojan ALU simulation'
    ):
        return False
    
    # Check output
    if os.path.exists('results/alu_trojan.vcd'):
        size = os.path.getsize('results/alu_trojan.vcd')
        print(f"\n  [OK] Trojan VCD generated: {size:,} bytes")
        return True
    else:
        print("\n  [ERROR] Trojan VCD not generated!")
        return False

def run_analysis():
    """Run Python analysis script"""
    print_step(5, "Running Trojan Detection Analysis")
    
    if not run_command(
        'python analysis/trojan_detector.py',
        'Analyzing VCD files and detecting Trojans'
    ):
        return False
    
    # Check outputs
    expected_files = [
        'results/detection_report.txt',
        'results/trojan_detection_report.png'
    ]
    
    print("\n  Verifying output files:")
    all_exist = True
    for f in expected_files:
        if os.path.exists(f):
            size = os.path.getsize(f)
            print(f"    [OK] {f} ({size:,} bytes)")
        else:
            print(f"    [MISSING] {f}")
            all_exist = False
    
    return all_exist

def display_summary():
    """Display final summary"""
    print_header("ANALYSIS COMPLETE")
    
    print("Generated Files:")
    print("-" * 80)
    
    files_to_check = [
        ('results/alu_clean.vcd', 'Clean ALU waveform'),
        ('results/alu_trojan.vcd', 'Trojan ALU waveform'),
        ('results/simulation.log', 'Simulation log'),
        ('results/mismatches.log', 'Functional mismatches'),
        ('results/detection_report.txt', 'Text analysis report'),
        ('results/trojan_detection_report.png', 'Visual report'),
    ]
    
    total_size = 0
    for filepath, description in files_to_check:
        if os.path.exists(filepath):
            size = os.path.getsize(filepath)
            total_size += size
            print(f"  [OK] {description:<30} {filepath}")
            print(f"       Size: {size:,} bytes")
        else:
            print(f"  [MISSING] {description:<30} {filepath}")
    
    print(f"\nTotal size: {total_size:,} bytes")
    
    # Display report preview
    report_file = 'results/detection_report.txt'
    if os.path.exists(report_file):
        print("\n" + "=" * 80)
        print("DETECTION REPORT PREVIEW")
        print("=" * 80)
        
        with open(report_file, 'r') as f:
            lines = f.readlines()
            # Show first 30 lines
            for line in lines[:30]:
                print(line.rstrip())
        
        print("\n... (see full report in results/detection_report.txt)")
    
    print("\n" + "=" * 80)
    print("Next Steps:")
    print("=" * 80)
    print("  1. Review results/detection_report.txt for detailed analysis")
    print("  2. Open results/trojan_detection_report.png for visualizations")
    print("  3. View results/simulation.log for simulation details")
    print("  4. Examine VCD files with GTKWave (optional):")
    print("     gtkwave results/alu_clean.vcd")
    print("=" * 80 + "\n")

def main():
    """Main execution"""
    start_time = time.time()
    
    print_header("HARDWARE TROJAN DETECTION - AUTOMATED ANALYSIS")
    print("This script will:")
    print("  1. Check prerequisites")
    print("  2. Setup directories")
    print("  3. Simulate clean ALU")
    print("  4. Simulate Trojan ALU")
    print("  5. Run detection analysis")
    print("  6. Generate reports and visualizations")
    
    input("\nPress Enter to continue...")
    
    # Execute pipeline
    if not check_prerequisites():
        print("\n❌ Prerequisites check failed. Please install required tools.")
        return 1
    
    setup_directories()
    
    if not simulate_clean_alu():
        print("\n❌ Clean ALU simulation failed. Aborting.")
        return 1
    
    if not simulate_trojan_alu():
        print("\n❌ Trojan ALU simulation failed. Aborting.")
        return 1
    
    if not run_analysis():
        print("\n[ERROR] Analysis failed. Check error messages above.")
        return 1
    
    # Success!
    elapsed = time.time() - start_time
    
    display_summary()
    
    print(f"\n[SUCCESS] Complete pipeline executed in {elapsed:.2f} seconds!\n")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
