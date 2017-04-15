
4

section .data
menu: db "Menu",10
      db "1. Successive Addition",10
      db "2. Add and Shift Method",10
      db "3. Exit",10
      db "   Enter choice: "
len_menu equ $-menu

	msg1: db 10,"Enter Multiplier: "
	len_msg1 equ $-msg1

	msg2: db 10,"Enter Multiplicant: "
	len_msg2 equ $-msg2

	result: db 10,"Result is : "
	len_res equ $-result

section .bss
	buff resq 2
	num resb 17
	no resq 1
	ccnt resq 1
	no1 resq 1
	no2 resq 1
%macro read 2
	mov rax, 0
	mov rdi, 0
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro write 2
	mov rax, 1
	mov rdi, 1
	mov rsi, %1
	mov rdx, %2
	syscall
%endmacro

%macro exit 0
	mov rax, 60
	mov rdi, 0
	syscall
%endmacro

global _start
section .txt
_start:
	write menu, len_menu
	mov rbx, 00
succ:	write msg1, len_msg1
	read num, 17		;read number from user
	dec rax			;decrement the length stored in rax
	mov qword[ccnt], rax	;set variable ccnt to hold length of number
	call convert		;Convert number from ASCII
	mov rax, qword[no]	;
	mov qword[no1], rax

	write msg2, len_msg2
	read num, 17
	dec rax 
	mov qword[ccnt], rax
	call convert
	mov rax, qword[no]
	mov qword[no2], rax

l2:	add rbx, qword[no1]
	dec qword[no2]
	cmp qword[no2], 00
	jne l2
	;sub rbx, 3h
	
	write result, len_res
	call disp
	exit

convert:mov rsi, num
	mov qword[no], 00
	mov rbx, 0
   up:	shl qword[no], 04
	mov bl, byte[rsi]
	sub bl, 30h
	add qword[no], rbx
	inc rsi
	dec qword[ccnt]
	jnz up
	ret

disp:   mov rsi, buff
        mov rcx, 16
        mov rdx, 0
   up1: rol rbx, 04
        mov dl, bl
        and dl, 0fh
        cmp dl, 09
        jbe l1
        add dl, 07h
    l1: add dl, 30h
        mov [rsi], dl
        inc rsi
        dec rcx
        jnz up1
        write buff, 16
        ret

;---------------------------------//OUTPUT//------------------------------------

Menu
1. Successive Addition
2. Add and Shift Method
3. Exit
   Enter choice: 
Enter Multiplier: 3

Enter Multiplicant: 2

Result is : 0000000000000008
