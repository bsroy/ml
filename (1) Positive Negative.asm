Assignment 1


section .data

numbers dq 1234123412341234H,0FFFFFFFFFFFFFFFFH, 3535353535353535H, 101234H, 99342H

msg db "Number of positive integers : ",10
msglen equ $-msg

msg1 db 10,10,"Number of negative integers : ",10
msg1len equ $-msg1

section .bss
pcount resq 1
ncount resq 1
charbuff resb 16


%macro write 2  ; MACRO : Text Substitution Method
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro


section .text
global _start
_start:

mov rsi, numbers
mov qword[pcount], 0
mov qword[ncount], 0
mov rcx, 5

up:
	mov rbx, qword[rsi]
	mov rdx, 8000000000000000H
  and rbx, rdx
	jz positive
		inc qword[ncount]
		jmp skip_positive

positive:
	inc qword[pcount]
skip_positive:
	add rsi, 8
	dec rcx
	jnz up

write msg, msglen ;printing number of positive integers
mov rbx, qword[pcount]
call display

write msg1, msg1len ;printing number of negative integers
mov rbx, qword[ncount]
call display

mov rax, 60
mov rdi, 0
syscall

display:
	mov rcx, 16
	mov rsi, charbuff	;making rsi pointing to charbuff
	
	label2:
		rol rbx, 04 ; rotating left for getting higher bits LSB

		mov dl, bl
		and dl, 0FH 
		cmp dl, 09H

		jbe add30 ;jump to label"add 30" if value is less than 9
		add dl, 07H ;adding 7 characters present in between
		
		add30:
			add dl, 30H ;add 30 to the value
			mov [rsi], dl

			inc rsi ;incrementing to the next digit
			dec rcx 

			jnz label2 ;jump to label2 if all the 16 bit are not parsed
			write charbuff, 16
ret





*************OUTPUT************

Number of positive integers : 
0000000000000004

Number of negative integers : 
0000000000000001   













