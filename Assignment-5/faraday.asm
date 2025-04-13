; Declarations
extern printf
extern edison

global main

segment .data
msg_1 db "Welcome to Electricity brought to you by Jonathan Diep", 10, 0
msg_2 db "This program will compute the resistance current flow in your direct circuit.", 10, 0
msg_3 db 10, "The driver recieved this number %.5lf, and will keep it until next semester.", 10, 0
msg_4 db "A zero will be returned to the Operating System", 10, 0


segment .bss
res_current resq 1


segment .text
main:

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

; Print welcoming msg
mov rax, 0
mov rdi, msg_1
call printf

; Print program's purpose msg
mov rax, 0
mov rdi, msg_2
call printf

; Call edison function
mov rax, 0
mov rdi, res_current
call edison

; Store the returned value (in xmm0) to res_current
movsd [res_current], xmm0

; Now print the message with the value
mov rax, 0
mov rdi, msg_3
movsd xmm0, [res_current]
call printf

mov rax, 0
mov rdi, msg_4
call printf

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
pop rbp

mov rax, 60       ; syscall: exit
mov rdi, 0        ; exit code 0
syscall