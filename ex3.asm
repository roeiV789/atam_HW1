.global _start

.section .text
_start:

#moving the pointer to the first node to rdi
movq First(%rip), %rdi
testq %rdi, %rdi
#goes to end if null
je .Result_One_HW1

#moving the pointer to the second node to rsi
movq (%rdi), %rsi
testq %rsi, %rsi
#goes to end if null
je .Result_One_HW1

#creating a register to store the difference between the values in the series - eax will store the difference
movl 8(%rsi), %eax
subl 8(%rdi), %eax

#advancing next node, we know that the next node is not null
movq (%rdi), %rdi
#checking if the series is of size 2
movq (%rdi), %rsi
testq %rsi, %rsi
#goes to end if null
je .Result_One_HW1

#creating flags: bl - first order flag, dl - second order flag
movb $0, %bl
movb $0, %dl

#creating values to store previous element in the second order, the current d in second order and a counter

movl $0, %r8d #will store the previous element in the second order series
movl $0, %r9d #will store the d for the second order series
movb $0, %r10b #counter that will check if we have advanced past the first two nodes - meaning that we know the distance of the second order

.Loop_HW1:

	#checks if they are both 1
	testb %bl, %dl
	jne .Result_Zero_HW1
	
	movq (%rdi), %rsi
	#checks if we reached nullptr - meaning it is either a first or second order progression
	testq %rsi, %rsi
	je .Exit_Loop_Result_Check_HW1
		
	#checking if it is a first order progression	
	movl 8(%rsi), %ecx
	subl 8(%rdi), %ecx
		
	#if it is the first iteration, creating the second order distance
	cmpb $0, %r10b
	je .Create_Second_Order_Distance_HW1
		
	#checking if it is already not a first order series, so we dont do unnecessary checks
	testb $1, %bl
	je .Second_Order_Check_HW1
		
	.Continue_First_Order_Check_HW1:
		#checking if the previous distance is equal to the current distance
		cmpl %ecx, %eax 
		jne .Update_First_Order_Flag_HW1
	
	.Second_Order_Check_HW1:
		#if it is the first iteration, no need to check
		cmpb $0, %r10b
		je .update_counter_HW1
		
		#checking if it is already not a second order series, so we dont do unnecessary checks
		cmpb $1, %dl
		je .Continue_Loop_HW1
		
		#checking if the current distance is equal to the previous second order distance
		addl %r9d, %r8d
		cmpl %r8d, %ecx
		jne .Update_Second_Order_Flag_HW1
		
	.Continue_Loop_HW1:
		movl 8(%rdi), %r11d
		movq (%rdi), %rdi #advancing to next node
		movl %ecx, %r8d #storing the previous element in second order series
		jmp .Loop_HW1

.update_counter_HW1:
	
	incb %r10b
	jmp .Continue_Loop_HW1
	
.Create_Second_Order_Distance_HW1:

	movl %ecx, %r9d
	subl %eax, %r9d
	movl %eax, %r8d
	jmp .Continue_First_Order_Check_HW1
	
.Update_First_Order_Flag_HW1:
	
	movb $1, %bl
	jmp .Second_Order_Check_HW1
	
.Update_Second_Order_Flag_HW1:
	
	movb $1, %dl
	jmp .Continue_Loop_HW1
	
.Exit_Loop_Result_Check_HW1:
	#checking if the distance in first order is not "ruined" by value in last node
	addl %r11d, %eax
	cmpl %eax, 8(%rdi)
	je .Last_Check_HW1
	movb $1, %bl
	
	cmpb $1, %dl
	jne .Last_Check_HW1
	jmp .Result_Zero_HW1
	
	#label can be reached only if is a first order(and then is also second) or a second order
	.Last_Check_HW1:
		cmpb $1, %bl 
		je .Result_Two_HW1 #if bl is 1 this means it is second order
		
.Result_One_HW1:
	movb $1, Result
	jmp .End_HW1

.Result_Two_HW1:
	movb $2, Result
	jmp .End_HW1

.Result_Zero_HW1:
	movb $0, Result

.End_HW1: