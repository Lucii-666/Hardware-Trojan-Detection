#!/usr/bin/env python3
"""
Hardware Trojan Detection via Side-Channel Analysis
VCD Analysis and Statistical Detection Tool

This module implements a side-channel based hardware Trojan detection
system using switching activity analysis. The approach compares toggle
counts between a reference design and a potentially infected design to
identify anomalous switching patterns.

Author: Silicon Sprint Team
Date: November 2025
"""

import re
import sys
import os
from collections import defaultdict
from typing import Dict, List, Tuple, Optional
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.gridspec import GridSpec
import seaborn as sns
from datetime import datetime

# Set style for professional plots
plt.style.use('seaborn-v0_8-darkgrid')
sns.set_palette("husl")


class VCDParser:
    """Parser for Value Change Dump (VCD) files"""
    
    def __init__(self, filepath: str):
        self.filepath = filepath
        self.signals = {}  # Maps signal identifier to name
        self.toggles = defaultdict(int)  # Toggle count per signal
        self.signal_values = defaultdict(list)  # Value history per signal
        self.timestamps = []
        self.timescale = "1ns"
        
    def parse(self) -> bool:
        """Parse VCD file and extract toggle information"""
        try:
            with open(self.filepath, 'r') as f:
                content = f.read()
            
            # Parse header to extract signal definitions
            self._parse_header(content)
            
            # Parse value changes
            self._parse_value_changes(content)
            
            return True
        except FileNotFoundError:
            print(f"ERROR: File not found: {self.filepath}")
            return False
        except Exception as e:
            print(f"ERROR parsing {self.filepath}: {e}")
            return False
    
    def _parse_header(self, content: str):
        """Extract signal definitions from VCD header"""
        # Find the variable declarations
        var_pattern = r'\$var\s+(\w+)\s+(\d+)\s+(\S+)\s+(\S+)'
        
        for match in re.finditer(var_pattern, content):
            var_type, width, identifier, name = match.groups()
            
            # Store signal mapping (identifier -> full name)
            self.signals[identifier] = name
    
    def _parse_value_changes(self, content: str):
        """Parse value changes and count toggles"""
        # Split into definition and value change sections
        sections = content.split('$enddefinitions')
        if len(sections) < 2:
            return
        
        value_section = sections[1]
        
        # Track previous values to detect toggles
        previous_values = {}
        
        # Parse each value change
        lines = value_section.split('\n')
        
        for line in lines:
            line = line.strip()
            
            # Timestamp marker
            if line.startswith('#'):
                try:
                    timestamp = int(line[1:])
                    if timestamp not in self.timestamps:
                        self.timestamps.append(timestamp)
                except ValueError:
                    continue
            
            # Value change: format is either "0identifier" or "b0101 identifier"
            elif line:
                # Single-bit value change
                if line[0] in '01xXzZ':
                    if len(line) > 1:
                        value = line[0]
                        identifier = line[1:]
                        
                        if identifier in self.signals:
                            # Check for toggle (0->1 or 1->0)
                            if identifier in previous_values:
                                if previous_values[identifier] != value:
                                    if value in '01' and previous_values[identifier] in '01':
                                        self.toggles[self.signals[identifier]] += 1
                            
                            previous_values[identifier] = value
                            self.signal_values[self.signals[identifier]].append(value)
                
                # Multi-bit value change
                elif line.startswith('b'):
                    parts = line.split()
                    if len(parts) >= 2:
                        value = parts[0][1:]  # Remove 'b' prefix
                        identifier = parts[1]
                        
                        if identifier in self.signals:
                            # Count bit-level toggles for multi-bit signals
                            if identifier in previous_values:
                                prev_val = previous_values[identifier]
                                # Compare bit-by-bit
                                toggle_count = self._count_bit_toggles(prev_val, value)
                                self.toggles[self.signals[identifier]] += toggle_count
                            
                            previous_values[identifier] = value
                            self.signal_values[self.signals[identifier]].append(value)
    
    def _count_bit_toggles(self, prev_val: str, curr_val: str) -> int:
        """Count number of bit toggles between two multi-bit values"""
        # Pad to same length
        max_len = max(len(prev_val), len(curr_val))
        prev_val = prev_val.zfill(max_len)
        curr_val = curr_val.zfill(max_len)
        
        toggles = 0
        for p, c in zip(prev_val, curr_val):
            if p in '01' and c in '01' and p != c:
                toggles += 1
        
        return toggles
    
    def get_toggle_counts(self) -> Dict[str, int]:
        """Return dictionary of signal names to toggle counts"""
        return dict(self.toggles)


