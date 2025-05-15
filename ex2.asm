.global _start

.section .data
msg_not_pal: .asciz "Not a palindrome\n"
msg_pal:     .asciz "Palindrome\n"

.section .text
_start:

#move Address and Length to registers
movq Address ,%rsi
movl Length ,%edx


#check if length is 0/1
cmpq $0, %rdx
je .is_palindrome_HW1
cmpq $1, %rdx
je .is_palindrome_HW1


#ready Length and counter
movq $0,%rcx
subq $1 ,%rdx


.loop_HW1:

	#check if we finished the data
	cmpq %rdx ,%rcx
	jge .is_palindrome_HW1
	
	#load data to registers
	movb (%rsi ,%rcx,1), %al
	movb (%rsi ,%rdx,1), %bl
	cmpb %al, %bl
	je .update_vals_HW_1
	jmp .is_not_palindrome_HW1
	
	
.update_vals_HW_1:
	inc %rcx
	dec %rdx
	jmp .loop_HW1


.is_palindrome_HW1:
movb $1 ,Result
jmp .finished_HW_1

.is_not_palindrome_HW1:
movb $0 ,Result
jmp .finished_HW_1


.finished_HW_1:
