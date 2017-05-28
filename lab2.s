	AREA	LAB2, CODE, READONLY	
	EXPORT	div_and_mod
	
div_and_mod
	STMFD r13!, {r2-r12, r14}

	MOV r4, #0

TEST	CMP r0, #0
		BGE THEN
		SUB r0,r4, r0
	CMP r1, #0
		BGE THEN
		SUB r1, r4, r1 	
	
	;RSB r0, r0, #0  Takes the absolute value of the dividend
	;RSB r1, r1, #0  Takes the abs value of divisor
	
THEN	MOV r2, #0 ; Initializes counter at 0.. will eventually be quotient
	MOV r3, #0 ; Initializes remainder at 0
	
LOOP1	CMP r0, #0 ; r0 < 0 .. then go to loop2 
	BLT LOOP2 ; If dividend is less than 0, go to loop2
	
	SUB r0, r0, r1 ; dividend = dividend - divisor
	ADD r2, r2, #1 ; add to counter
	CMP r0, #0  
	BGT LOOP1 ; If it's greater than.. you are almost done but you need to subtract the extra divisor and extra 1 from the count to get the final result
	BEQ DONE ; if it's equal you are done
	
LOOP2	SUB r2, r2, #1 ;  count = count -1 
	ADD r3, r0, r1 ; remainder = dividend + divisor ... b/c it's negative b/c one too many was subtracted on purpose
	
DONE	MOV r0, r2 ; counter is set to quotient
	MOV r1, r3 ; remainder is put into register 1
	

	; Your code for the signed division/mod routine goes here.  
	; The dividend is passed in r0 and the divisor in r1.
	; The quotient is returned in r0 and the remainder in r1. 
	
	LDMFD r13!, {r2-r12, r14}
	BX lr      ; Return to the C program	


	END

	
