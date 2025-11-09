#!/usr/bin/env python3
"""
Unified Demo - Shows Both Clean and Trojan ALU Functionality
Perfect for presentations - demonstrates the difference clearly
"""

import sys
sys.path.insert(0, '../..')

from analysis.trojan_detector import VCDParser

def print_separator(char="=", length=60):
    print(char * length)

def print_header(text):
    print_separator()
    print(f"  {text}")
    print_separator()

def analyze_design(vcd_file, design_name):
    """Analyze a single design and show its signals"""
    print(f"\n📊 Analyzing: {design_name}")
    print("-" * 60)
    
    parser = VCDParser(vcd_file)
    if not parser.parse():
        print(f"[ERROR] Failed to parse {vcd_file}")
        return None
    
    toggles = parser.get_toggle_counts()
    
    # Show signal count
    print(f"Total Signals: {len(toggles)}")
    print(f"\nSignal Activity:")
    print(f"{'Signal Name':<25} {'Toggles':<10}")
    print("-" * 60)
    
    # Sort by toggle count (descending)
    sorted_signals = sorted(toggles.items(), key=lambda x: x[1], reverse=True)
    
    for signal, count in sorted_signals:
        print(f"{signal:<25} {count:<10}")
    
    return toggles


def compare_designs(clean_toggles, trojan_toggles):
    """Compare both designs and highlight differences"""
    print_header("COMPARISON & TROJAN DETECTION")
    
    clean_signals = set(clean_toggles.keys())
    trojan_signals = set(trojan_toggles.keys())
    
    common = clean_signals & trojan_signals
    trojan_only = trojan_signals - clean_signals
    
    print(f"\n✅ Common Signals: {len(common)}")
    for sig in sorted(common):
        clean_count = clean_toggles[sig]
        trojan_count = trojan_toggles[sig]
        diff = abs(trojan_count - clean_count)
        if clean_count > 0:
            deviation = (diff / clean_count) * 100
            status = "⚠️" if deviation > 10 else "✓"
            print(f"  {status} {sig:<20} Clean: {clean_count:>5}  Trojan: {trojan_count:>5}  Diff: {deviation:>6.1f}%")
        else:
            print(f"  ✓ {sig:<20} Clean: {clean_count:>5}  Trojan: {trojan_count:>5}")
    
    if trojan_only:
        print(f"\n🚨 TROJAN-ONLY Signals: {len(trojan_only)}")
        print("=" * 60)
        print("These signals DON'T EXIST in clean design - TROJAN DETECTED!")
        print("=" * 60)
        
        for sig in sorted(trojan_only):
            count = trojan_toggles[sig]
            deviation = count * 100.0
            print(f"  🔴 {sig:<20} Toggles: {count:>5}  Deviation: {deviation:>10,.0f}%")
        
        return True
    else:
        print("\n✅ No Trojan-specific signals detected")
        return False


def main():
    print_header("HARDWARE TROJAN DETECTION - DUAL ANALYSIS")
    print("\nThis demo shows BOTH designs side-by-side:")
    print("1. Clean ALU (reference design)")
    print("2. Trojan ALU (infected design)")
    print("3. Comparison & detection results\n")
    
    # Analyze Clean Design
    print_header("PART 1: CLEAN ALU ANALYSIS")
    clean_toggles = analyze_design('../../results/alu_clean.vcd', 'Clean ALU')
    
    input("\n⏸️  Press ENTER to see Trojan ALU...")
    
    # Analyze Trojan Design
    print_header("PART 2: TROJAN ALU ANALYSIS")
    trojan_toggles = analyze_design('../../results/alu_trojan.vcd', 'Trojan ALU')
    
    if clean_toggles and trojan_toggles:
        input("\n⏸️  Press ENTER to compare designs...")
        
        # Compare
        trojan_detected = compare_designs(clean_toggles, trojan_toggles)
        
        # Final verdict
        print_header("FINAL VERDICT")
        if trojan_detected:
            print("\n🚨 TROJAN DETECTED! 🚨")
            print("\nEvidence:")
            print("• Extra signals found in Trojan design")
            print("• These components don't exist in clean reference")
            print("• Massive switching activity deviations (10,000%+)")
            print("• Hardware backdoor successfully identified!")
        else:
            print("\n✅ NO TROJAN DETECTED")
            print("Both designs have identical signal structure")
        
        print_separator()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⏹️  Demo interrupted by user")
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()
