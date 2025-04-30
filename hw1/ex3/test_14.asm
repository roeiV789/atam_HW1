.section .data
First: .quad Node1

Result: .byte 0

Node1: .quad Node2
       .int 2
Node2: .quad Node3
       .int 5
Node3: .quad 0
       .int 10

.section .text
     
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
