	.data
    earray: .word 0
    .text

#int fun(int[] A, int b, int c) {
#    for(int i = 0; i < b; i++) {
#        A[i] = b+c;
#    }
#    return A[5]
#}

main: 
    la $a0, earray
    addi $a1, $zero, 5
    addi $a2, $zero, 1
    j	        f2c				# jump to f2c save pointer here in $ra
    
f2c:
    add		$t0, $zero, $zero	# $t0 = 0
    for: 
        bge		$t0, $a1, Exit	# if $t0 >= $a1 then target
        add		$t1, $a1, $a2	# $t1 = b + c
        sll     $t2, $t0, 2     # 4i
        add     $t3, $a0, $t2   #base +4i => addr. of A[i]
        sw		$t1, 0($t3)		#A[i] = b+c
        addi    $t0, $t0, 1   #i += 1
        j		for				# jump to for
    Exit:
        lw      $v0, 20($a0)    #V0 = A[5]
        jr      $ra				# jump to $ra
    
    