class TrojanDetector:
    """Advanced Trojan detection using statistical and ML techniques"""
    
    def __init__(self, clean_toggles: Dict[str, int], trojan_toggles: Dict[str, int]):
        self.clean_toggles = clean_toggles
        self.trojan_toggles = trojan_toggles
        self.common_signals = set(clean_toggles.keys()) & set(trojan_toggles.keys())
        self.trojan_only_signals = set(trojan_toggles.keys()) - set(clean_toggles.keys())
        
    def compute_deviations(self, threshold: float = 25.0) -> Dict[str, float]:
        """Compute percentage deviation for each signal"""
        deviations = {}
        
        # Analyze common signals
        for signal in self.common_signals:
            clean_count = self.clean_toggles.get(signal, 0)
            trojan_count = self.trojan_toggles.get(signal, 0)
            
            if clean_count > 0:
                deviation = 100.0 * abs(trojan_count - clean_count) / clean_count
            elif trojan_count > 0:
                # New signal or signal with no clean activity - very suspicious!
                deviation = trojan_count * 100.0  # Massive deviation
            else:
                deviation = 0.0
            
            deviations[signal] = deviation
        
        # Analyze Trojan-only signals (EXTREMELY suspicious!)
        for signal in self.trojan_only_signals:
            trojan_count = self.trojan_toggles.get(signal, 0)
            if trojan_count > 0:
                # Signal that doesn't exist in clean design = Trojan artifact!
                deviations[signal] = trojan_count * 100.0  # Massive deviation
        
        return deviations
    
    def detect_anomalies(self, threshold: float = 25.0) -> List[Tuple[str, float]]:
        """Detect signals with deviations above threshold"""
        deviations = self.compute_deviations()
        anomalies = [(sig, dev) for sig, dev in deviations.items() if dev > threshold]
        anomalies.sort(key=lambda x: x[1], reverse=True)
        return anomalies
    
    def statistical_analysis(self) -> Dict:
        """Perform comprehensive statistical analysis"""
        deviations = self.compute_deviations()
        dev_values = list(deviations.values())
        
        if not dev_values:
            return {}
        
        analysis = {
            'mean_deviation': np.mean(dev_values),
            'median_deviation': np.median(dev_values),
            'std_deviation': np.std(dev_values),
            'max_deviation': np.max(dev_values),
            'min_deviation': np.min(dev_values),
            'q1': np.percentile(dev_values, 25),
            'q3': np.percentile(dev_values, 75),
        }
        
        # IQR-based outlier detection
        iqr = analysis['q3'] - analysis['q1']
        outlier_threshold = analysis['q3'] + 1.5 * iqr
        
        analysis['iqr'] = iqr
        analysis['outlier_threshold'] = outlier_threshold
        analysis['outliers'] = [(sig, dev) for sig, dev in deviations.items() 
                                if dev > outlier_threshold]
        
        return analysis
    
    def ml_based_detection(self) -> List[Tuple[str, float]]:
        """Use Isolation Forest-like approach for anomaly detection"""
        deviations = self.compute_deviations()
        
        if len(deviations) < 3:
            return []
        
        # Simple z-score based detection
        dev_values = np.array(list(deviations.values()))
        mean = np.mean(dev_values)
        std = np.std(dev_values)
        
        if std == 0:
            return []
        
        z_scores = np.abs((dev_values - mean) / std)
        
        # Signals with z-score > 2.5 are anomalies
        anomalies = []
        for (signal, deviation), z_score in zip(deviations.items(), z_scores):
            if z_score > 2.5:
                anomalies.append((signal, deviation))
        
        anomalies.sort(key=lambda x: x[1], reverse=True)
        return anomalies


