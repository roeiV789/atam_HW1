.section .data
String: .asciz "okmulsubimul"
Result: .byte 0

.section .text
    call _start
    movzbl Result(%rip), %eax
    cmpb $0, %al
    je success

error:
    mov $60, %rax
    mov $1, %rdi
    syscall

success:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
