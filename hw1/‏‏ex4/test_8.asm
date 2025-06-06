.section .data
Lower: .asciz "1234567890"
Upper: .skip 100

.section .text
     
    movzbl Upper(%rip), %eax
    cmpb $'1', %al
    jne error
    movzbl Upper+1(%rip), %eax
    cmpb $'2', %al
    jne error
    movzbl Upper+2(%rip), %eax
    cmpb $'3', %al
    jne error
    movzbl Upper+3(%rip), %eax
    cmpb $'4', %al
    jne error
    movzbl Upper+4(%rip), %eax
    cmpb $'5', %al
    jne error
    movzbl Upper+5(%rip), %eax
    cmpb $'6', %al
    jne error
    movzbl Upper+6(%rip), %eax
    cmpb $'7', %al
    jne error
    movzbl Upper+7(%rip), %eax
    cmpb $'8', %al
    jne error
    movzbl Upper+8(%rip), %eax
    cmpb $'9', %al
    jne error
    movzbl Upper+9(%rip), %eax
    cmpb $'0', %al
    jne error
    movzbl Upper+10(%rip), %eax
    cmpb $0, %al
    jne error

success:
    mov $60, %rax
    xor %rdi, %rdi
    syscall

error:
    mov $60, %rax
    mov $1, %rdi
    syscall
