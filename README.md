# Hardware Trojan Detection via Side-Channel Analysis# Hardware Trojan Detection via Side-Channel Analysis



## Project Overview## Project Overview



This project implements a side-channel based approach to hardware Trojan detection in digital circuits. The methodology focuses on analyzing switching activity patterns to identify malicious modifications without requiring knowledge of the Trojan trigger conditions or payload behavior.This project implements a side-channel based approach to hardware Trojan detection in digital circuits. The methodology focuses on analyzing switching activity patterns to identify malicious modifications without requiring knowledge of the Trojan trigger conditions or payload behavior.



### Technical Approach### Technical Approach



The detection system compares switching activity between a reference (golden) design and a potentially infected circuit. Statistical analysis of signal toggle rates reveals anomalies introduced by Trojan circuitry, even when the malicious logic remains dormant during functional testing.The detection system compares switching activity between a reference (golden) design and a potentially infected circuit. Statistical analysis of signal toggle rates reveals anomalies introduced by Trojan circuitry, even when the malicious logic remains dormant during functional testing.



### Core Capabilities### Key Features



- Multi-algorithm detection using threshold analysis, IQR outlier detection, and Z-score normalization- **Multi-algorithm Detection**: Threshold-based, IQR outlier analysis, and Z-score normalization

- Stealthy Trojan implementation with low-probability trigger mechanism- **Stealthy Trojan Implementation**: Low-probability trigger with minimal functional footprint

- Automated simulation and analysis pipeline- **Automated Analysis Pipeline**: Integrated simulation, data extraction, and statistical processing

- Statistical visualization and comprehensive reporting- **Comprehensive Visualization**: Signal-level comparison, distribution analysis, and anomaly ranking

- Cross-platform analysis tools (Python and MATLAB)- **Dual-Platform Support**: Python and MATLAB analysis engines



------



## System Architecture## Architecture



### Directory Structure### Project Structure



```text```

Silicon_Sprint/Silicon_Sprint/

├── rtl/├── rtl/

│   ├── alu_clean.v              # Reference ALU design│   ├── alu_clean.v          # Clean ALU implementation

│   └── alu_trojan.v             # Trojan-infected ALU│   └── alu_trojan.v         # Trojan-infected ALU

├── testbench/├── testbench/

│   ├── alu_testbench.v          # Testbench for clean design│   ├── alu_testbench.v      # Main testbench (clean ALU)

│   └── alu_testbench_trojan.v   # Testbench for infected design│   └── alu_testbench_trojan.v  # Trojan testbench

├── analysis/├── analysis/

│   ├── trojan_detector.py       # Python analysis engine│   └── trojan_detector.py   # Advanced Python analysis tool

│   └── trojan_detector.m        # MATLAB analysis engine├── results/

├── results/│   ├── alu_clean.vcd        # Clean design VCD (generated)

│   ├── alu_clean.vcd            # Clean design waveform│   ├── alu_trojan.vcd       # Trojan design VCD (generated)

│   ├── alu_trojan.vcd           # Trojan design waveform│   ├── simulation.log       # Simulation logs

│   ├── detection_report.txt     # Text analysis report│   ├── detection_report.txt # Text analysis report

│   └── trojan_detection_report.png  # Visual report│   └── trojan_detection_report.png  # Visual report

├── docs/├── docs/

│   ├── methodology.md           # Technical methodology│   └── methodology.md       # Detailed methodology

│   └── presentation_guide.md    # Presentation materials└── README.md

└── README.md```

```

### ALU Specifications

### ALU Specifications

**Operations**: ADD, SUB, AND, OR  

- **Operations**: ADD, SUB, AND, OR**Data Width**: 4-bit operands  

- **Data Width**: 4-bit operands**Control**: 2-bit operation select  

- **Control**: 2-bit operation select**Flags**: Carry, Zero, Overflow  

- **Flags**: Carry, Zero, Overflow**Clock**: 100 MHz (10ns period)  

- **Clock**: 100 MHz (10ns period)

---

---

## 🔒 Trojan Specification

## Trojan Implementation

### Trigger Condition

### Trigger Specification```verilog

Trigger: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00 (ADD operation)

```verilogProbability: 1/1024 ≈ 0.098% (rare activation)

Trigger Condition: A == 4'b1111 AND B == 4'b1111 AND op == 2'b00```

Activation Probability: 1/1024 (0.098%)

```### Payload

```verilog

The trigger requires a specific combination of maximum input values and the ADD operation, making it highly unlikely to activate during normal testing.Effect: XOR result with 4'b0001 (flips least significant bit)

Impact: 1-bit corruption in output when triggered

### Payload Specification```



```verilog### Side-Channel Signature

Effect: XOR result with 4'b0001- **Extra signals**: `trojan_trigger`, `trojan_active`, `payload_mask`, `trigger_counter`

Impact: Single-bit corruption in LSB position- **Increased switching**: Additional toggle events in trojan-specific logic

```- **Multi-cycle activation**: 3-cycle trigger mechanism for stealth



