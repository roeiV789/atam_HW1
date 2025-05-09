.global _start

.section .text
_start:

#loading registers with Num1,Num2
movl Num1, %eax
movl Num2, %edx

#performing a xor between the two numbers
xorl %edx, %eax
#ones counter -> ecx
movl $0, %ecx

.Count_Loop_HW1:
	#check if the loop is finished
	cmpl $0, %eax
	je .Parity_Check_HW1
	
	#check if lsb is 1
	testl $1, %eax
	jz .No_Increment_HW1
	addl $1, %ecx
	
	.No_Increment_HW1:
	#shift eax again to prepare for next operation
	shrl $1, %eax
	jmp .Count_Loop_HW1
	
.Parity_Check_HW1:
	testl $1, %ecx
	jz .Even_HW1
	jmp .Odd_HW1

.Even_HW1:
	movb $1, BitCheck
	jmp .Finish_HW1

.Odd_HW1:
	movb $0, BitCheck

.Finish_HW1:
