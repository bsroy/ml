               8
;=================================================TYPE ,DELETE ,COPY ,without using commanand line argument===========================;


section .data
msg db "1.TYPE command",10
    db "2. Copy Command",10
    db "3.Delete Command",10
    db "4.Exit from programme when file is not found::",10
    db "5.EXit from programme normally:: ",10

msg_len equ $-msg

msg_choice db"Enter the choice",10
msg_choice_len equ $-msg_choice



msg1 db "Enter the File name ",10
msg1_len equ $-msg1

msg2 db" Enter the file name to be copied",10
msg2_len equ $-msg2

msg3 db"Enter the file name to be deleted::",10
msg3_len equ $-msg3

msg_err db"File is not open or not found::",10
msg_err_len equ $-msg_err

msg_space db" ",10
msg_space_len equ $-msg_space


%macro write 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro




section .bss

choice resb 2
fname  resb 50
fname1 resb 50
fd resb 8
fd1 resb 8
size resb 8
buffer resb 50


section .text

global _start
_start:

main:
write msg ,msg_len

write msg_choice ,msg_choice_len
read choice,2

cmp byte[choice],31h
je TYPE


cmp byte[choice],32h
je COPY

cmp byte[choice],33h
je DELETE

cmp byte[choice],34h
je Exit

cmp byte[choice],35h
je Exit_n

TYPE:
write msg1,msg1_len    
read fname,50

dec rax
mov rsi,fname
add rsi,rax
mov byte[rsi],0

mov rax,02  ;open from the file
mov rdi,fname
mov rsi,0
mov rdx,0600o
syscall



cmp rax ,00
jle err 

mov qword[fd],rax

l1:mov rax,0
mov rdi,qword[fd]
mov rsi,buffer
mov rdx,50
syscall

mov qword[size],rax
write buffer ,qword[size]
cmp qword[size],50
je l1

mov rax,03
mov rdi,qword[fd]
syscall

jmp main


COPY:
write msg1,msg1_len    
read fname,50
dec rax
mov rsi,fname
add rsi,rax
mov byte[rsi],0



mov rax,02
mov rdi,fname
mov rsi,0
mov rdx,0777o
syscall


mov qword[fd],rax
cmp rax,0
jle err

mov qword[fd],rax

write msg2,msg2_len
read fname1,50
dec rax
mov rsi,fname1
add rsi,rax
mov byte[rsi],0

mov rax,02
mov rdi,fname1
mov rsi,101
mov rdx,0777o
syscall

mov qword[fd1],rax
cmp rax,0
jle err



l2:mov rax,0
mov rdi,qword[fd]
mov rsi,buffer
mov rdx,50
syscall
mov qword[size],rax

mov rax,1
mov rdi,qword[fd1]
mov rsi,buffer
mov rdx,qword[size]

syscall 
cmp qword[size],50
je l2

mov rax,3
mov rdi,qword[fd]
syscall

mov rax,3
mov rdi,qword[fd1]
syscall 

jmp main

DELETE:
write msg3,msg3_len
read fname,50
dec rax
mov rsi,fname
add rsi,rax
mov byte[rsi],0



mov rax,87
mov rdi,fname
syscall



jmp main

Exit:
err: write msg_err,msg_err_len
mov rax,60
mov rdi,0
syscall
 
Exit_n:
mov rax,60
mov rdi,0
syscall

OUTPUT

1.TYPE command
2. Copy Command
3.Delete Command
4.Exit from programme when file is not found::
5.EXit from programme normally:: 
Enter the choice
1
Enter the File name 
test.txt
testing 123
1.TYPE command
2. Copy Command
3.Delete Command
4.Exit from programme when file is not found::
5.EXit from programme normally:: 
Enter the choice
2
Enter the File name 
test.txt
 Enter the file name to be copied
test2.txt
1.TYPE command
2. Copy Command
3.Delete Command
4.Exit from programme when file is not found::
5.EXit from programme normally:: 
Enter the choice
3
Enter the file name to be deleted::
test.txt
1.TYPE command
2. Copy Command
3.Delete Command
4.Exit from programme when file is not found::
5.EXit from programme normally:: 
Enter t
