;Name: Jonathan Diep
;Cwid: 884973462
;Email: jonathon.dieppp@csu.fullerton.edu
;Date: Apr 23 2025
;Program: Final program.

; Declaration
extern getqwords
extern printf
extern scanf

global manager

section .data
number dq -17
Address db 10, "The address of -17 is %lx", 10, 0
Input   db 10, "Please enter an address in hex: ", 0
Scan    db "%lx", 0
Result  db 10, "The integer at that address is 0x%016lX", 10, 0
Done    db 10, "Function getqword has finished. A number will be returned to the driver.", 10, 0

section .bss
user_addr resq 1

section .text
manager:
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

; Print address of number
mov rax, 0
mov rdi, Address        ; format string
mov rsi, number         ; value to print
call printf

; Prompt user for address
mov rax, 0
mov rdi, Input
call printf

; Read user input into user_addr
mov rax, 0
mov rdi, Scan
mov rsi, user_addr
call scanf

; Dereference user input and call getqwords
mov rdi, [user_addr]     ; rdi = address user typed in
call getqwords           ; result in rax

mov rbx, rax             ; store result

; Print value at address
mov rax, 0
mov rdi, Result
mov rsi, rbx
call printf

; Print done message
mov rax, 0
mov rdi, Done
call printf

; Return result in rax
mov rax, rbx

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
ret
