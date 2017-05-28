.globl main
.globl whileLoop
.globl startMultiply
.globl matrix_11
.globl clearMem1
.globl matrix_21
.globl clearMem2
.globl matrix_12
.globl clearMem3
.globl matrix_22
.globl endMult
.globl initialize

.data
matrix1: .word 5, 6, 2, 7, 8, 1 #for addition
matrix2: .word 3, 7, 2, 8, 9, 0 
matrix3: .word 5, 6, 2, 7, 8, 1 #for multiplication
matrix4: .word 3, 7, 2, 8, 9, 0
add_result: .word 1, 1, 1, 1, 1, 1
mult_result: .word 1, 1, 1, 1  #word count t6.. will index through mult_result with $t6
.text

#In your code DO NOT CHANGE $s0 - $s3 unless you know how to restore the values.
main:
            jal initialize
            
	    addi $t0, $zero, 0
whileLoop: 
	    beq $t0, 24, startMultiply	  
	    addi $zero, $zero, 0   #no op
	       
	    lw $t1, matrix1($t0)
	    lw $t2, matrix2($t0)	    
	    add $t3, $t1, $t2	    
	    sw $t3, add_result($t0)    
	    lw $t4, add_result ($t0)
	    
	    addi $t0, $t0, 4
	    j whileLoop

startMultiply:
	    addi $t0, $zero, 0 #i=0
	    addi $t1, $zero, 0 #j=0
	    addi $t2, $zero, 0
	    addi $t3, $zero, 0
	    addi $t4, $zero, 0
	    addi $t5, $zero, 0 #storing sum
	    addi $t6, $zero, 0 #used for indexing of mult_result array .. k=0
	    #making sure all registers we will be using are storing only 0
	    	    	    
matrix_11:   lw $t2, matrix3($t0)
	    lw $t3, matrix4($t1)
	    mul $t4, $t2, $t3	#$t4 = matrix3($t0) x matrix4($t1)
	    add $t5, $t5, $t4	#sum = sum + t4(multiplied stuff)
	    sw $t5, mult_result($t6)
	    addi $t0, $t0, 4 
	    addi $t1, $t1, 8 
	    beq $t0, 12, clearMem1 #not done with 1x1 number in result matrix if it doesn't branch
	    addi $zero, $zero, 0 #no op
	    jal matrix_11 #loops back to label to finish multiplying and summing for 1x1 number in result matrix
	    addi $zero, $zero, 0 #no op
	    addi $zero, $zero, 0 #no op
clearMem1:
	    addi $t0, $zero, 0 #i=0
	    addi $t1, $zero, 0 #j=0
	    addi $t2, $zero, 0
	    addi $t3, $zero, 0
	    addi $t4, $zero, 0
	    addi $t5, $zero, 0 #storing sum
	    #reseting registers from matrix11  except $t0, as it is a counter for i
	    
	    addi $t0, $zero, 12 # i=12 will be the 12th byte for load and store
	    addi $t6, $zero, 8 # k = 8 will be the 8th byte for load and store
	    
matrix_21:   lw $t2, matrix3($t0)
	    lw $t3, matrix4($t1)
	    mul $t4, $t2, $t3	#$t4 = matrix3($t0) x matrix4($t1)
	    add $t5, $t5, $t4	#sum = sum + t4
	    sw $t5, mult_result($t6) 	    
	    addi $t0, $t0, 4 
	    addi $t1, $t1, 8 	    
	    beq $t0, 24, clearMem2
	    addi $zero, $zero, 0 #no op
	    jal matrix_21
	    addi $zero, $zero, 0 #no op
	    addi $zero, $zero, 0 #no op
	    
clearMem2:
	    addi $t0, $zero, 0 #i=0
	    addi $t1, $zero, 0 #j=0
	    addi $t2, $zero, 0
	    addi $t3, $zero, 0
	    addi $t4, $zero, 0
	    addi $t5, $zero, 0 #storing sum
	    #reseting registers from matrix21  except $t0, as it is a counter for i
	    	
	    addi $t1, $zero, 4 
	    addi $t6, $zero, 4
	    
matrix_12:  lw $t2, matrix3($t0)
	    lw $t3, matrix4($t1)
	    mul $t4, $t2, $t3	#$t4 = matrix3($t0) x matrix4($t1)
	    add $t5, $t5, $t4	#sum = sum + t4
	    sw $t5, mult_result($t6) 	    
	    addi $t0, $t0, 4 
	    addi $t1, $t1, 8 	    
	    beq $t0, 12, clearMem3
	    addi $zero, $zero, 0 #no op
	    jal matrix_12
	    addi $zero, $zero, 0 #no op
	    addi $zero, $zero, 0 #no op
	    
clearMem3:
	    addi $t0, $zero, 0 #i=0
	    addi $t1, $zero, 0 #j=0
	    addi $t2, $zero, 0
	    addi $t3, $zero, 0
	    addi $t4, $zero, 0
	    addi $t5, $zero, 0 #storing sum
	    #clearing registers
	    
	    addi $t0, $zero, 12 # setting i=12
	    addi $t1, $zero, 4 # setting j=4
	    addi $t6, $zero, 12 #setting 

matrix_22:   lw $t2, matrix3($t0)
	    lw $t3, matrix4($t1)
	    mul $t4, $t2, $t3	#$t4 = matrix3($t0) x matrix4($t1)
	    add $t5, $t5, $t4	#sum = sum + t4
	    sw $t5, mult_result($t6) 	    
	    addi $t0, $t0, 4 
	    addi $t1, $t1, 8 	    
	    beq $t0, 24, endMult
	    addi $zero, $zero, 0 #no op
	    jal matrix_22
	    addi $zero, $zero, 0 #no op
	    addi $zero, $zero, 0 #no op

endMult:    li $v0, 10  #end 
	    syscall	

# Used to load matrices addresses into corresponding registers
# DO NOT TOUCH
initialize:
            la $s2, matrix1
            la $s3, matrix2
            la $s0, matrix3
            la $s1, matrix4
            la $s4, add_result
            la $s5, mult_result
            
            jr $ra

#      How I set up the program for the multiplication part     
#      by label in the 2x2 matrix:  
#	 ______		    _______	______    ______
#	|			   |   |		|
#	| matrix_11	matrix_12  |   |   45	   83   |
#	|			   | = |		|
#	| matrix_21	matrix_22  |   |   46      113  |
#	|______		    _______|   |______    ______|
#          
     