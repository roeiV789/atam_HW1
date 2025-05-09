.global _start

.section .text
_start:
lea String(%rip), %rsi
movl $0x00646461, %r8d	#r8d = 'add'
movl $0x00627573, %r9d	#r9d = 'sub'
movl $0x006C756D, %r10d	#r10d = 'mul'
movl $0x00766964, %r11d	#r11d = 'div'
#flags to deal with only 0x 0b case
movl $0, %r12d			
movl $0, %r13d

movb $0, %bl			#word flag
movb $0, %dl 			#digit flag

.Loop_HW1:
	
	movb (%rsi), %al
	cmpb $0x00, %al
	je .Update_Result_HW1
	#skip iteration if space at the beginning
	cmpb $' ', %al
	je .End_of_Loop_HW1
	
	movw (%rsi), %cx
	cmpw $0x7830, %cx #comparing '0x'
	je .Prefix_Digit_HW1  
	cmpw $0x6230, %cx #comparing '0b'
	je .Prefix_Digit_HW1
	
	cmpb $'0', %al 
	jl .Letter_HW1
	cmpb $'9', %al
	jg .Letter_HW1
	jmp .Check_Digit_HW1
	
	.Letter_HW1:
	
		cmpb $'i', %al
		je .Check_I_HW1
		cmpb $'a', %al
		je .Check_Add_HW1
		cmpb $'s', %al
		je .Check_Sub_HW1
		
		.Three_Letter_HW1:
		
			cmpb $'m', %al
			je .Check_Mul_HW1
			cmpb $'d', %al
			je .Check_Div_HW1
		
	.End_Sequence_HW1:
	
		inc %rsi
		cmpb $0x00, (%rsi)
		je .Update_Result_HW1
		cmpb $' ', (%rsi) 
		je .End_of_Loop_HW1
		
		jmp .End_Sequence_HW1

	.End_of_Loop_HW1:
		inc %rsi
		jmp .Loop_HW1
		
.Prefix_Digit_HW1:
	movl $0, %r12d
	movl $0, %r13d
	inc %rsi
	cmpb $0x00, (%rsi)
	je .Update_Result_HW1
	movl $1, %r12d
	jmp .Check_Digit_HW1
	
.Check_Digit_HW1:

	inc %rsi
	cmpb $0x00, (%rsi)
	je .Finish_Digit_HW1
	
	cmpb $' ', (%rsi)
	je .Finish_Digit_HW1
	
	movl $1, %r13d
	cmpb $'0', (%rsi) 
	jl .End_Sequence_HW1
	cmpb $'9', (%rsi)
	jg .End_Sequence_HW1
	
	jmp .Check_Digit_HW1
	
	.Finish_Digit_HW1:
		testl %r12d, %r12d
		je .Skip_HW1
		cmpl $0, %r13d
		je .Update_Result_HW1
		
		.Skip_HW1:
		movb $2, %dl
		cmpb $0x00, (%rsi)
		je .Update_Result_HW1
		cmpb $' ', (%rsi)
		je .End_of_Loop_HW1
		
.Check_I_HW1:

	inc %rsi
	cmpb $0x00, (%rsi)
	movb (%rsi), %al
	je .Update_Result_HW1
	
	jmp .Three_Letter_HW1
	
.Check_End_Of_Letter_Word_HW1:

	#checking whether the next char is the end or space = end of a "word"
	inc %rsi
	movb (%rsi), %al
	cmpb $0x00, %al 
	je .Finish_Word_HW1
	
	cmpb $' ', %al
	je .Finish_Word_HW1
	
	jmp .End_Sequence_HW1
	
	.Finish_Word_HW1:
		movb $1, %bl
		cmpb $0x00, %al 
		je .Update_Result_HW1
		jmp .End_of_Loop_HW1

.Check_Three_Letter_Word_HW1:

	#word value stored in edi
	#checking first letter
	
	movb (%rsi), %al
	cmpb $0x00, %al
	je .Update_Result_HW1
	cmpb %al, %dil
	jne .End_Sequence_HW1
	
	#increment to reach next byte
	shrl $8, %edi
	inc %rsi
	
	#checking second letter
	movb (%rsi), %al
	cmpb $0x00, %al
	je .Update_Result_HW1
	cmpb %al, %dil
	jne .End_Sequence_HW1
	
	shrl $8, %edi
	inc %rsi
	
	#checking third letter
	movb (%rsi), %al
	cmpb $0x00, %al
	je .Update_Result_HW1
	cmpb %al, %dil
	jne .End_Sequence_HW1
	
	jmp .Check_End_Of_Letter_Word_HW1
	
.Check_Add_HW1:

	movl %r8d, %edi
	jmp .Check_Three_Letter_Word_HW1
	
.Check_Sub_HW1:

	movl %r9d, %edi
	jmp .Check_Three_Letter_Word_HW1	
	
.Check_Mul_HW1:

	movl %r10d, %edi
	jmp .Check_Three_Letter_Word_HW1
		
.Check_Div_HW1:

	movl %r11d, %edi
	jmp .Check_Three_Letter_Word_HW1
		
.Update_Result_HW1:
	
	addb %bl, %dl
	movb %dl, Result