class Visualizer:
    """Advanced visualization for Trojan detection results"""
    
    def __init__(self, clean_toggles: Dict[str, int], trojan_toggles: Dict[str, int]):
        self.clean_toggles = clean_toggles
        self.trojan_toggles = trojan_toggles
        self.detector = TrojanDetector(clean_toggles, trojan_toggles)
        
    def create_comprehensive_report(self, output_dir: str = 'results'):
        """Generate comprehensive multi-panel visualization"""
        # Create figure with subplots
        fig = plt.figure(figsize=(20, 12))
        gs = GridSpec(3, 3, figure=fig, hspace=0.3, wspace=0.3)
        
        # 1. Main comparison bar chart
        ax1 = fig.add_subplot(gs[0, :2])
        self._plot_toggle_comparison(ax1)
        
        # 2. Deviation chart
        ax2 = fig.add_subplot(gs[0, 2])
        self._plot_deviation_distribution(ax2)
        
        # 3. Heatmap
        ax3 = fig.add_subplot(gs[1, :2])
        self._plot_heatmap(ax3)
        
        # 4. Statistical analysis
        ax4 = fig.add_subplot(gs[1, 2])
        self._plot_statistics(ax4)
        
        # 5. Top anomalies
        ax5 = fig.add_subplot(gs[2, :])
        self._plot_top_anomalies(ax5)
        
        # Overall title
        fig.suptitle('Hardware Trojan Detection - Side-Channel Analysis Report', 
                     fontsize=20, fontweight='bold', y=0.995)
        
        # Save figure
        os.makedirs(output_dir, exist_ok=True)
        output_path = os.path.join(output_dir, 'trojan_detection_report.png')
        plt.savefig(output_path, dpi=300, bbox_inches='tight')
        print(f"[INFO] Comprehensive report saved: {output_path}")
        
        plt.close()
    
    def _plot_toggle_comparison(self, ax):
        """Bar chart comparing toggle counts"""
        common_signals = sorted(set(self.clean_toggles.keys()) & 
                               set(self.trojan_toggles.keys()))
        
        if not common_signals:
            ax.text(0.5, 0.5, 'No common signals found', 
                   ha='center', va='center', transform=ax.transAxes)
            return
        
        # Limit to top 20 most active signals for readability
        signal_activity = [(sig, self.clean_toggles[sig] + self.trojan_toggles[sig]) 
                          for sig in common_signals]
        signal_activity.sort(key=lambda x: x[1], reverse=True)
        top_signals = [sig for sig, _ in signal_activity[:20]]
        
        x = np.arange(len(top_signals))
        width = 0.35
        
        clean_counts = [self.clean_toggles[sig] for sig in top_signals]
        trojan_counts = [self.trojan_toggles[sig] for sig in top_signals]
        
        bars1 = ax.bar(x - width/2, clean_counts, width, label='Clean ALU', 
                      color='#2ecc71', alpha=0.8)
        bars2 = ax.bar(x + width/2, trojan_counts, width, label='Trojan ALU', 
                      color='#e74c3c', alpha=0.8)
        
        # Highlight significant deviations
        deviations = self.detector.compute_deviations()
        for i, sig in enumerate(top_signals):
            if deviations.get(sig, 0) > 25:
                ax.plot([i - width/2, i + width/2], 
                       [max(clean_counts[i], trojan_counts[i]) * 1.1] * 2,
                       'r*', markersize=10)
        
        ax.set_xlabel('Signal Name', fontweight='bold', fontsize=11)
        ax.set_ylabel('Toggle Count', fontweight='bold', fontsize=11)
        ax.set_title('Toggle Count Comparison (Top 20 Active Signals)', 
                    fontweight='bold', fontsize=13)
        ax.set_xticks(x)
        ax.set_xticklabels(top_signals, rotation=45, ha='right', fontsize=8)
        ax.legend(loc='upper right')
        ax.grid(axis='y', alpha=0.3)
    
    def _plot_deviation_distribution(self, ax):
        """Histogram of deviation percentages"""
        deviations = self.detector.compute_deviations()
        dev_values = list(deviations.values())
        
        if not dev_values:
            return
        
        ax.hist(dev_values, bins=30, color='#3498db', alpha=0.7, edgecolor='black')
        ax.axvline(25, color='red', linestyle='--', linewidth=2, label='Threshold (25%)')
        ax.set_xlabel('Deviation (%)', fontweight='bold')
        ax.set_ylabel('Frequency', fontweight='bold')
        ax.set_title('Deviation Distribution', fontweight='bold')
        ax.legend()
        ax.grid(alpha=0.3)
    
    def _plot_heatmap(self, ax):
        """Heatmap showing toggle patterns"""
        common_signals = sorted(set(self.clean_toggles.keys()) & 
                               set(self.trojan_toggles.keys()))[:15]
        
        if not common_signals:
            return
        
        # Create matrix: rows = signals, cols = [clean, trojan, deviation]
        matrix = []
        for sig in common_signals:
            clean = self.clean_toggles[sig]
            trojan = self.trojan_toggles[sig]
            dev = abs(trojan - clean)
            matrix.append([clean, trojan, dev])
        
        matrix = np.array(matrix)
        
        # Normalize each column
        matrix_norm = matrix / (matrix.max(axis=0) + 1e-10)
        
        im = ax.imshow(matrix_norm.T, cmap='RdYlGn_r', aspect='auto')
        
        ax.set_yticks([0, 1, 2])
        ax.set_yticklabels(['Clean', 'Trojan', 'Δ Deviation'])
        ax.set_xticks(range(len(common_signals)))
        ax.set_xticklabels(common_signals, rotation=45, ha='right', fontsize=8)
        ax.set_title('Toggle Activity Heatmap (Normalized)', fontweight='bold')
        
        plt.colorbar(im, ax=ax, label='Normalized Activity')
    
    def _plot_statistics(self, ax):
        """Display statistical summary"""
        stats = self.detector.statistical_analysis()
        
        if not stats:
            return
        
        # Create text summary
        ax.axis('off')
        
        summary_text = f"""
STATISTICAL ANALYSIS
{'='*30}

Mean Deviation:    {stats['mean_deviation']:.2f}%
Median Deviation:  {stats['median_deviation']:.2f}%
Std Deviation:     {stats['std_deviation']:.2f}%
Max Deviation:     {stats['max_deviation']:.2f}%

Quartiles:
  Q1: {stats['q1']:.2f}%
  Q3: {stats['q3']:.2f}%
  IQR: {stats['iqr']:.2f}%

Outlier Threshold: {stats['outlier_threshold']:.2f}%
Outliers Detected: {len(stats['outliers'])}
"""
        
        ax.text(0.1, 0.9, summary_text, transform=ax.transAxes,
               fontfamily='monospace', fontsize=10, verticalalignment='top',
               bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))
    
    def _plot_top_anomalies(self, ax):
        """Bar chart of top anomalous signals"""
        anomalies = self.detector.detect_anomalies(threshold=10.0)
        
        if not anomalies:
            ax.text(0.5, 0.5, 'No significant anomalies detected', 
                   ha='center', va='center', transform=ax.transAxes, fontsize=14)
            ax.axis('off')
            return
        
        # Top 10 anomalies
        top_anomalies = anomalies[:10]
        signals = [sig for sig, _ in top_anomalies]
        deviations = [dev for _, dev in top_anomalies]
        
        colors = ['#e74c3c' if dev > 50 else '#f39c12' if dev > 25 else '#3498db' 
                 for dev in deviations]
        
        bars = ax.barh(signals, deviations, color=colors, alpha=0.8, edgecolor='black')
        ax.axvline(25, color='red', linestyle='--', linewidth=2, label='25% Threshold')
        ax.axvline(50, color='darkred', linestyle='--', linewidth=2, label='50% Threshold')
        
        ax.set_xlabel('Deviation (%)', fontweight='bold', fontsize=12)
        ax.set_title('Top Anomalous Signals (Suspected Trojan Activity)', 
                    fontweight='bold', fontsize=13)
        ax.legend(loc='lower right')
        ax.grid(axis='x', alpha=0.3)
        
        # Add value labels
        for i, (bar, dev) in enumerate(zip(bars, deviations)):
            ax.text(dev + 1, i, f'{dev:.1f}%', va='center', fontweight='bold')


