# DFA_keil
This is a project written in ARM7 code with the aim of simulating how a Deterministic Finite Automata functions.

## Why did I make this?
- I wanted to build something in ARM machine code to test my understanding of the instruction set provided, and also see whether I can make a working code myself in ARM.
- I was also studying Theory of Computation and was fascinated how machines work. I wanted to implement a simple single threaded DFA myself.

## How to run the project
- The main ARM code is in one single file : `logic.s`
- To run the project locally
    1. Download Keil UVision4.
    2. Clone the repository and open it within Keil UVision4.
    3. Place your String to be tested in REG r1
    4. Enter the size of your string in REG r0
    5. Run `logic.s`

## DFA details

Accepted Strings in this automata: (i times 0 then j times 1) such that i, j >= 0 and i+j is even.  

Examples : 	01, 0011, 0001, 11 are accepted<br>
			10, 011, 0110 are rejected.


### Transition table for this DFA

| Current State | On input "0" | On input "1" |
|---------------|--------------|--------------|
| ->*0             | 1            | 2            |
| 1             | 0            | 3            |
| 2             | 4            | 3            |
| *3             | 4            | 2            |
| 4             | 4            | 4            |

### Transition Diagram

![Transition Diagram](/transition_diagram.png)