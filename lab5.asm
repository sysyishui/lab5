
.text
.globl main
main:
    li a0, 5          # height of tower
    li a1, 'L'        # source pole (left)
    li a2, 'R'        # destination pole (right)
    li a3, 'C'        # auxiliary pole (center)
    
    jal solve_hanoi   # call solve_hanoi

    li v0, 10         # terminate program
    syscall

# a0 - number of disks
# a1 - source pole
# a2 - destination pole
# a3 - auxiliary pole
solve_hanoi:
    # Base case: if a0 == 0, return
    beq a0, zero, done
    
    # Recursive step 1: move n-1 disks from source to auxiliary
    addi a0, a0, -1
    move t0, a2    # Temporarily store the destination pole
    move t1, a3    # Temporarily store the auxiliary pole
    jal solve_hanoi
    move a2, t0    # Restore the destination pole
    move a3, t1    # Restore the auxiliary pole
    
    # Move the nth disk from source to destination
    # Print instructions to move disk
    li v0, 4
    la a0, msg1    # "Moving disk "
    syscall
    li v0, 1
    move a0, a0    # Move the disk number
    syscall
    li v0, 4
    la a0, msg2    # " from "
    syscall
    move a0, a1    # Move the source pole
    syscall
    la a0, msg3    # " to "
    syscall
    move a0, a2    # Move the destination pole
    syscall
    li v0, 11      # Print newline
    li a0, '\n'
    syscall
    
    # Recursive step 2: move n-1 disks from auxiliary to destination
    addi a0, a0, 1
    move t0, a1    # Temporarily store the source pole
    move t1, a3    # Temporarily store the auxiliary pole
    jal solve_hanoi
    move a1, t0    # Restore the source pole
    move a3, t1    # Restore the auxiliary pole

done:
    jr ra          # Return from function

.data
msg1: .asciiz "Moving disk "
msg2: .asciiz " from "
msg3: .asciiz " to "
