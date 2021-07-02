	AREA DFA,CODE,READONLY
START
;	AIM of this Project: to simulate the functioning of a Deterministic Finite Automata in machine code
;	Accepted Strings in this automata: (i times 0 then j times 1) such that i, j >= 0 and i+j is even.  
;	Examples : 	01, 0011, 0001, 11 are accepted
;			10, 011, 0110 are rejected.

; Implementation Specification: register r1 contains the string that goes through dfa (max size 8)
;								register r0 contains the size of this user string
; Final output will be in R0, 0 for rejected and 1 for accepted.
; Current state of the DFA will be stored in r4
; List of accepted states are in the memory "ACCEPTED_STATES"

; HOW TO USE?
; Place your String to be tested in REG r1
; Enter the size of your string in REG r0
; RUN


	LDR R0, = 0x8					;size of user string
	LDR r1, = 0x00011111				;user string
	LDR r4, = 0x0					;curr
	LDR r5, = 0x0					;next state
	LDR r6, = TRANSITION_TABLE			;base address of the transition table
	LDR R8, = 0x8				
	LDR r9, = 0x10000000				;to get the first bit by AND
	
;	SUBS r0, r0, #1
LOOP
	AND r3, r1, r9			;r3 now contains the current input bit
	MOV r3, r3, LSR #28		;look up (row = curr, col = r3) in transition table
	MUL r5, r4, R8			;generate row address
	ADD r5, r3, LSL #2			;add column addr to get correct delta in r5
	
	ADD R7, R6, r5			;base addr r6 + delta r5 = final addr		
	
	LDR R4, [R7], #4		;load the next state into current state
	
	
	MOV r1, r1, LSL #4		;move the user string
	SUBS r0, r0, #1			;decrement counter
	BNE LOOP	
	
	LDR r9, = 0x0
	LDR r10, = 0x2			;number of accepted states
	LDR r11, = ACCEPTED_STATES
	
FIND
	LDR r12, [r11], #4
	SUBS r12, r4
	BEQ ACCEPT
RETURN
	SUBS r10, r10, #1
	BNE FIND
	
STOP B STOP

ACCEPT
	LDR r0 ,= 0x1
	B RETURN


; transition table for this DFA

; 	curr	for 0	for 1
; 	0	1	2
; 	1	0	3
; 	2	4	3
; 	3	4	2
; 	4	4	4

TRANSITION_TABLE    		;all these values will be stored in dynamic memory starting from 0x20
	DCD 0x1,0x2,0x0,0x3,0x4,0x3,0x4,0x2,0x4,0x4		

ACCEPTED_STATES			;list of accepted states
	DCD 0x0,0x3
	
	END 
