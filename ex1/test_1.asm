.section .data
Num1: .long 0x00000000          # 0 bits on
Num2: .long 0x00000000          # 0 bits on
BitCheck: .byte 0

.section .text
    call _start
    movzbl BitCheck(%rip), %eax
    cmpb $1, %al                 # both even -> should be 1
    je success

error:
    mov $60, %rax
    mov $1, %rdi
    syscall

success:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
