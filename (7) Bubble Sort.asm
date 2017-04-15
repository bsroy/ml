7
section .data
	menu: db 10,"1.Bubble sort Operation"
		  db 10,"2.Exit",10

	mlen equ $-menu
	msg1:db "Enter your choice",10
	len1 equ $-msg1

	msg2:db "Enter file name",10
	len2 equ $-msg2

	msg3:db "File Opened succeccufully!!",10
	len3 equ $-msg3

	msg4:db "File open failed!!",10
	len4 equ $-msg4
	
	msg5:db "-----Bubble sort Operation!!-----",10
	len5 equ $-msg5

	msg6:db "Enter Destination file name!",10
	len6 equ $-msg6
	
	msg7:db "File Copied successfull!!",10
	len7 equ $-msg7
	
	nl db 10

section .bss
	choice resb 2
	fname1 resb 50
	fname2 resb 50	
	buffer resb 100
	fd1 resq 1
	charbuff resb 16
	fd2 resq 1
	size resq 1
	count resq 1
	arr resq 10
	arrsize resq 1
	i resq 1
	j resq 1	
	x resq 1
	
	%macro write 3
	mov rax,1
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
	%endmacro

	%macro write 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	%macro read 3
	mov rax,0
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
	%endmacro

	%macro fopen 2
	mov rax,2
	mov rdi,%1
	mov rsi,%2
	mov rdx,0777o
	syscall
	%endmacro

	%macro fclose 1
	mov rax,3
	mov rdi,%1
	syscall
	%endmacro

section .text
	global _start
	_start: 

mm:	write menu,mlen
	write msg1,len1
	read 0,choice,2
	cmp byte[choice],31H
	je opt1
	cmp byte[choice],32H
	je opt2
	
	jmp mm
opt1:	write msg5,len5     ;type command shows content of the file in windows system

	write msg2,len2

	read 0,fname1,50
	dec rax
	mov byte[fname1+rax],0
	
	fopen fname1,00     ;on opening file descriptor is saved id rax
	cmp rax,00H
	jle error
	
	mov qword[fd1],rax
	write msg3,len3
	
up: 	read [fd1],buffer,100
	mov qword[count],rax
	write 1,buffer,qword[count]
	
	mov rsi,buffer
	mov rdi,arr
	mov qword[arrsize],0
	
up2:	mov rbx,0

up1:	mov dl,byte[rsi]
	cmp dl,10
	je next
	shl rbx,04
	sub dl,30H
	add rbx,rdx
	inc rsi
	dec qword[count]
	jnz up1
		
	
		
next:	mov qword[rdi],rbx
	add rdi,08
	inc rsi
	inc qword[arrsize]
	dec qword[count]
	jnz up2

	fclose [fd1]
	
	;;;;;;;;;;;;;;;;;sorting;;;;;;;;;;;;;;;;

	mov qword[i],0
up4:	mov qword[j],0
	mov rsi,arr
	mov rdi,arr
	add rdi,08
	
up3:	mov rax,0
	mov rbx,0
	mov rax,qword[rsi]
	cmp rax,qword[rdi]
	jng next1
	
	mov rax,qword[rsi]
	mov rbx,qword[rdi]
	
	mov qword[rsi],rbx
	mov qword[rdi],rax
	
		
next1:	add rsi,08
	add rdi,08
	inc qword[j]
	
	mov rax,qword[arrsize]
	sub rax,qword[i]
	sub rax,1
	cmp qword[j],rax
	jl up3
	
	inc qword[i]
	
	mov rax,qword[arrsize]
	dec rax
	cmp qword[i],rax
	jl up4
	
	mov rcx,08
	mov rsi, arr
aaa1:	mov rbx,0
	mov rbx,qword[rsi]	
	
	call disp
	add rsi, 08	
	dec rcx	
	cmp rcx, 0
	jne aaa1
		;opening file2
	write msg2,len2

	read 0,fname2,50
	dec rax
	mov byte[fname2+rax],0
	
	fopen fname2,101     ;on opening file descriptor is saved in rax
	cmp rax,00H
	jle error
	
	mov qword[fd2],rax
	write msg3,len3
	
				
	mov rsi,arr
lbl:	mov qword[count],16
	mov rbx,qword[rsi]
up6:    rol rbx,04
	mov rdx,0
	mov dl,bl
	and dl,0FH
	cmp dl,09H
	jbe add
	add dl,07H
add:	add dl,30H
	mov byte[x],dl
	push rsi
	write [fd2],x,01
	pop rsi
	dec qword[count]
	jnz up6
	
	push rsi
	write [fd2],nl,01
	pop rsi
	add rsi,08
	dec qword[arrsize]
	jnz lbl

	fclose [fd2]
	jmp mm

opt2:	mov rax,60
	mov rdx,0
	syscall

error: 	write msg4,len4
	jmp mm

disp:   push rcx
	push rsi 
	mov rsi,charbuff

lbl1: 	mov rcx,16
lbl2:	rol rbx,04
	mov rdx,0
	mov dl,bl
	and dl,0FH
	cmp dl,09H
	jbe add_30
	add dl,07H

add_30:	add dl,30H
	mov byte[rsi],dl
	inc rsi
	dec rcx
	jnz lbl2	
	push rsi
	write charbuff,16
	pop rsi
	push rsi	
	write nl,1
	pop rsi		
	pop rsi	
	pop rcx
	ret

OUTPUT.............

1.Bubble sort Operation 
2.Exit 
Enter your choice 
1 
-----Bubble sort Operation!!----- 
Enter file name 
b1.txt 
File Opened succeccufully!! 
12 
23 
45 
67 
22 

0000000000000000 
0000000000000012 
0000000000000022 
0000000000000023 
0000000000000045 
0000000000000067 
0000000000000000 
0000000000000000 
Enter file name 
b1.txt 
File Opened succeccufully!! 

1.Bubble sort Operation 
2.Exit 
Enter your choice 
3 

1.Bubble sort Operation 
2.Exit 
Enter your choice 

