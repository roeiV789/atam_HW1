.global _start

.section .text
_start:

movq $Lower ,%rsi
movq $Upper ,%rdi



.Loop_4_HW1:
	#get the next caracter
	movb (%rsi),%al
	cmpb $0, %al
	je .Finished_HW1
	
.Numbers_HW1:
	#check if character is a number:
	cmpb $'9', %al
	jg .Upper_case_HW1
	cmpb $'0', %al
	jb .Not_legal_HW1
	jmp .Load_value_HW1

.Upper_case_HW1:
	#check if character upper case:
	cmpb $'Z', %al
	jg .Lower_case_HW1
	cmpb $'A', %al
	jb .Not_legal_HW1
	jmp .Load_value_HW1
	
	
.Lower_case_HW1:
	#check if character lower case:
	cmpb $'z', %al
	jg .Not_legal_HW1
	cmpb $'a', %al
	jb .Not_legal_HW1
	subb $32, %al
	jmp .Load_value_HW1


.Not_legal_HW1:
	inc %rsi
	jmp .Loop_4_HW1

	
.Load_value_HW1:
	movb %al, (%rdi)
	inc %rsi
	inc %rdi
	jmp .Loop_4_HW1
	

.Finished_HW1:
	
