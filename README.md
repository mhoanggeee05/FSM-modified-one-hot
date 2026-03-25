# One-Hot FSM Pattern Detector (Structural Design)

## Overview

Finite State Machine (FSM) using one-hot encoding to process serial input `w`.
The design includes a shift-register-based output block to detect specific bit patterns.

## Features

* One-hot encoded FSM (9 states)
* Fully synchronous design with D flip-flops
* Separate next-state and present-state modules
* Pattern detection using 4-stage shift register
* Output `z` triggered when input sequence is all 0s or all 1s

## Structure

* `next_state`: combinational logic for state transition
* `present_state`: state registers (D flip-flops)
* `out`: shift register + pattern detection logic
* `d_ff`: basic flip-flop building block

## Notes

* Structural/gate-level design (minimal behavioral code)
* Clear separation between datapath and control logic
* Verified through simulation

