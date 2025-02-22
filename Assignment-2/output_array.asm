extern printf

global output_array

segment .data
floatformat db "%.9f ", 0
intformat db "%d", 0

newline db 10, 0

segment .bss
    ;This segment is empty

segment .text

output_array:

;backup GPRs
push rbp
mov rbp, rsp
push r12
push r13
push r14

mov r12, rdi    ; Storing address to r12
mov r13, rsi    ; Storing numbers of elements
mov r14, 0   ; Set r14 as counter for loop


output_loop:
cmp r14, r13    ; Compare index with length
jge output_exit ; End loop if index < length

; Print current index
mov rdi, floatformat
movsd xmm0, [r12 + r14*8]   ; Moving current index from the selected address to xmm0 [Address + Index*byte]
call printf

inc r14         ; Increase r14 by 1
mov rax, 0
mov rdi, intformat
mov rsi, r14
call printf

jmp output_loop ; Calling output_loop

output_exit:
mov rax, 0
mov rdi, newline    ; Print newline after output
call printf

pop r14
pop r13
pop r12
pop rbp
ret