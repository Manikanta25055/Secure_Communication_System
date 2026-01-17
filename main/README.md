# Secure Communication System with Spread Spectrum and Encryption

## ELE 3126 - Communication Systems
**IA-4 Group Assignment**

---

## Project Overview

This MATLAB project implements a secure communication system that combines:
- **Direct Sequence Spread Spectrum (DSSS)** for signal spreading
- **XOR-based Encryption** for data security
- **Jamming Resistance** analysis
- **BER Performance** comparison across multiple scenarios

---

## Directory Structure

```
IA 4/
├── scripts/
│   ├── main_simulation.m           # Main simulation script (RUN THIS)
│   ├── dsss_transmitter.m          # DSSS spreading function
│   ├── dsss_receiver.m             # DSSS despreading function
│   ├── encrypt_message.m           # Encryption function
│   ├── decrypt_message.m           # Decryption function
│   ├── generate_pn_sequence.m      # PN sequence generator
│   ├── add_channel_noise.m         # Channel noise/jamming simulator
│   └── plot_results.m              # Visualization function
├── results/                         # Generated plots and data
├── data/                           # Data files (if any)
└── report/                         # LaTeX report files
```

---

## How to Run

1. **Open MATLAB** and navigate to the `scripts/` folder:
   ```matlab
   cd '/Users/manikantagonugondla/Desktop/MIT/MIT/3rd Year/CS/IA 4/scripts'
   ```

2. **Run the main simulation**:
   ```matlab
   main_simulation
   ```

3. **Check results**: All plots will be saved in the `results/` folder

---

## Features Implemented

### 1. DSSS Modulation
- Spreading factor: 31 chips/bit
- PN sequence generation using LFSR concept
- Correlation-based despreading

### 2. Encryption
- XOR cipher with pseudo-random key stream
- Symmetric encryption (same key for encryption/decryption)
- Key-based seed generation

### 3. Channel Modeling
- AWGN (Additive White Gaussian Noise)
- Optional narrowband jamming signal
- Variable SNR simulation

### 4. Performance Analysis
- BER vs SNR curves for 4 scenarios:
  1. Uncoded (baseline)
  2. DSSS only
  3. DSSS + Encryption
  4. DSSS + Encryption + Jamming

---

## Generated Plots

1. **ber_performance.png** - BER comparison across all scenarios
2. **message_visualization.png** - Original, encrypted, and spread signals
3. **pn_sequence_analysis.png** - PN sequence properties
4. **spreading_effect.png** - Visualization of spreading operation
5. **processing_gain.png** - Spectrum before/after spreading

---

## Parameters (Customizable in main_simulation.m)

- `message_length`: Number of bits (default: 100)
- `spreading_factor`: Chips per bit (default: 31)
- `pn_seed`: Seed for PN generation (default: 13)
- `encryption_key`: Encryption key string
- `Eb_N0_dB`: SNR range (default: -10 to 20 dB)
- `jamming_power_dB`: Jammer power (default: 10 dB)

---

## Course Outcomes Addressed

- **CO1**: Analog modulation analysis (frequency-domain)
- **CO3**: Digital communication generation and detection
- **CO5**: Wireless communication systems (spread spectrum, encryption)

---

## References

1. Simon Haykin, "Communication Systems", 4th Edition
2. Bernard Sklar, "Digital Communications: Fundamentals and Applications"
3. Course lecture notes on DSSS and encryption

---

## Author

**Manikanta Gonugondla**  
Manipal Institute of Technology  
November 2025
