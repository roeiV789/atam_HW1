.section .data
String: .asciz "idiv at the start 0345 at the end"
Result: .byte 0

.section .text
     
    movzbl Result(%rip), %eax
    cmpb $3, %al
    je success

error:
    mov $60, %rax
    mov $1, %rdi
    syscall

success:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
