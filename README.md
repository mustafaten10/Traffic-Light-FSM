# Traffic Light Controller FSM (with Delay)

This project implements a **Traffic Light Controller** using a **4-state Finite State Machine (FSM)** in SystemVerilog.
The controller includes a **5 clock cycle delay for the yellow lights**.

This was developed for an assignment for **ELE432 – Advanced Digital Design at Hacettepe University**.

## Inputs

| Signal  | Description          |
| ------- | -------------------- |
| `clk`   | System clock         |
| `reset` | Reset signal         |
| `TAORB` | Traffic sensor input |

Traffic logic:

* `TAORB = 1` → Traffic is present on **Street A**
* `TAORB = 0` → Traffic is present on **Street B**

## Outputs

The controller generates traffic light signals for both streets.

Street A:

* `LA_G` – Green
* `LA_Y` – Yellow
* `LA_R` – Red

Street B:

* `LB_G` – Green
* `LB_Y` – Yellow
* `LB_R` – Red

## FSM States

| State | Street A | Street B | Description                     |
| ----- | -------- | -------- | ------------------------------- |
| S0    | Green    | Red      | Stays here while `TAORB = 1`    |
| S1    | Yellow   | Red      | Yellow light for 5 clock cycles |
| S2    | Red      | Green    | Stays here while `TAORB = 0`    |
| S3    | Red      | Yellow   | Yellow light for 5 clock cycles |

## Timer

A simple **counter (`timer`)** is used to create the delay for the yellow lights.

* The counter runs only in **S1** and **S3**
* It counts **0 → 5** (total 5 clock cycles)
* It resets when leaving the yellow states

## Files

| File                  | Description                             |
| --------------------- | --------------------------------------- |
| `traffic_light.sv`    | SystemVerilog implementation of the FSM |
| `traffic_light_tb.sv` | Testbench used for simulation           |