def generate_text_report(detector: TrojanDetector, output_dir: str = 'results'):
    """Generate detailed text report"""
    stats = detector.statistical_analysis()
    anomalies = detector.detect_anomalies(threshold=25.0)
    ml_anomalies = detector.ml_based_detection()
    
    report_path = os.path.join(output_dir, 'detection_report.txt')
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write("=" * 80 + "\n")
        f.write("HARDWARE TROJAN DETECTION REPORT\n")
        f.write("Side-Channel Analysis via Switching Activity\n")
        f.write("=" * 80 + "\n\n")
        f.write(f"Report Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        # Statistical Summary
        f.write("-" * 80 + "\n")
        f.write("STATISTICAL SUMMARY\n")
        f.write("-" * 80 + "\n")
        f.write(f"Total Signals Analyzed: {len(detector.common_signals)}\n")
        f.write(f"Mean Deviation: {stats['mean_deviation']:.2f}%\n")
        f.write(f"Median Deviation: {stats['median_deviation']:.2f}%\n")
        f.write(f"Standard Deviation: {stats['std_deviation']:.2f}%\n")
        f.write(f"Maximum Deviation: {stats['max_deviation']:.2f}%\n")
        f.write(f"IQR-based Outlier Threshold: {stats['outlier_threshold']:.2f}%\n\n")
        
        # Anomaly Detection Results
        f.write("-" * 80 + "\n")
        f.write("ANOMALY DETECTION RESULTS (25% Threshold)\n")
        f.write("-" * 80 + "\n")
        f.write(f"Anomalies Detected: {len(anomalies)}\n\n")
        
        if anomalies:
            f.write(f"{'Rank':<6} {'Signal Name':<30} {'Deviation':<15} {'Status'}\n")
            f.write("-" * 80 + "\n")
            
            for i, (signal, deviation) in enumerate(anomalies, 1):
                status = "CRITICAL" if deviation > 50 else "WARNING"
                f.write(f"{i:<6} {signal:<30} {deviation:>6.2f}%        {status}\n")
        
        f.write("\n")
        
        # ML-Based Detection
        f.write("-" * 80 + "\n")
        f.write("MACHINE LEARNING-BASED DETECTION (Z-Score > 2.5)\n")
        f.write("-" * 80 + "\n")
        f.write(f"ML Anomalies Detected: {len(ml_anomalies)}\n\n")
        
        if ml_anomalies:
            for signal, deviation in ml_anomalies:
                f.write(f"  • {signal}: {deviation:.2f}% deviation\n")
        
        f.write("\n")
        
        # Conclusion
        f.write("-" * 80 + "\n")
        f.write("CONCLUSION\n")
        f.write("-" * 80 + "\n")
        
        if len(anomalies) > 0:
            f.write("⚠ TROJAN DETECTED\n\n")
            f.write(f"Evidence: {len(anomalies)} signals show abnormal switching activity\n")
            f.write(f"above the 25% deviation threshold, indicating the presence of\n")
            f.write(f"stealthy hardware modifications in the Trojan design.\n\n")
            f.write(f"Most suspicious signal: {anomalies[0][0]} ")
            f.write(f"with {anomalies[0][1]:.2f}% deviation\n")
        else:
            f.write("[RESULT] NO TROJAN DETECTED\n\n")
            f.write("No significant deviations found between clean and test designs.\n")
        
        f.write("\n" + "=" * 80 + "\n")
    
    print(f"[INFO] Text report saved: {report_path}")


def main():
    """Main execution function"""
    print("\n" + "=" * 80)
    print("HARDWARE TROJAN DETECTION - SIDE-CHANNEL ANALYSIS")
    print("=" * 80 + "\n")
    
    # File paths
    clean_vcd = 'results/alu_clean.vcd'
    trojan_vcd = 'results/alu_trojan.vcd'
    
    # Check if files exist
    if not os.path.exists(clean_vcd):
        print(f"ERROR: Clean VCD file not found: {clean_vcd}")
        print("Please run the simulation first to generate VCD files.")
        return 1
    
    if not os.path.exists(trojan_vcd):
        print(f"ERROR: Trojan VCD file not found: {trojan_vcd}")
        print("Please run the simulation first to generate VCD files.")
        return 1
    
    # Parse VCD files
    print("Step 1: Parsing VCD files...")
    clean_parser = VCDParser(clean_vcd)
    trojan_parser = VCDParser(trojan_vcd)
    
    if not clean_parser.parse():
        return 1
    if not trojan_parser.parse():
        return 1
    
    print(f"  [OK] Clean design:  {len(clean_parser.signals)} signals parsed")
    print(f"  [OK] Trojan design: {len(trojan_parser.signals)} signals parsed\n")
    
    # Get toggle counts
    clean_toggles = clean_parser.get_toggle_counts()
    trojan_toggles = trojan_parser.get_toggle_counts()
    
    print("Step 2: Analyzing switching activity...")
    detector = TrojanDetector(clean_toggles, trojan_toggles)
    
    # Detect anomalies
    anomalies = detector.detect_anomalies(threshold=25.0)
    print(f"  [DETECTED] Anomalies found (>25% deviation): {len(anomalies)}\n")
    
    # Statistical analysis
    stats = detector.statistical_analysis()
    print(f"Step 3: Statistical Analysis")
    print(f"  • Mean deviation: {stats['mean_deviation']:.2f}%")
    print(f"  • Max deviation:  {stats['max_deviation']:.2f}%")
    print(f"  • Outliers found: {len(stats['outliers'])}\n")
    
    # Generate visualizations
    print("Step 4: Generating visualizations...")
    visualizer = Visualizer(clean_toggles, trojan_toggles)
    visualizer.create_comprehensive_report()
    print()
    
    # Generate text report
    print("Step 5: Generating text report...")
    generate_text_report(detector)
    print()
    
    # Summary
    print("=" * 80)
    print("ANALYSIS COMPLETE")
    print("=" * 80)
    if len(anomalies) > 0:
        print(f"[ALERT] TROJAN DETECTED - {len(anomalies)} suspicious signals identified")
        print(f"\nTop 3 suspicious signals:")
        for i, (signal, dev) in enumerate(anomalies[:3], 1):
            print(f"  {i}. {signal}: {dev:.2f}% deviation")
    else:
        print("[RESULT] No significant anomalies detected")
    print("=" * 80 + "\n")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
