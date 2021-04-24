########
###### David Pace
########
########
###### Date: 4/23/21
########
.text
.globl main
main:
    la $a0, promp       #stores pointer to string in $a0
    jal PromptInt       #uses $a0 as input for string to print
    la $t1, count	    #set pointer in register $t1
    sw $v0, 0($t1)    	#save the number the person input to memory address indicated by $t1
    la $t1, ($v0)       #set the number the person input to register $t1

    gatherlist:
        ble	$t1, $zero, exitgatherlist	# if $t1 <= 0 then exit

        la $a0, iterate #input number
        la $a1, count   #save pointer
        lw $a1, 0($a1)  #load data at pointer
        sub $a1, $a1, $t1  #total - current
        jal PrintInt       #prints string $a0 and int $a1

        la $a0, promp1      #stores pointer to string in $a0
        jal PromptInt       #uses $a0 as input for string to print, outputs result in $v0

        sll $t2, $a1, 2    # $t2 = a1 * 4
        la $t3, array_base # store base address of array
        add $t3, $t3, $t2  #add offset stored in t2. t3 now points to the current index
        
        sw $v0, 0($t3)      #saves input to address at $t3

        addi $t1, $t1, -1
        j gatherlist

    exitgatherlist:
    la $a0, entered
    jal PrintString

    la $a0, array_base  #point to our location in memory for the array
    lw $a1, array_size  #size of array in bits, .word(32) * count
    jal PrintIntArray

    la $a0, array_base
    lw $a1, array_size
    jal BubbleSort
    jal PrintNewLine

    la $a0, sortedmsg
    jal PrintString

    la $a0, array_base
    lw $a1, array_size
    jal PrintIntArray
    jal Exit
.data
    promp: .asciiz "How many numbers do you wish to sort through?\n"
    promp1: .asciiz "\n"
    iterate: .asciiz "Input number "
    entered: .asciiz "You have entered: "
    sortedmsg: .asciiz "Here is the sorted list in ascending order: "
    count: .word
    array_size: .word count
    array_base: .word 0:100#populates 0 in 100 32-bit integers (word); int[100]
    .include "utils.asm"
    .include "bubbleSort.asm"
