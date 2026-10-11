# Signals and Systems Lab: Frequency Response of an Electromechanical System

MATLAB / Simulink lab exercise (*Signali i sistemi*) in which the frequency response of an electromechanical plant is computed and plotted as Bode diagrams.

## The system

The plant is a **fourth-order mechanical subsystem** (two masses `m1`, `m2` coupled by a stiff spring `k` and damping `b1`, `b2`, `b12`) driven by a **DC motor** (resistance `R`, inductance `L`, electromechanical constants `kem`, `kme`). The input is the motor voltage and the outputs are the displacements `x1` and `x2` of the two masses.

## What the script does

1. Sets the model parameters (two parameter sets, model I and model II, can be switched in the script).
2. Linearises the Simulink model `RLV4_elektromehanicki_OU` with `linmod` and builds a state-space model (`ss`) and transfer functions (`tf`).
3. Computes the frequency response (`freqresp`) from 0.1 Hz up to half of the sampling frequency (Fs = 5 kHz).
4. Plots the **Bode diagrams** (magnitude in dB and phase in degrees, logarithmic frequency axis) from the voltage to `x1` (blue) and to `x2` (red).

## Getting started

Requires MATLAB with Simulink and the Control System Toolbox.

1. Open this folder in MATLAB.
2. Run `skripta_zad1.m`.

## Files

| File | Description |
|---|---|
| `skripta_zad1.m` | Parameters, linearisation, frequency response and plotting |
| `RLV4_elektromehanicki_OU.slx` | Simulink model of the electromechanical plant |
| `RLV4_elektromehanicki_OU.slxc` | Simulink cache file |
| `bodeovi_plotovi_1.fig`, `bodeovi_plotovi_2.fig` | Saved Bode plots for the two parameter sets |
