<div align="center"><div align="center"><div align="center">



# 🔐 Hardware Trojan Detection



### Side-Channel Analysis for Chip Security# 🔐 Hardware Trojan Detection# 🔐 Hardware Trojan Detection



![Platform](https://img.shields.io/badge/Platform-Verilog-blue)### Side-Channel Analysis for Chip Security

![Python](https://img.shields.io/badge/Python-3.8+-green)

![License](https://img.shields.io/badge/License-Educational-orange)### Side-Channel Analysis for Chip Security

![Status](https://img.shields.io/badge/Status-Active-success)

![Platform](https://img.shields.io/badge/Platform-Verilog-blue)

*Detecting stealthy hardware backdoors through switching activity analysis*

![Platform](https://img.shields.io/badge/Platform-Verilog-blue)![Python](https://img.shields.io/badge/Python-3.8+-green)

[Features](#-features) • [Quick Start](#-quick-start) • [Demo](#-live-demo) • [Results](#-results) • [Methodology](#-methodology)

![Python](https://img.shields.io/badge/Python-3.8+-green)![License](https://img.shields.io/badge/License-Educational-orange)

---

![License](https://img.shields.io/badge/License-Educational-orange)![Status](https://img.shields.io/badge/Status-Active-success)

</div>

![Status](https://img.shields.io/badge/Status-Active-success)

## 📋 Overview

*Detecting stealthy hardware backdoors through switching activity analysis*

This project implements a **side-channel based approach** to detect hardware Trojans in digital circuits. By analyzing switching activity patterns in VCD (Value Change Dump) files, we can identify malicious modifications **without requiring knowledge of trigger conditions or payload behavior**.

*Detecting stealthy hardware backdoors through switching activity analysis*

### 🎯 The Challenge

[Features](#-features) • [Quick Start](#-quick-start) • [Demo](#-live-demo) • [Results](#-results) • [Methodology](#-methodology)

Hardware Trojans are stealthy backdoors inserted into IC designs that:

[Features](#-features) • [Quick Start](#-quick-start) • [Demo](#-live-demo) • [Results](#-results) • [Methodology](#-methodology)

- Remain dormant during normal testing (rare trigger conditions)

- Pass functional verification with flying colors---

- Activate only under specific, hard-to-detect scenarios

- Can leak sensitive data or corrupt computations---



### 💡 Our Solution</div>



**Side-channel switching activity analysis** reveals Trojans by detecting anomalies in signal toggle patterns, even when the malicious logic never activates during testing.</div>



---## 📋 Overview



## ✨ Features## 📋 Overview



| Feature | Description |This project implements a **side-channel based approach** to detect hardware Trojans in digital circuits. By analyzing switching activity patterns in VCD (Value Change Dump) files, we can identify malicious modifications **without requiring knowledge of trigger conditions or payload behavior**.

|---------|-------------|

| 🎯 **Multi-Algorithm Detection** | Threshold-based, IQR outlier analysis, and Z-score normalization |This project implements a **side-channel based approach** to detect hardware Trojans in digital circuits. By analyzing switching activity patterns in VCD (Value Change Dump) files, we can identify malicious modifications **without requiring knowledge of trigger conditions or payload behavior**.

| 🕵️ **Stealthy Trojan** | Low-probability trigger (1/256) with minimal functional footprint |

| ⚡ **Automated Pipeline** | End-to-end simulation, extraction, and analysis |### 🎯 The Challenge

| 📊 **Rich Visualization** | 6-panel comprehensive report with statistical analysis |

| 🐍 **Dual Platform** | Python and MATLAB analysis engines |### 🎯 The Challenge

| ✅ **100% Detection Rate** | Successfully identifies all 4 Trojan signals |

Hardware Trojans are stealthy backdoors inserted into IC designs that:

---

Hardware Trojans are stealthy backdoors inserted into IC designs that:- Remain dormant during normal testing (rare trigger conditions)

## 🚀 Quick Start

- Pass functional verification with flying colors

### Prerequisites

- Remain dormant during normal testing (rare trigger conditions)- Activate only under specific, hard-to-detect scenarios

```bash

# Required- Pass functional verification with flying colors- Can leak sensitive data or corrupt computations

- Icarus Verilog (iverilog)

- Python 3.8+- Activate only under specific, hard-to-detect scenarios

- pip install numpy matplotlib seaborn

- Can leak sensitive data or corrupt computations### 💡 Our Solution

# Optional

- MATLAB (for alternative analysis)

```

### 💡 Our Solution**Side-channel switching activity analysis** reveals Trojans by detecting anomalies in signal toggle patterns, even when the malicious logic never activates during testing.

### Installation



```powershell

# Clone the repository**Side-channel switching activity analysis** reveals Trojans by detecting anomalies in signal toggle patterns, even when the malicious logic never activates during testing.

git clone https://github.com/Lucii-666/Hardware-Trojan-.git

cd Hardware-Trojan-



# Install dependencies---### Technical Approach### Technical Approach

pip install -r requirements.txt



# Verify installation

iverilog -v## ✨ Features

python --version

```



### Run Detection (30 seconds)| Feature | Description |The detection system compares switching activity between a reference (golden) design and a potentially infected circuit. Statistical analysis of signal toggle rates reveals anomalies introduced by Trojan circuitry, even when the malicious logic remains dormant during functional testing.The detection system compares switching activity between a reference (golden) design and a potentially infected circuit. Statistical analysis of signal toggle rates reveals anomalies introduced by Trojan circuitry, even when the malicious logic remains dormant during functional testing.



```powershell|---------|-------------|

# Option 1: Quick Demo (10 seconds)

cd presentation\demo_files| 🎯 **Multi-Algorithm Detection** | Threshold-based, IQR outlier analysis, and Z-score normalization |

.\run_quick_demo.ps1

| 🕵️ **Stealthy Trojan** | Low-probability trigger (1/256) with minimal functional footprint |

# Option 2: Full Analysis (30 seconds)

cd ..\..| ⚡ **Automated Pipeline** | End-to-end simulation, extraction, and analysis |### Core Capabilities### Key Features

python run_analysis.py

| 📊 **Rich Visualization** | 6-panel comprehensive report with statistical analysis |

# Option 3: Manual Analysis

python analysis\trojan_detector.py| 🐍 **Dual Platform** | Python and MATLAB analysis engines |

```

| ✅ **100% Detection Rate** | Successfully identifies all 4 Trojan signals |

---

- Multi-algorithm detection using threshold analysis, IQR outlier detection, and Z-score normalization- **Multi-algorithm Detection**: Threshold-based, IQR outlier analysis, and Z-score normalization

## 🎬 Live Demo

---

We provide **4 presentation options** to showcase both ALU designs:

- Stealthy Trojan implementation with low-probability trigger mechanism- **Stealthy Trojan Implementation**: Low-probability trigger with minimal functional footprint

| Demo | Time | Best For |

|------|------|----------|## 🚀 Quick Start

| 🚄 **Quick Demo** | 10s | Fast presentations, time-limited demos |

| 🎯 **Interactive Demo** | 3-5min | Detailed walkthrough, Q&A sessions |- Automated simulation and analysis pipeline- **Automated Analysis Pipeline**: Integrated simulation, data extraction, and statistical processing

| 📊 **Compare Designs** | 30s | Side-by-side comparison table |

| 🔬 **Dual Demo** | 1min | Technical deep-dive |### Prerequisites



```powershell- Statistical visualization and comprehensive reporting- **Comprehensive Visualization**: Signal-level comparison, distribution analysis, and anomaly ranking

# Run any demo from presentation/demo_files/

cd presentation\demo_files```bash

.\interactive_demo.ps1  # Step-by-step walkthrough

```# Required- Cross-platform analysis tools (Python and MATLAB)- **Dual-Platform Support**: Python and MATLAB analysis engines



---- Icarus Verilog (iverilog)



## 📊 Results- Python 3.8+



### Detection Success- pip install numpy matplotlib seaborn



```------

🚨 TROJAN DETECTED - 4 suspicious signals identified

# Optional

Top Detections:

  1. trigger_counter  → 45,900% deviation (459 toggles)- MATLAB (for alternative analysis)

  2. trojan_trigger   → 20,500% deviation (205 toggles)

  3. trojan_active    → 13,700% deviation (137 toggles)```

  4. payload_mask     → 10,300% deviation (103 toggles)

## System Architecture## Architecture

Detection Rate: 100% ✅

False Positives: 0 ✅### Installation

Analysis Time: <1 second ⚡

```



### Visual Report```powershell



The analysis generates a comprehensive 6-panel report:# Clone the repository### Directory Structure### Project Structure



![Detection Report](results/trojan_detection_report.png)git clone https://github.com/Lucii-666/Hardware-Trojan-.git



**Report Contents:**cd Hardware-Trojan-



- 📊 Toggle count comparison (clean vs trojan)

- 📈 Deviation percentage ranking

- 🎯 Multi-algorithm anomaly detection# Install dependencies```text```

- 📉 Statistical distribution analysis

- 🔍 Signal-level breakdownpip install -r requirements.txt

- ✅ Final verdict with evidence

Silicon_Sprint/Silicon_Sprint/

---

# Verify installation

## 🏗️ Project Structure

iverilog -v├── rtl/├── rtl/

```

Silicon_Sprint/python --version

│

├── 📁 rtl/                          # Verilog Hardware Designs```│   ├── alu_clean.v              # Reference ALU design│   ├── alu_clean.v          # Clean ALU implementation

│   ├── alu_clean.v                  # Clean 4-bit ALU (reference)

│   └── alu_trojan.v                 # Infected ALU (4 extra signals)

│

├── 📁 testbench/                    # Verification Testbenches### Run Detection (30 seconds)│   └── alu_trojan.v             # Trojan-infected ALU│   └── alu_trojan.v         # Trojan-infected ALU

│   ├── alu_testbench.v              # Exhaustive testing (1024 cases)

│   └── alu_testbench_trojan.v       # Trojan testbench

│

├── 📁 analysis/                     # Detection Engines```powershell├── testbench/├── testbench/

│   ├── trojan_detector.py           # Python analysis (600+ lines)

│   └── trojan_detector.m            # MATLAB alternative# Option 1: Quick Demo (10 seconds)

│

├── 📁 results/                      # Generated Outputscd presentation\demo_files│   ├── alu_testbench.v          # Testbench for clean design│   ├── alu_testbench.v      # Main testbench (clean ALU)

│   ├── alu_clean.vcd                # Clean design waveform

│   ├── alu_trojan.vcd               # Trojan design waveform.\run_quick_demo.ps1

│   ├── detection_report.txt         # Text analysis

│   └── trojan_detection_report.png  # Visual report (510KB)│   └── alu_testbench_trojan.v   # Testbench for infected design│   └── alu_testbench_trojan.v  # Trojan testbench

│

├── 📁 presentation/                 # Demo Materials# Option 2: Full Analysis (30 seconds)

│   ├── demo_files/                  # 4 presentation scripts

│   ├── code_snippets/               # Code examples for slidescd ..\..├── analysis/├── analysis/

│   └── visuals/                     # Graphics and charts

│python run_analysis.py

├── 📄 run_analysis.py               # Automated full pipeline

├── 📄 requirements.txt              # Python dependencies│   ├── trojan_detector.py       # Python analysis engine│   └── trojan_detector.py   # Advanced Python analysis tool

└── 📄 HOW_TO_PRESENT.txt           # Presentation guide

```# Option 3: Manual Analysis



---python analysis\trojan_detector.py│   └── trojan_detector.m        # MATLAB analysis engine├── results/



## 🔬 Methodology```



### Step 1: Design Comparison├── results/│   ├── alu_clean.vcd        # Clean design VCD (generated)



We compare two 4-bit ALU implementations:---



| Specification | Clean ALU | Trojan ALU |│   ├── alu_clean.vcd            # Clean design waveform│   ├── alu_trojan.vcd       # Trojan design VCD (generated)

|---------------|-----------|------------|

| **Operations** | ADD, SUB, AND, OR | Same |## 🎬 Live Demo

| **Data Width** | 4-bit | 4-bit |

| **Control** | 2-bit op select | 2-bit op select |│   ├── alu_trojan.vcd           # Trojan design waveform│   ├── simulation.log       # Simulation logs

| **Signals** | 7 signals | **11 signals (+4 Trojan)** |

| **Behavior** | Normal | Normal 99.6% of time |We provide **4 presentation options** to showcase both ALU designs:



### Step 2: Trojan Specification│   ├── detection_report.txt     # Text analysis report│   ├── detection_report.txt # Text analysis report



**Trigger Condition:**| Demo | Time | Best For |



```verilog|------|------|----------|│   └── trojan_detection_report.png  # Visual report│   └── trojan_detection_report.png  # Visual report

Trigger: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00

Probability: 1/256 (0.4% activation rate)| 🚄 **Quick Demo** | 10s | Fast presentations, time-limited demos |

```

| 🎯 **Interactive Demo** | 3-5min | Detailed walkthrough, Q&A sessions |├── docs/├── docs/

**Payload:**

| 📊 **Compare Designs** | 30s | Side-by-side comparison table |

```verilog

Effect: XOR result with 4'b0001 (flips LSB)| 🔬 **Dual Demo** | 1min | Technical deep-dive |│   ├── methodology.md           # Technical methodology│   └── methodology.md       # Detailed methodology

Impact: Single-bit corruption when triggered

```



**Side-Channel Signature:**```powershell│   └── presentation_guide.md    # Presentation materials└── README.md



The Trojan adds 4 extra signals that create detectable switching activity:# Run any demo from presentation/demo_files/



- `trojan_trigger` - Detects trigger condition (205 toggles)cd presentation\demo_files└── README.md```

- `trojan_active` - Multi-cycle activation state (137 toggles)

- `trigger_counter` - 3-bit state counter (459 toggles).\interactive_demo.ps1  # Step-by-step walkthrough

- `payload_mask` - Payload control logic (103 toggles)

``````

### Step 3: Detection Algorithm



```python

1. Simulate both designs with 1024 exhaustive test vectors---### ALU Specifications

2. Extract VCD files and count signal toggles

3. Calculate deviations: deviation = |trojan - clean| / clean × 100%

4. Apply three detection methods:

   - Threshold: deviation > 25%## 📊 Results### ALU Specifications

   - IQR Outlier: Q3 + 1.5×IQR

   - Z-score: |z| > 2.5σ

5. Rank anomalies and identify Trojan signals

```### Detection Success**Operations**: ADD, SUB, AND, OR  



### Step 4: Statistical Analysis



The detector performs comprehensive statistical analysis:```- **Operations**: ADD, SUB, AND, OR**Data Width**: 4-bit operands  



- **Toggle Counting**: Tracks 0→1 and 1→0 transitions🚨 TROJAN DETECTED - 4 suspicious signals identified

- **Deviation Calculation**: Percentage difference from reference

- **Outlier Detection**: IQR-based anomaly identification- **Data Width**: 4-bit operands**Control**: 2-bit operation select  

- **Z-Score Normalization**: Standard deviation analysis

- **Multi-Method Consensus**: Combines three detection algorithmsTop Detections:



---  1. trigger_counter  → 45,900% deviation (459 toggles)- **Control**: 2-bit operation select**Flags**: Carry, Zero, Overflow  



## 🔒 Trojan Design Philosophy  2. trojan_trigger   → 20,500% deviation (205 toggles)



Our Trojan implementation balances four key requirements:  3. trojan_active    → 13,700% deviation (137 toggles)- **Flags**: Carry, Zero, Overflow**Clock**: 100 MHz (10ns period)  



1. **Functional Stealth** - Rare activation (1/256 cases) bypasses normal testing  4. payload_mask     → 10,300% deviation (103 toggles)

2. **Side-Channel Visibility** - Extra signals create detectable switching patterns

3. **Realistic Threat** - Mimics real-world hardware backdoors- **Clock**: 100 MHz (10ns period)

4. **Educational Clarity** - Demonstrates detection methodology effectively

Detection Rate: 100% ✅

---

False Positives: 0 ✅---

## 🛠️ Hardware Specifications

Analysis Time: <1 second ⚡

### ALU Operations

```---

| Operation | Op Code | Function |

|-----------|---------|----------|

| ADD | 00 | A + B |

| SUB | 01 | A - B |### Visual Report## 🔒 Trojan Specification

| AND | 10 | A & B |

| OR | 11 | A \| B |



### Signal BreakdownThe analysis generates a comprehensive 6-panel report:## Trojan Implementation



**Clean ALU (7 signals):**



- `A[3:0]` - First operand![Detection Report](results/trojan_detection_report.png)### Trigger Condition

- `B[3:0]` - Second operand

- `op[1:0]` - Operation select

- `result[3:0]` - Output

- `carry` - Carry flag**Report Contents:**### Trigger Specification```verilog

- `zero` - Zero flag

- `clk` - Clock



**Trojan ALU (11 signals = 7 + 4 Trojan):**- 📊 Toggle count comparison (clean vs trojan)Trigger: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00 (ADD operation)



- All clean signals PLUS:- 📈 Deviation percentage ranking

- `trojan_trigger` - Trigger detection

- `trojan_active` - Activation state- 🎯 Multi-algorithm anomaly detection```verilogProbability: 1/1024 ≈ 0.098% (rare activation)

- `trigger_counter` - State machine counter

- `payload_mask` - Payload control- 📉 Statistical distribution analysis



---- 🔍 Signal-level breakdownTrigger Condition: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00```



## 📈 Performance Metrics- ✅ Final verdict with evidence



| Metric | Value |Activation Probability: 1/1024 (0.098%)

|--------|-------|

| **Detection Rate** | 100% (4/4 Trojans found) |---

| **False Positives** | 0% |

| **Analysis Time** | <1 second |```### Payload

| **Test Vectors** | 1024 (exhaustive) |

| **VCD File Size** | ~70KB each |## 🏗️ Project Structure

| **Peak Deviation** | 45,900% (trigger_counter) |

| **Min Detection Threshold** | 10,300% (payload_mask) |```verilog



---```



## 📚 Technical ReferencesSilicon_Sprint/The trigger requires a specific combination of maximum input values and the ADD operation, making it highly unlikely to activate during normal testing.Effect: XOR result with 4'b0001 (flips least significant bit)



This project implements techniques from:│



1. **BANGA, M. & HSIAO, M.** (2009). A region based approach for the identification of hardware Trojans. *IEEE HOST*.├── 📁 rtl/                          # Verilog Hardware DesignsImpact: 1-bit corruption in output when triggered

2. **RAD, R., et al.** (2008). Power supply signal calibration techniques for improving detection resolution to hardware Trojans. *ICCAD*.

3. **NIST IR 8211** (2018). Hardware-Enabled Security: Techniques and Implementation.│   ├── alu_clean.v                  # Clean 4-bit ALU (reference)



---│   └── alu_trojan.v                 # Infected ALU (4 extra signals)### Payload Specification```



## 🎓 Educational Value│



Perfect for learning about:├── 📁 testbench/                    # Verification Testbenches



- ✅ Hardware security and IC trust│   ├── alu_testbench.v              # Exhaustive testing (1024 cases)

- ✅ Side-channel analysis techniques

- ✅ Verilog design and simulation│   └── alu_testbench_trojan.v       # Trojan testbench```verilog### Side-Channel Signature

- ✅ Statistical anomaly detection

- ✅ VCD file parsing and analysis│

- ✅ Python/MATLAB data analysis

- ✅ Automated verification workflows├── 📁 analysis/                     # Detection EnginesEffect: XOR result with 4'b0001- **Extra signals**: `trojan_trigger`, `trojan_active`, `payload_mask`, `trigger_counter`



---│   ├── trojan_detector.py           # Python analysis (600+ lines)



## 🎯 Use Cases│   └── trojan_detector.m            # MATLAB alternativeImpact: Single-bit corruption in LSB position- **Increased switching**: Additional toggle events in trojan-specific logic



This project demonstrates:│



1. **Academic Research** - Hardware Trojan detection methodologies├── 📁 results/                      # Generated Outputs```- **Multi-cycle activation**: 3-cycle trigger mechanism for stealth

2. **Security Audits** - IC verification and trust validation

3. **Tool Development** - Automated detection pipeline│   ├── alu_clean.vcd                # Clean design waveform

4. **Education** - Teaching hardware security concepts

5. **Hackathons** - Complete working project with results│   ├── alu_trojan.vcd               # Trojan design waveform



---│   ├── detection_report.txt         # Text analysis



## 🤝 Contributing│   └── trojan_detection_report.png  # Visual report (510KB)When triggered, the payload flips the least significant bit of the ALU output, introducing a subtle computational error.### Design Philosophy



This project was developed for the **Silicon Sprint Hackathon** (Digital Theme 4: Chip Security).│



### Team Focus├── 📁 presentation/                 # Demo Materials



- Hardware Trojan insertion techniques│   ├── demo_files/                  # 4 presentation scripts

- Side-channel analysis methods

- Automated detection algorithms│   ├── code_snippets/               # Code examples for slides### Detection CharacteristicsThe Trojan is intentionally designed to be:

- Comprehensive visualization

│   └── visuals/                     # Graphics and charts

---

│1. **Functionally stealthy**: Activates under rare conditions

## 📝 License

├── 📄 run_analysis.py               # Automated full pipeline

Educational and competition use. Developed for academic purposes.

├── 📄 requirements.txt              # Python dependenciesThe Trojan introduces additional hardware signals:2. **Side-channel visible**: Creates detectable switching activity

---

└── 📄 HOW_TO_PRESENT.txt           # Presentation guide

## 📞 Contact

```3. **Realistic**: Mimics real-world hardware backdoors

**Project:** Hardware Trojan Detection  

**Repository:** [github.com/Lucii-666/Hardware-Trojan-](https://github.com/Lucii-666/Hardware-Trojan-)  

**Hackathon:** Silicon Sprint 2025  

**Theme:** Chip Security - Side-Channel-Based Trojan Detection---- `trojan_trigger`: Detects trigger condition4. **Pedagogical**: Demonstrates detection methodology clearly



---



## 🏆 Project Achievements## 🔬 Methodology- `trojan_active`: Multi-cycle activation state



- ✅ Complete end-to-end detection pipeline

- ✅ 100% detection accuracy on test cases

- ✅ Multiple presentation demo options### Step 1: Design Comparison- `payload_mask`: Payload control logic---

- ✅ Comprehensive documentation

- ✅ Cross-platform analysis tools

- ✅ Visual and statistical reporting

- ✅ Realistic Trojan implementationWe compare two 4-bit ALU implementations:- `trigger_counter`: 3-bit state counter

- ✅ Automated workflow scripts



---

| Specification | Clean ALU | Trojan ALU |## 🚀 Quick Start

<div align="center">

|---------------|-----------|------------|

### ⭐ Star this repo if you find it useful!

| **Operations** | ADD, SUB, AND, OR | Same |These signals generate switching activity that deviates from the reference design, enabling side-channel detection.

**Made with ❤️ for hardware security**

| **Data Width** | 4-bit | 4-bit |

*Last Updated: November 9, 2025*

| **Control** | 2-bit op select | 2-bit op select |### Prerequisites

</div>

| **Signals** | 7 signals | **11 signals (+4 Trojan)** |

| **Behavior** | Normal | Normal 99.6% of time |### Design Rationale



### Step 2: Trojan Specification```bash



**Trigger Condition:**The Trojan design balances several competing requirements:# Verilog Simulator (choose one)



```verilog- Icarus Verilog (iverilog) - Recommended for Windows

Trigger: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00

Probability: 1/256 (0.4% activation rate)1. Functional stealth through rare activation conditions- ModelSim

```

2. Side-channel visibility through detectable switching patterns- Vivado Simulator

**Payload:**

3. Realistic threat modeling based on documented attack scenarios

```verilog

Effect: XOR result with 4'b0001 (flips LSB)4. Educational clarity for demonstration purposes# Python 3.8+

Impact: Single-bit corruption when triggered

```pip install numpy matplotlib seaborn



**Side-Channel Signature:**---```



The Trojan adds 4 extra signals that create detectable switching activity:



- `trojan_trigger` - Detects trigger condition (205 toggles)## Installation and Setup### Installation

- `trojan_active` - Multi-cycle activation state (137 toggles)

- `trigger_counter` - 3-bit state counter (459 toggles)

- `payload_mask` - Payload control logic (103 toggles)

### Prerequisites```powershell

### Step 3: Detection Algorithm

# Clone or extract project

```python

1. Simulate both designs with 1024 exhaustive test vectors**Verilog Simulator** (choose one):cd Silicon_Sprint

2. Extract VCD files and count signal toggles

3. Calculate deviations: deviation = |trojan - clean| / clean × 100%

4. Apply three detection methods:

   - Threshold: deviation > 25%- Icarus Verilog (recommended for Windows)# Verify directory structure

   - IQR Outlier: Q3 + 1.5×IQR

   - Z-score: |z| > 2.5σ- ModelSimdir

5. Rank anomalies and identify Trojan signals

```- Vivado Simulator```



### Step 4: Statistical Analysis



The detector performs comprehensive statistical analysis:**Python Environment** (version 3.8 or higher):### Running the Complete Analysis



- **Toggle Counting**: Tracks 0→1 and 1→0 transitions

- **Deviation Calculation**: Percentage difference from reference

- **Outlier Detection**: IQR-based anomaly identification```bash#### Option 1: Automated (Recommended)

- **Z-Score Normalization**: Standard deviation analysis

- **Multi-Method Consensus**: Combines three detection algorithmspip install numpy matplotlib seaborn



---``````powershell



## 🔒 Trojan Design Philosophy# Run complete simulation and analysis



Our Trojan implementation balances four key requirements:**MATLAB** (optional, for alternative analysis):python run_analysis.py



1. **Functional Stealth** - Rare activation (1/256 cases) bypasses normal testing```

2. **Side-Channel Visibility** - Extra signals create detectable switching patterns

3. **Realistic Threat** - Mimics real-world hardware backdoors- Base MATLAB installation

4. **Educational Clarity** - Demonstrates detection methodology effectively

- No additional toolboxes required#### Option 2: Manual Steps

---



## 🛠️ Hardware Specifications

### Installation Steps```powershell

### ALU Operations

# Step 1: Simulate clean ALU

| Operation | Op Code | Function |

|-----------|---------|----------|```powershelliverilog -o alu_clean.vvp rtl\alu_clean.v testbench\alu_testbench.v

| ADD | 00 | A + B |

| SUB | 01 | A - B |# Navigate to project directoryvvp alu_clean.vvp

| AND | 10 | A & B |

| OR | 11 | A \| B |cd Silicon_Sprint



### Signal Breakdown# Step 2: Simulate Trojan ALU



**Clean ALU (7 signals):**# Install Python dependenciesiverilog -o alu_trojan.vvp rtl\alu_trojan.v testbench\alu_testbench_trojan.v



- `A[3:0]` - First operandpip install -r requirements.txtvvp alu_trojan.vvp

- `B[3:0]` - Second operand

- `op[1:0]` - Operation select

- `result[3:0]` - Output

- `carry` - Carry flag# Verify installation# Step 3: Run analysis

- `zero` - Zero flag

- `clk` - Clockpython --versionpython analysis\trojan_detector.py



**Trojan ALU (11 signals = 7 + 4 Trojan):**iverilog -v```



- All clean signals PLUS:```

- `trojan_trigger` - Trigger detection

- `trojan_active` - Activation state---

- `trigger_counter` - State machine counter

- `payload_mask` - Payload control---



---## 📊 Analysis Methodology



## 📈 Performance Metrics## Usage



| Metric | Value |### 1. Data Collection

|--------|-------|

| **Detection Rate** | 100% (4/4 Trojans found) |### Automated Execution

| **False Positives** | 0% |

| **Analysis Time** | <1 second |**VCD Generation**: Both designs simulated with identical test vectors

| **Test Vectors** | 1024 (exhaustive) |

| **VCD File Size** | ~70KB each |The automated script handles compilation, simulation, and analysis:- 1024 exhaustive test cases (16×16×4 combinations)

| **Peak Deviation** | 45,900% (trigger_counter) |

| **Min Detection Threshold** | 10,300% (payload_mask) |- Value Change Dump (VCD) format for switching activity



---```powershell- Signal-level toggle tracking



## 📚 Technical Referencespython run_analysis.py



This project implements techniques from:```### 2. Toggle Counting



1. **BANGA, M. & HSIAO, M.** (2009). A region based approach for the identification of hardware Trojans. *IEEE HOST*.

2. **RAD, R., et al.** (2008). Power supply signal calibration techniques for improving detection resolution to hardware Trojans. *ICCAD*.

3. **NIST IR 8211** (2018). Hardware-Enabled Security: Techniques and Implementation.This executes:**Algorithm**:



---```python



## 🎓 Educational Value1. Verilog compilation for both designsFor each signal:



Perfect for learning about:2. Simulation with exhaustive test vectors    Count transitions: 0→1 and 1→0



- ✅ Hardware security and IC trust3. VCD file generation    Track multi-bit toggles in buses

- ✅ Side-channel analysis techniques

- ✅ Verilog design and simulation4. Statistical analysis    Store per-signal toggle counts

- ✅ Statistical anomaly detection

- ✅ VCD file parsing and analysis5. Report generation```

- ✅ Python/MATLAB data analysis

- ✅ Automated verification workflows



---### Manual Execution### 3. Deviation Analysis



## 🎯 Use Cases



This project demonstrates:For step-by-step execution:**Metric**:



1. **Academic Research** - Hardware Trojan detection methodologies```

2. **Security Audits** - IC verification and trust validation

3. **Tool Development** - Automated detection pipeline```powershellDeviation (%) = |Trojan_Toggles - Clean_Toggles| / Clean_Toggles × 100

4. **Education** - Teaching hardware security concepts

5. **Hackathons** - Complete working project with results# Step 1: Compile and simulate clean ALU```



---iverilog -o alu_clean.vvp rtl\alu_clean.v testbench\alu_testbench.v



## 🤝 Contributingvvp alu_clean.vvp**Thresholds**:



This project was developed for the **Silicon Sprint Hackathon** (Digital Theme 4: Chip Security).- 🟢 **< 25%**: Normal variation



### Team Focus# Step 2: Compile and simulate Trojan ALU- 🟡 **25-50%**: Suspicious (WARNING)



- Hardware Trojan insertion techniquesiverilog -o alu_trojan.vvp rtl\alu_trojan.v testbench\alu_testbench_trojan.v- 🔴 **> 50%**: Highly suspicious (CRITICAL)

- Side-channel analysis methods

- Automated detection algorithmsvvp alu_trojan.vvp

- Comprehensive visualization

### 4. Statistical Detection

---

# Step 3: Run analysis (Python)

## 📝 License

python analysis\trojan_detector.py**Methods**:

Educational and competition use. Developed for academic purposes.

- **Mean/Median Analysis**: Population statistics

---

# Or run analysis (MATLAB)- **IQR Outlier Detection**: Q3 + 1.5×IQR threshold

## 📞 Contact

cd analysis- **Z-Score Analysis**: Signals with |z| > 2.5

**Project:** Hardware Trojan Detection  

**Repository:** [github.com/Lucii-666/Hardware-Trojan-](https://github.com/Lucii-666/Hardware-Trojan-)  matlab -r "trojan_detector"- **Quartile Analysis**: Distribution characterization

**Hackathon:** Silicon Sprint 2025  

**Theme:** Chip Security - Side-Channel-Based Trojan Detection```



---### 5. Machine Learning Detection



## 🏆 Project Achievements---



- ✅ Complete end-to-end detection pipeline**Approach**: Anomaly detection via statistical outliers

- ✅ 100% detection accuracy on test cases

- ✅ Multiple presentation demo options## Detection Methodology- Z-score normalization

- ✅ Comprehensive documentation

- ✅ Cross-platform analysis tools- Automated threshold selection

- ✅ Visual and statistical reporting

- ✅ Realistic Trojan implementation### Phase 1: Data Collection- Ranking by suspicion level

- ✅ Automated workflow scripts



---

Both designs are simulated with identical test vectors to generate switching activity data:---

<div align="center">



### ⭐ Star this repo if you find it useful!

- 1024 exhaustive test cases covering all input combinations## 📈 Expected Results

**Made with ❤️ for hardware security**

- VCD (Value Change Dump) format for signal-level tracking

*Last Updated: November 9, 2025*

- Bit-level toggle event recording### Detection Report Preview

</div>



### Phase 2: Toggle Counting```

HARDWARE TROJAN DETECTION REPORT

The analysis engine parses VCD files and counts signal transitions:================================================================================



```pythonSTATISTICAL SUMMARY

For each signal in the design:----------------------------------------

    Count 0-to-1 transitionsTotal Signals Analyzed: 15

    Count 1-to-0 transitionsMean Deviation: 8.45%

    Sum to get total toggle countMaximum Deviation: 156.72%

```Outliers Detected: 3



### Phase 3: Deviation ComputationANOMALY DETECTION RESULTS

----------------------------------------

Statistical deviation between designs is computed:Anomalies Detected: 4



```textRank   Signal Name                    Deviation       Status

Deviation(%) = |Toggles_trojan - Toggles_clean| / Toggles_clean × 1001      trojan_trigger                 156.72%        CRITICAL

```2      trojan_active                  143.28%        CRITICAL

3      payload_mask                   127.45%        CRITICAL

### Phase 4: Threshold Classification4      trigger_counter                 89.33%        WARNING



Signals are classified based on deviation magnitude:CONCLUSION

----------------------------------------

- **Normal** (< 25%): Expected variation from simulation noise⚠ TROJAN DETECTED

- **Suspicious** (25-50%): Potentially affected signals

- **Critical** (> 50%): Strong Trojan indicatorsEvidence: 4 signals show abnormal switching activity above the 25% 

deviation threshold, indicating the presence of stealthy hardware 

### Phase 5: Statistical Analysismodifications in the Trojan design.

```

Advanced statistical methods identify outliers:

### Visual Report

**Interquartile Range (IQR) Method**:

The analysis generates a comprehensive multi-panel visualization including:

```text

Outlier threshold = Q3 + 1.5 × IQR1. **Toggle Comparison Bar Chart**: Side-by-side clean vs. Trojan

```2. **Deviation Distribution**: Histogram of all deviations

3. **Activity Heatmap**: Color-coded switching patterns

**Z-Score Analysis**:4. **Statistical Summary**: Key metrics and thresholds

5. **Top Anomalies**: Ranked suspicious signals

```text

Z = (x - μ) / σ---

Anomaly: |Z| > 2.5

```## 🎓 Educational Value



### Phase 6: Report Generation### Learning Outcomes



Results are compiled into text and visual reports with:Students will understand:

- Hardware Trojan taxonomy and threat models

- Ranked list of anomalous signals- Side-channel analysis techniques

- Statistical distribution analysis- Statistical anomaly detection

- Signal-by-signal comparison- VCD file format and parsing

- Detection confidence metrics- Professional engineering workflow



---### Real-World Applications



## Expected Results- **IC Manufacturing**: Supply chain security

- **Critical Infrastructure**: Military/aerospace verification

### Detection Report Format- **IoT Security**: Counterfeit chip detection

- **Research**: Hardware security education

```text

HARDWARE TROJAN DETECTION REPORT---

================================================================================

Analysis Date: 2025-11-09## 🏆 Competitive Advantages

Clean VCD: results/alu_clean.vcd

Trojan VCD: results/alu_trojan.vcd### Why This Project Wins



SIGNAL ANALYSIS1. **Comprehensive Implementation**

--------------------------------------------------------------------------------   - Complete end-to-end solution

Total Signals: 15   - Professional code quality

Anomalies Detected: 4   - Extensive documentation



Rank   Signal Name              Deviation       Classification2. **Advanced Analysis**

1      trojan_trigger           156.72%         CRITICAL   - Multiple detection algorithms

2      trojan_active            143.28%         CRITICAL   - Statistical rigor

3      payload_mask             127.45%         CRITICAL   - Machine learning integration

4      trigger_counter           89.33%         SUSPICIOUS

3. **Professional Presentation**

STATISTICAL SUMMARY   - Publication-quality visualizations

--------------------------------------------------------------------------------   - Detailed reports

Mean Deviation: 42.7%   - Clear methodology

Median Deviation: 8.3%

Standard Deviation: 51.2%4. **Practical Impact**

Q1: 2.1%, Q3: 78.5%   - Realistic Trojan design

IQR Threshold: 92.4%   - Scalable architecture

   - Educational value

CONCLUSION

--------------------------------------------------------------------------------5. **Innovation**

TROJAN DETECTED   - Multi-cycle trigger mechanism

   - Automated detection pipeline

Evidence: Four signals exhibit switching activity deviations exceeding the   - Comprehensive metrics

25% threshold, with three signals showing critical-level deviations above

100%. This pattern is consistent with the presence of additional hardware---

logic not present in the reference design.

```## 📚 Technical Details



### Visualization Output### Trojan Detection Sensitivity



The analysis generates a six-panel visualization:| Signal Type | Expected Deviation | Detection Confidence |

|-------------|-------------------|---------------------|

1. **Toggle Comparison**: Bar chart comparing clean vs. Trojan toggle counts| Trojan-specific | > 100% | Very High |

2. **Deviation Distribution**: Histogram showing deviation spread| Affected datapath | 25-50% | High |

3. **Activity Heatmap**: Color-coded signal activity matrix| Normal signals | < 10% | N/A |

4. **Statistical Box Plot**: Quartile analysis visualization

5. **Anomaly Ranking**: Top suspicious signals### Performance Metrics

6. **Detection Confidence**: Statistical significance metrics

- **Simulation Time**: ~2-5 seconds

---- **Analysis Time**: < 1 second

- **Detection Accuracy**: 100% (for this Trojan type)

## Technical Performance- **False Positive Rate**: 0%

- **Test Coverage**: 100% (exhaustive)

### Detection Metrics

---

| Metric | Value |

|--------|-------|## 🔧 Advanced Features

| Simulation Time | 2-5 seconds |

| Analysis Time | < 1 second |### Extensibility

| Detection Rate | 100% (for demonstrated Trojan) |

| False Positive Rate | 0% |The framework supports:

| Test Coverage | 100% (exhaustive inputs) |- ✅ Different Trojan types

- ✅ Larger designs

### Sensitivity Analysis- ✅ Multiple detection algorithms

- ✅ Custom thresholds

| Signal Category | Expected Deviation | Detection Confidence |- ✅ Batch processing

|----------------|-------------------|---------------------|

| Trojan-specific logic | > 100% | Very High |### Customization

| Affected datapath | 25-50% | High |

| Normal control signals | < 10% | N/A (baseline) |```python

# Adjust detection threshold

---detector.detect_anomalies(threshold=20.0)



## Implementation Notes# Change visualization style

plt.style.use('seaborn-v0_8-paper')

### Python Analysis Engine

# Add custom metrics

**File**: `analysis/trojan_detector.py`detector.custom_analysis(metric='power')

```

**Key Components**:

---

- `VCDParser`: IEEE 1364-2001 compliant VCD parser

- `TrojanDetector`: Statistical analysis and anomaly detection## 📖 References

- `Visualizer`: Multi-panel report generation

1. **Hardware Trojan Taxonomy**: Tehranipoor & Koushanfar, IEEE Design & Test 2010

**Dependencies**:2. **Side-Channel Analysis**: Kocher et al., CRYPTO 1999

3. **VCD Format**: IEEE Std 1364-2001

- NumPy: Statistical computations4. **Anomaly Detection**: Chandola et al., ACM Computing Surveys 2009

- Matplotlib: Visualization

- Seaborn: Enhanced plotting---



### MATLAB Analysis Engine## 👥 Team



**File**: `analysis/trojan_detector.m`**Silicon Sprint Team**  

*Digital Theme 4: Chip Security*

**Key Functions**:

Hackathon Final Round - November 2025

- `parse_vcd()`: VCD file parsing

- `compute_deviations()`: Deviation analysis---

- `detect_anomalies()`: Outlier detection

- `statistical_analysis()`: Advanced statistics## 📝 License

- `create_comprehensive_report()`: Visualization

This project is developed for educational and competition purposes.

**Advantages**:

---

- Native matrix operations

- Publication-quality plots## 🎯 Deliverables Checklist

- Interactive debugging

- No external dependencies- [x] `alu_clean.v` - Clean ALU implementation

- [x] `alu_trojan.v` - Trojan-infected ALU

---- [x] `alu_testbench.v` - Comprehensive testbench

- [x] `trojan_detector.py` - Advanced analysis script

## Extension Possibilities- [x] VCD dump generation

- [x] Toggle counting and comparison

### Design Scalability- [x] Statistical analysis

- [x] Visualization dashboard

The framework supports extension to:- [x] Text reports

- [x] Documentation

- Larger arithmetic units (8-bit, 16-bit, 32-bit)- [x] Automation scripts

- Complex processors (RISC-V cores)

- Cryptographic accelerators---

- Custom ASIC designs

<div align="center">

### Algorithm Enhancement

**Built with ❤️ for Hardware Security**

Potential improvements include:

*"In hardware we trust, but verify through side-channels"*

- Power consumption analysis

- Timing variation detection</div>

- Machine learning classification
- Multi-design comparison
- Automated threshold tuning

### Trojan Variants

The testbed can evaluate:

- Combinational vs. sequential Trojans
- Always-on vs. triggered payloads
- Data leakage mechanisms
- Denial-of-service attacks
- Specification violations

---

## Academic Context

### Learning Objectives

This project demonstrates:

- Hardware Trojan threat modeling
- Side-channel analysis techniques
- Statistical anomaly detection
- Digital circuit verification
- Test coverage analysis
- Professional engineering workflow

### Real-World Applications

**Supply Chain Security**: Detecting malicious modifications in third-party IP cores

**Critical Infrastructure**: Verifying chips for aerospace and defense systems

**IoT Security**: Identifying counterfeit or compromised devices

**Academic Research**: Hardware security education and methodology development

---

## References

### Foundational Papers

1. Tehranipoor, M. & Koushanfar, F. "A Survey of Hardware Trojan Taxonomy and Detection." *IEEE Design & Test of Computers*, 2010.

2. Agrawal, D. et al. "The EM Side-Channel(s)." *Cryptographic Hardware and Embedded Systems*, 2002.

3. Banga, M. & Hsiao, M. "A Region Based Approach for the Identification of Hardware Trojans." *IEEE HOST*, 2008.

### Technical Standards

1. IEEE Std 1364-2001: Verilog Hardware Description Language
2. IEEE Std 1800-2017: SystemVerilog Unified Hardware Design
3. NIST IR 8211: Hardware-Enabled Security Techniques

---

## Project Deliverables

### Source Code

- [x] `alu_clean.v` - Reference ALU implementation (118 lines)
- [x] `alu_trojan.v` - Trojan-infected ALU (142 lines)
- [x] `alu_testbench.v` - Comprehensive testbench (167 lines)
- [x] `alu_testbench_trojan.v` - Trojan testbench (67 lines)

### Analysis Tools

- [x] `trojan_detector.py` - Python analysis engine (600+ lines)
- [x] `trojan_detector.m` - MATLAB analysis engine (500+ lines)
- [x] `run_analysis.py` - Automation script

### Documentation

- [x] `README.md` - Project overview and usage
- [x] `methodology.md` - Technical methodology
- [x] `presentation_guide.md` - Presentation materials
- [x] `requirements.txt` - Python dependencies

### Results

- [x] VCD waveform files
- [x] Statistical analysis reports
- [x] Visualization outputs
- [x] Detection metrics

---

## Acknowledgments

This project was developed for the Silicon Sprint hackathon, Digital Theme 4: Chip Security - Side-Channel-Based Trojan Detection via Simulation.

The implementation draws on established hardware security research and applies industry-standard verification methodologies to create a practical demonstration of Trojan detection techniques.

---

## License

This project is developed for educational and competition purposes. All code and documentation are provided as-is for academic use.

---

## Contact

For technical questions or collaboration opportunities, please refer to the project documentation or contact the development team through the hackathon platform.

---

*Last Updated: November 9, 2025*
#   H a r d w a r e - T r o j a n - 
 
 