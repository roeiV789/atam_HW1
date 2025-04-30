.section .data
First: .quad Node1

Result: .byte 0

Node1: .quad Node2
       .int 1
Node2: .quad Node3
       .int 2
Node3: .quad Node4
       .int 4
Node4: .quad Node5
       .int 8
Node5: .quad 0
       .int 16

.section .text
    call _start
    movzbl Result(%rip), %eax
    cmp $2, %al
    je success

error:
    mov $60, %rax
    mov $1, %rdi
    syscall

success:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
