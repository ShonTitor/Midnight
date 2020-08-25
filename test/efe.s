f:
        add $sp, $fp, 32
        lw $10, 0($fp)
#       move $10, $10
        lw $9, 4($fp)
        add $10, $10, $9
        div $9, $10, 2
        lw $9, 8($fp)
#       move $9, $9
#       move $9, $9
        add $9, $9, 1
        move $a0, $9
        li $v0, 1
        syscall
        li $v0, 11
        li $a0, 10
        syscall
        li $v0, 9
        li $a0, 4
        syscall
        move $9, $v0
        la $10, vac
        sw $10, ($9)
        sub $sp, $sp, 32
        # RETURN
        sw $9, -4($fp)
        jr $ra
main:
        move $fp, $sp
        add $sp, $fp, 24
        lw $8, 0($fp)
        li $8, 42
        move $a0, $8
        li $v0, 1
        syscall
        li $v0, 11
        li $a0, 10
        syscall
        move $12, $8
        li $v0, 9
        li $a0, 4
        syscall
        move $11, $v0
        sw $12, ($11)
        move $13, $8
        li $v0, 9
        li $a0, 4
        syscall
        move $12, $v0
        sw $13, ($12)
        sw $fp, ($sp)
        sw $ra, 4($sp)
        add $sp, 12
        lw $a0, ($11)
        sw $a0, ($sp)
        add $sp, 4
        add $11, 4
        lw $a0, ($12)
        sw $a0, ($sp)
        add $sp, 4
        add $12, 4
        # PANIC
        # x 0
        sw $8, 0($fp)
        # END PANIC
        sub $fp, $sp, 8
        jal f
        lw $11, -4($sp)
        lw $11, ($11)
        lw $ra, -8($sp)
        lw $fp, -12($sp)
        sub $sp, $sp, 12
        lw $8, 0($fp)
        move $a0, $8
        li $v0, 1
        syscall
        li $v0, 11
        li $a0, 10
        syscall
end:
        li $v0, 10
        syscall