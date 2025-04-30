.section .data
Num1: .long 0x0000FFFF          # 16 bits on (even)
Num2: .long 0xFFFF0000          # 16 bits on (even)
BitCheck: .byte 0

.section .text
    call _start
    movzbl BitCheck(%rip), %eax
    cmpb $1, %al                 # both even → should be 1
    je success

error:
    mov $60, %rax
    mov $1, %rdi
    syscall

success:
    mov $60, %rax
    xor %rdi, %rdi
    syscall