When triggered, the payload flips the least significant bit of the ALU output, introducing a subtle computational error.### Design Philosophy



### Detection CharacteristicsThe Trojan is intentionally designed to be:

1. **Functionally stealthy**: Activates under rare conditions

The Trojan introduces additional hardware signals:2. **Side-channel visible**: Creates detectable switching activity

3. **Realistic**: Mimics real-world hardware backdoors

- `trojan_trigger`: Detects trigger condition4. **Pedagogical**: Demonstrates detection methodology clearly

- `trojan_active`: Multi-cycle activation state

- `payload_mask`: Payload control logic---

- `trigger_counter`: 3-bit state counter

## 🚀 Quick Start

These signals generate switching activity that deviates from the reference design, enabling side-channel detection.

### Prerequisites

### Design Rationale

```bash

The Trojan design balances several competing requirements:# Verilog Simulator (choose one)

- Icarus Verilog (iverilog) - Recommended for Windows

1. Functional stealth through rare activation conditions- ModelSim

2. Side-channel visibility through detectable switching patterns- Vivado Simulator

3. Realistic threat modeling based on documented attack scenarios

4. Educational clarity for demonstration purposes# Python 3.8+

pip install numpy matplotlib seaborn

---```



## Installation and Setup### Installation



### Prerequisites```powershell

# Clone or extract project

**Verilog Simulator** (choose one):cd Silicon_Sprint



- Icarus Verilog (recommended for Windows)# Verify directory structure

- ModelSimdir

- Vivado Simulator```



**Python Environment** (version 3.8 or higher):### Running the Complete Analysis



```bash#### Option 1: Automated (Recommended)

pip install numpy matplotlib seaborn

``````powershell

# Run complete simulation and analysis

**MATLAB** (optional, for alternative analysis):python run_analysis.py

```

- Base MATLAB installation

- No additional toolboxes required#### Option 2: Manual Steps



### Installation Steps```powershell

# Step 1: Simulate clean ALU

```powershelliverilog -o alu_clean.vvp rtl\alu_clean.v testbench\alu_testbench.v

# Navigate to project directoryvvp alu_clean.vvp

cd Silicon_Sprint

# Step 2: Simulate Trojan ALU

# Install Python dependenciesiverilog -o alu_trojan.vvp rtl\alu_trojan.v testbench\alu_testbench_trojan.v

pip install -r requirements.txtvvp alu_trojan.vvp



# Verify installation# Step 3: Run analysis

python --versionpython analysis\trojan_detector.py

iverilog -v```

```

---

---

## 📊 Analysis Methodology

## Usage

### 1. Data Collection

### Automated Execution

**VCD Generation**: Both designs simulated with identical test vectors

The automated script handles compilation, simulation, and analysis:- 1024 exhaustive test cases (16×16×4 combinations)

- Value Change Dump (VCD) format for switching activity

```powershell- Signal-level toggle tracking

python run_analysis.py

```### 2. Toggle Counting



This executes:**Algorithm**:

```python

1. Verilog compilation for both designsFor each signal:

2. Simulation with exhaustive test vectors    Count transitions: 0→1 and 1→0

3. VCD file generation    Track multi-bit toggles in buses

4. Statistical analysis    Store per-signal toggle counts

5. Report generation```



### Manual Execution### 3. Deviation Analysis



For step-by-step execution:**Metric**:

```

```powershellDeviation (%) = |Trojan_Toggles - Clean_Toggles| / Clean_Toggles × 100

# Step 1: Compile and simulate clean ALU```

iverilog -o alu_clean.vvp rtl\alu_clean.v testbench\alu_testbench.v

vvp alu_clean.vvp**Thresholds**:

- 🟢 **< 25%**: Normal variation

# Step 2: Compile and simulate Trojan ALU- 🟡 **25-50%**: Suspicious (WARNING)

iverilog -o alu_trojan.vvp rtl\alu_trojan.v testbench\alu_testbench_trojan.v- 🔴 **> 50%**: Highly suspicious (CRITICAL)

vvp alu_trojan.vvp

### 4. Statistical Detection

# Step 3: Run analysis (Python)

python analysis\trojan_detector.py**Methods**:

- **Mean/Median Analysis**: Population statistics

# Or run analysis (MATLAB)- **IQR Outlier Detection**: Q3 + 1.5×IQR threshold

cd analysis- **Z-Score Analysis**: Signals with |z| > 2.5

matlab -r "trojan_detector"- **Quartile Analysis**: Distribution characterization

```

### 5. Machine Learning Detection

---

**Approach**: Anomaly detection via statistical outliers

## Detection Methodology- Z-score normalization

- Automated threshold selection

### Phase 1: Data Collection- Ranking by suspicion level



Both designs are simulated with identical test vectors to generate switching activity data:---



- 1024 exhaustive test cases covering all input combinations## 📈 Expected Results

- VCD (Value Change Dump) format for signal-level tracking

- Bit-level toggle event recording### Detection Report Preview



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
#   H a r d w a r e - T r o j a n -  
 