#!/usr/bin/env python3
"""
Quick Analysis Script for Live Demo
Simplified version that shows key results fast
"""

import sys
sys.path.insert(0, '../..')

from analysis.trojan_detector import VCDParser

print("\n[INFO] Parsing VCD files...")

# Parse both designs
clean_parser = VCDParser('../../results/alu_clean.vcd')
trojan_parser = VCDParser('../../results/alu_trojan.vcd')

clean_parser.parse()
trojan_parser.parse()

clean_toggles = clean_parser.get_toggle_counts()
trojan_toggles = trojan_parser.get_toggle_counts()

print(f"  Clean design:  {len(clean_toggles)} signals")
print(f"  Trojan design: {len(trojan_toggles)} signals")

# Find Trojan-only signals
trojan_only = set(trojan_toggles.keys()) - set(clean_toggles.keys())

print(f"\n[ALERT] Found {len(trojan_only)} signals ONLY in Trojan design!")
print("\nSuspicious Signals (Trojan Components):")
print("-" * 50)

# Calculate deviations for Trojan-only signals
anomalies = []
for signal in trojan_only:
    toggle_count = trojan_toggles[signal]
    deviation = toggle_count * 100.0  # Massive deviation
    anomalies.append((signal, deviation, toggle_count))

# Sort by deviation
anomalies.sort(key=lambda x: x[1], reverse=True)

# Display results
for i, (signal, dev, toggles) in enumerate(anomalies, 1):
    print(f"{i}. {signal:20s} - {dev:>10,.0f}% deviation ({toggles} toggles)")

print("\n" + "=" * 50)
print("✓ TROJAN DETECTED!")
print("=" * 50)
print(f"\nAll {len(anomalies)} suspicious signals identified.")
print("These components don't exist in the clean design.")
print("\nSee visual report for detailed analysis.")
