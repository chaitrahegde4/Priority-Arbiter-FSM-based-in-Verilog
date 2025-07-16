# Priority Arbiter (FSM-based) in Verilog

This project implements a **4-input Priority Arbiter** using a Finite State Machine (FSM) in Verilog. It grants access to the highest-priority request line from four input requests. The FSM-based design ensures deterministic behavior and proper arbitration.


## Features

- FSM-based arbitration logic
- Priority: `req[0]` > `req[1]` > `req[2]` > `req[3]`
- Sequential logic with synchronous reset
- Output grant signal based on request priority
- Self-checking testbench with randomized and directed cases


---

##  FSM Description

This arbiter uses a **Moore Finite State Machine (FSM)** with five defined states based on request inputs. The output grant depends **only on the current state** (Moore model), not the input directly.

| State | Value   | Description             |
|-------|---------|-------------------------|
| s0    | 3'b000  | Idle – no request active |
| s1    | 3'b001  | Device 0 granted        |
| s2    | 3'b010  | Device 1 granted        |
| s3    | 3'b011  | Device 2 granted        |
| s4    | 3'b100  | Device 3 granted        |

- **Priority is fixed**:  
  `Device 0 (highest)` ➝ `Device 1` ➝ `Device 2` ➝ `Device 3 (lowest)`

---

##  Sample Test Scenarios

The following request patterns were tested using the testbench:

| Input `req` | Expected `grnt` | Notes                              |
|-------------|------------------|------------------------------------|
| 4'b0001     | 4'b0001          | Device 0 gets granted              |
| 4'b0011     | 4'b0001          | Device 0 has higher priority       |
| 4'b0100     | 4'b0100          | Device 2 gets granted              |
| 4'b1001     | 4'b0001          | Device 0 wins over device 3        |
| 4'b1000     | 4'b1000          | Only Device 3 requests, so granted |

---
