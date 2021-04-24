.text
.globl main
main:
    # register conventions
    # $s1 - n
    # $s2 - answer
    
    la $a0, prompt1 # Get the multiplicand
    jal PromptInt
    move $s1, $v0
    
    move $a1, $s1 #The value of n entered
    li $v0, 1     #The initial value for F(n)

    jal Factorial # Do multiplication
    move $s2, $v0
    
    la $a0, result #Print the answer
    move $a1, $s2

    jal PrintInt
    
    jal Exit
Factorial:
    addi $sp, $sp -8 # push the stack
    sw $a1, 4($sp) #save $a1
    sw $ra, 0($sp) # Save the $ra

    addi $t2, $zero, 1
    seq $t0, $a1, $t2 # if (n == 1) return
    seq $t0, $a1, $zero

    bnez $t0, Return
    bgt $zero, $a1, Invalid #if n < 0 invalid
    li $t0, 12
    bgt $a1, $t0, Invalid #if n >= 12 invalid

    addi $a1, $a1, -1 # set n = n-1
    lw $a0, 4($sp)#load n+1
    mul $v0, $v0, $a0 # return n*F(n-1)
    jal Factorial # recurse

    ble $zero, $a1, Return
    ble $a1, $t0, Return

    Invalid:
        la $a0, negativeErr
        jal PrintString
        jal Exit

    Return:

    lw $ra, 0($sp) #pop the stack
    addi $sp, $sp, 8
    jr $ra
.data
negativeErr: .asciiz "The input is not allowed for factorials either because it is too large or negative"
prompt1: .asciiz "Find the factorial of: "
result: .ascii "The answer is: "
.include "utils.asm"
