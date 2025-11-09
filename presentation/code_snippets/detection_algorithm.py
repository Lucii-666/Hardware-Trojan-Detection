"""
Detection Algorithm - Core Logic
Show this during "THE ANALYSIS" section
"""

class TrojanDetector:
    """Detects hardware Trojans through side-channel analysis"""
    
    def __init__(self, clean_toggles, trojan_toggles):
        self.clean_toggles = clean_toggles
        self.trojan_toggles = trojan_toggles
        
        # Find common signals and Trojan-only signals
        self.common_signals = set(clean_toggles.keys()) & set(trojan_toggles.keys())
        self.trojan_only_signals = set(trojan_toggles.keys()) - set(clean_toggles.keys())
    
    def compute_deviations(self):
        """
        Calculate percentage deviation in switching activity
        
        KEY INSIGHT:
        - For common signals: compare toggle counts
        - For Trojan-only signals: MASSIVE deviation (didn't exist before!)
        """
        deviations = {}
        
        # Analyze signals present in both designs
        for signal in self.common_signals:
            clean_count = self.clean_toggles.get(signal, 0)
            trojan_count = self.trojan_toggles.get(signal, 0)
            
            if clean_count > 0:
                # Normal deviation calculation
                deviation = 100.0 * abs(trojan_count - clean_count) / clean_count
            elif trojan_count > 0:
                # Signal with no clean activity = suspicious!
                deviation = trojan_count * 100.0
            else:
                deviation = 0.0
            
            deviations[signal] = deviation
        
        # Analyze Trojan-only signals (SMOKING GUN!)
        for signal in self.trojan_only_signals:
            trojan_count = self.trojan_toggles.get(signal, 0)
            if trojan_count > 0:
                # Signal that doesn't exist in clean design = Trojan artifact!
                deviations[signal] = trojan_count * 100.0
        
        return deviations
    
    def detect_anomalies(self, threshold=25.0):
        """
        Flag signals with deviation above threshold
        
        Our Results:
        - trigger_counter: 45,900% deviation (459 toggles × 100)
        - trojan_trigger: 20,500% deviation (205 toggles × 100)
        - trojan_active: 13,700% deviation (137 toggles × 100)
        - payload_mask: 10,300% deviation (103 toggles × 100)
        
        ALL 4 are Trojan-only signals = 100% detection rate!
        """
        deviations = self.compute_deviations()
        
        # Sort by deviation (highest first)
        anomalies = [(sig, dev) for sig, dev in deviations.items() if dev > threshold]
        anomalies.sort(key=lambda x: x[1], reverse=True)
        
        return anomalies


# ============================================
# PRESENTATION TALKING POINTS:
# ============================================

"""
1. "We parse VCD files to extract toggle counts for each signal"

2. "Compare clean vs Trojan designs - look for deviations"

3. "Signals that exist ONLY in Trojan design are automatically flagged"

4. "Our detection threshold is 25% - anything above is suspicious"

5. "We found 4 signals with MASSIVE deviations (10,000%+)"

6. "These 4 signals are the Trojan components - they don't exist in clean design!"

7. "No functional testing needed - pure switching activity analysis"
"""
