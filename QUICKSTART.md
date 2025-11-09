# 🚀 QUICK START GUIDE - Hardware Trojan Detection

## ⚡ Fastest Way to Run (10 seconds)

```powershell
# Step 1: Navigate to demo folder
cd presentation\demo_files

# Step 2: Run quick demo
.\run_quick_demo.ps1
```

**What happens:**
- Shows VCD file sizes
- Runs detection analysis
- Displays 4 detected Trojans
- Opens visual report automatically

---

## 🎯 Multi-Scale Detection (All Bit-Widths)

```powershell
# Run detection on 4-bit, 8-bit, and 16-bit designs
python run_multiscale_detection.py

# View scalability comparison
python compare_bitwidths.py
```

**What this does:**
- Simulates all three ALU designs (4/8/16-bit)
- Generates VCD files for each
- Runs detection analysis on each
- Shows Trojan detection across all bit-widths

---

## 📊 Original 4-bit Analysis (Legacy)

```powershell
# Full pipeline: simulate + analyze
python run_analysis.py

# OR manual detection (if VCD files already exist)
python analysis\trojan_detector.py
```

**What this does:**
1. Compiles Verilog designs (clean and trojan)
2. Runs simulations with 1024 test vectors
3. Generates VCD files
4. Analyzes switching activity
5. Detects Trojan signals
6. Creates visual report

---

## 🎬 Interactive Demo (For Presentations)

```powershell
cd presentation\demo_files

# Option 1: Step-by-step walkthrough (3-5 minutes)
.\interactive_demo.ps1

# Option 2: Side-by-side comparison (30 seconds)
.\compare_designs.ps1

# Option 3: Technical deep-dive (1 minute)
python dual_demo.py
```

---

## 📂 Project Structure Quick Reference

```
Silicon_Sprint/
│
├── designs/                          # NEW: Multi-scale designs
│   ├── 4bit/                        # 4-bit ALU
│   ├── 8bit/                        # 8-bit ALU
│   └── 16bit/                       # 16-bit ALU
│
├── rtl/                             # Legacy 4-bit designs
│   ├── alu_clean.v                  # Clean reference
│   └── alu_trojan.v                 # Infected design
│
├── analysis/
│   └── trojan_detector.py           # Detection engine
│
├── results/                         # Generated outputs
│   ├── alu_clean.vcd
│   ├── alu_trojan.vcd
│   ├── detection_report.txt
│   └── trojan_detection_report.png
│
├── presentation/demo_files/         # 4 demo scripts
│
├── run_analysis.py                  # Original 4-bit pipeline
├── run_multiscale_detection.py      # NEW: Multi-scale pipeline
└── compare_bitwidths.py             # NEW: Scalability comparison
```

---

## ✅ Expected Results

### 4-bit Detection:
```
🚨 TROJAN DETECTED - 4 suspicious signals identified

Top Detections:
  1. trigger_counter  → 45,900% deviation
  2. trojan_trigger   → 20,500% deviation
  3. trojan_active    → 13,700% deviation
  4. payload_mask     → 10,300% deviation

Detection Rate: 100% ✅
```

### Multi-Scale Summary:
- **4-bit**: 4 Trojan signals detected
- **8-bit**: 4 Trojan signals detected
- **16-bit**: 6 Trojan signals detected
- **Overall**: 100% detection accuracy across all bit-widths

---

## 🔧 Prerequisites

**Required:**
```powershell
# Check if installed
iverilog -v        # Verilog simulator
python --version   # Python 3.8+
```

**Install if needed:**
```powershell
# Python dependencies
pip install -r requirements.txt

# Icarus Verilog
# Download from: https://bleyer.org/icarus/
```

---

## 🎓 For Hackathon Judges

### Quick Demo (30 seconds):
```powershell
cd presentation\demo_files
.\run_quick_demo.ps1
```

### Full Demonstration (5 minutes):
```powershell
# Show scalability
python compare_bitwidths.py

# Run multi-scale detection
python run_multiscale_detection.py

# Show results
start designs\4bit\results\trojan_detection_report.png
start designs\8bit\results\trojan_detection_report.png
start designs\16bit\results\trojan_detection_report.png
```

### Key Talking Points:
1. **Scalability**: Works on 4-bit to 16-bit designs
2. **Effectiveness**: 100% detection even with 1/4-billion trigger probability
3. **Methodology**: Side-channel analysis beats functional testing
4. **Real-world**: Applicable from IoT to servers

---

## 🐛 Troubleshooting

**Issue**: `iverilog: command not found`
- **Solution**: Install Icarus Verilog and add to PATH

**Issue**: `No module named 'numpy'`
- **Solution**: `pip install numpy matplotlib seaborn`

**Issue**: VCD files not found
- **Solution**: Run simulation first: `python run_analysis.py`

**Issue**: Permission denied on .ps1 files
- **Solution**: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`

---

## 📞 Need Help?

Check these files:
- `HOW_TO_PRESENT.txt` - Detailed presentation guide
- `designs/README.md` - Multi-scale architecture details
- `README.md` - Complete project documentation

---

**Last Updated:** November 9, 2025  
**Project:** Hardware Trojan Detection via Side-Channel Analysis
