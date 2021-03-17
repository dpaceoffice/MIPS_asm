.data
    empty: .space 2

.text

#A[i] = x + y
#x = f2, y = f3, A = $s0, i = $s1

main:
    li.s    $f2, 0.5
    li.s    $f3, 0.5
    li      $s1, 0
    la		$s0, empty		#init variables

    add.s     $f5, $f2, $f3
    sll       $t0, $s1, 2   #4i
    add       $t1, $t0, $s0 #address of A[i]
    swc1      $f5, 0($t1)   #A[i] = $f5
    jr		  $ra			# jump to $ra
    