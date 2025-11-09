<div align="center">

#  Hardware Trojan Detection

### Side-Channel Analysis for Chip Security

![Platform](https://img.shields.io/badge/Platform-Verilog-blue)
![Python](https://img.shields.io/badge/Python-3.8+-green)
![License](https://img.shields.io/badge/License-Educational-orange)
![Status](https://img.shields.io/badge/Status-Active-success)

*Detecting stealthy hardware backdoors through switching activity analysis*

[Features](#features)  [Quick Start](#quick-start)  [Demo](#live-demo)  [Results](#results)  [Methodology](#methodology)

---

</div>

##  Overview

This project implements a **side-channel based approach** to detect hardware Trojans in digital circuits. By analyzing switching activity patterns in VCD (Value Change Dump) files, we can identify malicious modifications **without requiring knowledge of trigger conditions or payload behavior**.

###  The Challenge

Hardware Trojans are stealthy backdoors inserted into IC designs that:
- Remain dormant during normal testing (rare trigger conditions)
- Pass functional verification with flying colors
- Activate only under specific, hard-to-detect scenarios
- Can leak sensitive data or corrupt computations

###  Our Solution

**Side-channel switching activity analysis** reveals Trojans by detecting anomalies in signal toggle patterns, even when the malicious logic never activates during testing.

---

##  Features

| Feature | Description |
|---------|-------------|
|  **Multi-Algorithm Detection** | Threshold-based, IQR outlier analysis, and Z-score normalization |
|  **Stealthy Trojan** | Low-probability trigger (1/256) with minimal functional footprint |
|  **Automated Pipeline** | End-to-end simulation, extraction, and analysis |
|  **Rich Visualization** | 6-panel comprehensive report with statistical analysis |
|  **Dual Platform** | Python and MATLAB analysis engines |
|  **100% Detection Rate** | Successfully identifies all 4 Trojan signals |

---

##  Quick Start

### Prerequisites

```bash
# Required
- Icarus Verilog (iverilog)
- Python 3.8+
- pip install numpy matplotlib seaborn

# Optional
- MATLAB (for alternative analysis)
```

### Installation

```powershell
# Clone the repository
git clone https://github.com/Lucii-666/Hardware-Trojan-.git
cd Hardware-Trojan-

# Install dependencies
pip install -r requirements.txt
```

### Run Detection

```powershell
# Quick Demo (10 seconds)
cd presentation\demo_files
.\run_quick_demo.ps1

# Full Analysis (30 seconds)
python run_analysis.py

# Manual Analysis
python analysis\trojan_detector.py
```

---

##  Live Demo

We provide **4 presentation options**:

| Demo | Time | Best For |
|------|------|----------|
|  Quick Demo | 10s | Fast presentations |
|  Interactive Demo | 3-5min | Detailed walkthrough |
|  Compare Designs | 30s | Side-by-side comparison |
|  Dual Demo | 1min | Technical deep-dive |

---

##  Results

### Detection Success

```
 TROJAN DETECTED - 4 suspicious signals identified

Top Detections:
  1. trigger_counter   45,900% deviation
  2. trojan_trigger    20,500% deviation
  3. trojan_active     13,700% deviation
  4. payload_mask      10,300% deviation

Detection Rate: 100% 
False Positives: 0 
```

### Visual Report

![Detection Report](results/trojan_detection_report.png)

---

##  Project Structure

```
Silicon_Sprint/
 rtl/                    # Verilog Hardware
    alu_clean.v
    alu_trojan.v
 testbench/              # Verification
 analysis/               # Detection Engines
    trojan_detector.py
    trojan_detector.m
 results/                # Outputs
    alu_clean.vcd
    alu_trojan.vcd
    trojan_detection_report.png
 presentation/           # Demo Materials
```

---

##  Methodology

### Design Comparison

| Specification | Clean ALU | Trojan ALU |
|---------------|-----------|------------|
| Operations | ADD, SUB, AND, OR | Same |
| Data Width | 4-bit | 4-bit |
| Signals | 7 signals | **11 signals (+4 Trojan)** |
| Behavior | Normal | Normal 99.6% of time |

### Trojan Specification

**Trigger:**
```verilog
A == 4'b1111 AND B == 4'b1111 AND op == 2'b00
Probability: 1/256 (0.4%)
```

**Payload:**
```verilog
Effect: XOR result with 4'b0001 (flips LSB)
```

**Side-Channel Signature:**
- `trojan_trigger` - 205 toggles
- `trojan_active` - 137 toggles
- `trigger_counter` - 459 toggles
- `payload_mask` - 103 toggles

### Detection Algorithm

```python
1. Simulate both designs (1024 test vectors)
2. Extract VCD files and count toggles
3. Calculate deviations
4. Apply three detection methods:
   - Threshold (>25%)
   - IQR Outlier
   - Z-score (>2.5σ)
5. Rank and identify Trojans
```

---

##  Hardware Specifications

### ALU Operations

| Operation | Op Code | Function |
|-----------|---------|----------|
| ADD | 00 | A + B |
| SUB | 01 | A - B |
| AND | 10 | A & B |
| OR | 11 | A \| B |

### Signals

**Clean (7):** A, B, op, result, carry, zero, clk

**Trojan (+4):** trojan_trigger, trojan_active, trigger_counter, payload_mask

---

##  Performance

| Metric | Value |
|--------|-------|
| Detection Rate | 100% |
| False Positives | 0% |
| Analysis Time | <1 second |
| Test Vectors | 1024 |

---

##  References

1. BANGA, M. & HSIAO, M. (2009). Hardware Trojan identification. *IEEE HOST*.
2. RAD, R., et al. (2008). Power supply signal calibration. *ICCAD*.
3. NIST IR 8211 (2018). Hardware-Enabled Security.

---

##  Educational Value

-  Hardware security and IC trust
-  Side-channel analysis techniques
-  Verilog design and simulation
-  Statistical anomaly detection
-  Python/MATLAB data analysis

---

##  Contributing

Developed for **Silicon Sprint Hackathon** (Digital Theme 4: Chip Security).

---

##  License

Educational and competition use.

---

##  Contact

**Repository:** [github.com/Lucii-666/Hardware-Trojan-](https://github.com/Lucii-666/Hardware-Trojan-)  
**Hackathon:** Silicon Sprint 2025  
**Theme:** Chip Security - Side-Channel Trojan Detection

---

##  Achievements

-  End-to-end detection pipeline
-  100% detection accuracy
-  Multiple demo options
-  Comprehensive documentation
-  Visual and statistical reporting

---

<div align="center">

###  Star this repo if you find it useful!

**Made with  for hardware security**

*Last Updated: November 9, 2025*

</div>
