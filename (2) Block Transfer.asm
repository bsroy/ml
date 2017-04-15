Assignment 02

%macro Write 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro Read 2
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data

msg db "Enter String : "
msglen equ $-msg

menu: db 10,"Menu :",10
			db "1. Overlapped Block Transfer with String Instruction",10
			db "2. Overlapped Block Transfer without String Instruction",10
			db "3. Non-Overlapped Block Transfer with String Instruction",10
			db "4. Non-Overlapped Block Transfer without String Instruction",10
			db "5. EXIT",10
menulen equ $-menu

msg1 db "Enter Choice : ",10
msglen1 equ $-msg1

msg2 db "String Entered : ",10
msglen2 equ $-msg2

op1 db "Overlapped Block Transfer with String Instruction is : ",10
op1len equ $-op1

op2 db "Overlapped Block Transfer without String Instruction is : ",10
op2len equ $-op2

op3 db "Non-Overlapped Block Transfer with String Instruction is : ",10
op3len equ $-op3

op4 db "Non-Overlapped Block Transfer without String Instruction is : ",10
op4len equ $-op4


section .bss

strn1 resb 11
strn2 resb 10
str1len resq 1
temp resq 1
charbuff resb 16
choice resb 2

section .text
global _start
_start:


Menu :

Write menu, menulen
Write msg1, msglen1
Read choice, 2

cmp byte[choice], 31H
je option1

cmp byte[choice], 32H
je option2

cmp byte[choice], 33H
je option3

cmp byte[choice], 34H
je option4

cmp byte[choice], 35H
je exit


option1:
	Write msg, msglen
	Read strn1, 11
		
	Write msg2, msglen2
	Write strn1, 11
	
	dec rax

	mov rsi, strn1
	mov rdi, strn2
	add rsi, rax
	dec rsi
	mov rdi, strn2
	add rdi, 04
	mov rcx, rax

	
	std ; sets direction flag to 1
	rep movsb ; moves string data

	;if direction flag is 0, data copies from lower to higher bits
	;if direction flag is 1, data copies from higher to lower bits
	
	Write op3, op3len
	Write strn1, 16
	Write op1, op1len

	jmp Menu

option2:
	Write msg, msglen
	Read strn1, 11
	
	Write msg2, msglen2
	Write strn1, 11

	dec rax
	mov qword[str1len], rax
	mov qword[temp], rax
	mov rsi, strn1
	
	add rsi, rax
	dec rsi
	mov rdi, strn2
	add rdi, 04
	
	up2: mov bl, byte[rsi]
		 mov byte[rdi], bl 
 		 dec rsi
		 dec rdi
		 dec qword[temp]
		 jnz up2
			
	Write op2, op2len
	Write strn1, 16
	jmp Menu

option3:
	Write msg, msglen
	Read strn1, 11
		
	Write msg2, msglen2
	Write strn1, 11
	
	dec rax

	mov rsi, strn1
	mov rdi, strn2
	dec rdi	
	mov rcx, rax

	cld ; clear direction flag, "sets direction flag to 0"
	rep movsb

	
	Write op3, op3len
	Write strn1, 20
	jmp Menu

option4:
	Write msg, msglen
	Read strn1, 11

	dec rax

	mov qword[str1len], rax
	mov qword[temp], rax
	
	Write msg2, msglen2
	Write strn1, 11

	mov rsi, strn1
	mov rdi, strn2
	dec rdi
	up:	mov bl, byte[rsi]
		mov byte[rdi], bl
		inc rsi
		inc rdi		
		dec qword[temp]
		jnz up

	Write op4, op4len
	Write strn1, 20
	jmp Menu

exit:
	mov rax, 60
	mov rdi, 0
	syscall


****************OUTPUT****************

Menu:
1. Overlapped Block Transfer with String Instruction
2. Overlapped Block Transfer without String Instruction
3. Non-Overlapped Block Transfer with String Instruction
4. Non-Overlapped Block Transfer without String Instruction
5. EXIT
Enter Choice : 1

overlapped block transfer using string instructions
t
overlapped block transfer without using string instructions

Enter a string:
helloworld

Overlapped Block Transfer with String Instruction is : 
hellowhelloworl

Menu:
1. Overlapped Block Transfer with String Instruction
2. Overlapped Block Transfer without String Instruction
3. Non-Overlapped Block Transfer with String Instruction
4. Non-Overlapped Block Transfer without String Instruction
5. EXIT
Enter Choice : 2


Enter a string:
helloworld

Overlapped Block Transfer without String Instruction is : 
hellowhelloworld

Menu:
1. Overlapped Block Transfer with String Instruction
2. Overlapped Block Transfer without String Instruction
3. Non-Overlapped Block Transfer with String Instruction
4. Non-Overlapped Block Transfer without String Instruction
5. EXIT
Enter Choice : 3

Enter a string:
helloworld

Non-Overlapped Block Transfer with String Instruction
helloworldhello

Menu:
1. Overlapped Block Transfer with String Instruction
2. Overlapped Block Transfer without String Instruction
3. Non-Overlapped Block Transfer with String Instruction
4. Non-Overlapped Block Transfer without String Instruction
5. EXIT
Enter Choice : 4

Enter a string:
helloworld

Non-Overlapped Block Transfer without String Instruction
helloworldhello

Menu:
1. Overlapped Block Transfer with String Instruction
2. Overlapped Block Transfer without String Instruction
3. Non-Overlapped Block Transfer with String Instruction
4. Non-Overlapped Block Transfer without String Instruction
5. EXIT
Enter Choice : 5








