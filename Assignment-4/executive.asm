; declaration
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern sort
extern show_array
extern normalize_array
extern fill_random_array

global executive

string_size equ 24

segment .data
prompt_name db 10,"Please enter your name: ", 0
prompt_title db "Please enter your title (Mr, Ms, Sergeant, Chief, Project Leader, etc.): ", 0
msg_1 db "Nice to meet you %s %s", 10, 0
msg_2 db 10,"This program will generate 64-bit IEEE float numbers.", 10, 0
prompt_num "How many numbers do you want. Today's limit is 100 per customer. ", 0
invalid_msg db 10, "Input size is over 100. Please try again.", 10, 0
int_format db "%d", 0
msg_3 db "Your numbers have been stored in an array. Here is that array.", 10, 0
msg_4 db 10,"The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array", 10, 0
msg_5 db 10,"The array will now be sorted", 10, 0
msg_6 db 10,"Good bye %s. you are welcome anytime.", 10, 0

segment .bss
align 64
backup_storage_area resb 832

name resb string_size
title resb string_size
my_array resq 100

segment .text
executive:

; Backup GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

; Backup other registers
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

mov rax, 0
mov rdi, prompt_name
call printf

mov rax, 0
mov rdi, name
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline
mov rax, 0
mov rdi, name
call strlen
mov [name + rax - 1], byte 0

mov rax, 0
mov rdi, title
mov rsi, string_size
mov rdi, [stdin]
call fgets

mov rax, 0
mov rdi, title
call strlen
mov [title + rax - 1], byte 0

mov rax, 0
mov rdi, msg_1
mov rsi, title
mov rdx, name
call printf

mov rax, 0
mov rdi, msg_2
call printf

size_input:
mov rax, 0
mov rdi, prompt_num
call printf

sub rsp, 8
mov rax, 0
mov rdi, int_format
mov rsi, rsp
call scanf
mov r15, [rsp]
add rsp, 8

cmp r15, 0
jl invalid_input

cmp r15, 100
jg invalid_input

jmp continue

invalid_input:
mov rax, 0
mov rdi, invalid_msg
call printf
jmp size_input

continue:
mov rax, 0
mov rdi, my_array
mov rsi, r15
call fill_random_array





mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

;send the name of the user back to main to be printed
mov rax, name

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret