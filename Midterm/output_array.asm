; Jonathan Diep
; CPSC 240-03
; March 10, 2025 
; jonathon.dieppp@csu.fullerton.edu


extern printf

global output_array

segment .data
floatformat db "%.5f ", 0

newline db 10, 0

segment .bss
    ; This segment is empty

segment .text

output_array:

; Backup GPRs
push rbp
mov rbp, rsp
push r12
push r13
push r14

mov r12, rdi    ; Storing address to r12
mov r13, rsi    ; Storing numbers of elements
mov r14, 0      ; Set r14 as counter for loop


output_loop:
cmp r14, r13    ; Compare index with length
jge output_exit ; End loop if index < length

; Print current index
sub rsp, 8
mov rdi, floatformat
movsd xmm0, [r12 + r14*8]   ; Moving current index from the selected address to xmm0 [Address + Index*byte]
mov rax, 1
call printf
add rsp, 8

inc r14             ; Increase r14 by 1
jmp output_loop     ; Calling output_loop

output_exit:
mov rax, 0
mov rdi, newline    ; Print newline after output
call printf

pop r14
pop r13
pop r12
pop rbp
ret