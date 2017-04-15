Assignment 3


%macro Write 2 ;macro for writing
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro Read 2 ;macro for reading
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

section .data

Menu: db 10,"Menu :",10
			db "1. Convert HEX to BCD",10
			db "2. Convert BCD to HEX",10
			db "3. EXIT",10
			db 10,"Enter your choice :",10

menulen equ $-Menu

option1 db "HEX value converted to BCD is :",10
optlen1 equ $-option1

option2 db "BCD value converted to HEX is :",10
optlen2 equ $-option2

msg db 10,"Enter Number :"
msglen equ $-msg

section .bss
choice resb 2

hexnum resb 17
bcdnum resb 17
buffer resb 16

num resq 1
hex_count resq 1
bcd_count resq 1
stack_count resq 1




section .text
global _start
_start:

menu:
	Write Menu, menulen
	Read choice, 2

	cmp byte[choice], 31H
	je opt1

	cmp byte[choice], 32H
	je opt2

	cmp byte[choice], 33H
	je exit



opt1:										;converting HEX to BCD
	Write msg, msglen
	Read hexnum, 17
	
	dec rax
			
	mov qword[hex_count], rax
	mov qword[stack_count], 0
	mov qword[num], 0
	mov rdx, 0
	mov rsi, hexnum
	
	up:
			mov dl, byte[rsi]
			cmp dl, 39H			
			jbe sub_30
			sub dl, 07H

			sub_30:
							sub dl, 30H	
			
			shl qword[num], 04
			add qword[num], rdx
			inc rsi
			dec qword[hex_count]
			jnz up

			mov rax, qword[num]
			up1:
					mov rdx, 0
					mov rbx, 10
			
					div rbx
					push rdx
					inc qword[stack_count]
					cmp rax, 0
					jnz up1
			
			mov rsi, bcdnum

			up2:
					pop rdx
					add dl, 30H
					mov byte[rsi], dl
					inc rsi
					dec qword[stack_count]
					jnz up2

	Write option1, optlen1
	Write bcdnum, 16
	jmp menu

opt2:										;converting BCD to HEX
	Write msg, msglen
	Read bcdnum, 17
	dec rax
	
	mov qword[num], 0
	mov qword[bcd_count], rax
	mov rsi, bcdnum

	up3: 
			mov rax, qword[num]
			
			mov rbx, 0AH
			mul rbx
			mov rbx, 0
			mov bl, byte[rsi]
			
			sub bl, 30H			
			add rax, rbx

			mov qword[num], rax
			inc rsi
			dec qword[bcd_count]
			jnz up3
 
			Write option2, optlen2
			mov rbx, qword[num]
			call display

	
	jmp menu


exit:										;EXIT
	mov rax, 60
	mov rdi, 0
	syscall

display:
	mov rcx, 16
	mov rsi, buffer

	up4:
			rol rbx, 04
			mov dl, bl
			and dl, 0FH
			cmp dl, 09H
			jbe add30
			add dl, 07H
			
	add30:
				add dl, 30H
				mov [rsi], dl
				inc rsi
				dec rcx
				jnz up4

Write buffer, 16
ret



****************OUTPUT****************

Menu :
1. Convert HEX to BCD
2. Convert BCD to HEX
3. Exit

Enter your choice :
1

Enter number :
FFFF
HEX value converted to BCD :
65535

Menu :
1. Convert HEX to BCD
2. Convert BCD to HEX
3. Exit

Enter your choice :
2

Enter number :
65535
BCD value converted to HEX :
000000000000FFFF

Menu :
1. Convert HEX to BCD
2. Convert BCD to HEX
3. Exit

Enter your choice :
3









