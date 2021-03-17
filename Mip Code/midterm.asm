	.data
    earray: .space 5
    .text

#int fun(int[] A, int b, int c) {
#    for(int i = 0; i < b; i++) {
#        A[i] = b+c;
#    }
#    return A[5]
#}

main: 

    add $t1, $a0, $a1  #t1 = i + j
    sw  $t1, 8($s6) # a[2] = i + j

    add $a0, $zero, $s0 # a0 = i
    add $a1, $zero, $s1 # a1 = j
    add $a2, $zero, $s2 # a2 = k

    jal		mid
    sw $v0, 12($s7) # b[3] = mid(i,j,k)
    addi $t3, $v0, 2 # t3 = b[3] + 2
    add $t4, $s7, $a0 # address to B[i]
    sw $t3, 0($t4)  #B[i] = B[3] + 2
    jr		$ra					# jump to $ra
    
mid:
    bge		$a0, $a1, else #i >= j
    ble		$a1, $a2, else #j <= k
        li      $v0, 1    #V0 = 1
        j done
    else:
        addi $t0, $a2, 3 #t0 = k + 3
        add  $a0, $t0, $a1 #i = k + 3 + j
        sll  $a2, $a0, 2 # k = i * 4
    done:
        add   $v0, $zero, $a2    #V0 = k
    jr		$ra					# jump to $ra


floatFuncQ3:
        Loop: 
            bge $a0, $a1, Exit # i >= j
            c.gt.s      $f5, $f6 # x > y
            bc1t        Exit

            lwc1        $f3, 20($s0) # f3 = a[5]
            add.s		$f1, $f3, $f5 # a[5] + x
            sll         $t0, $a0, 3 #t0 = i*8
            add         $t1, $t0, $s0 # address to A[i8]
            swc1        $f1, 0($t1)#A[i8] = a[5] + x

            addi        $a0, $a0, 4 # i = i + 4
            li.s        $f2, 1.2    # f2 = 1.2
            add.s       $f5, $f5, $f2   # x = x + 1.2
            j Loop
        Exit:
            lwc1 $f0, 0($s0) #f0 = A[0]
        jr		$ra					# jump to $ra
