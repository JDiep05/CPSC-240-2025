extern printf
extern isnan

global fill_random_array

segment .data                 ;Place initialized data here
intformat db 10, "%d  %d", 10, 0 
int_float dq "%18.13g", 0

segment .bss      ;Declare pointers to un-initialized space in this segment.

segment .text
fill_random_array:

;backup GPRs
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

mov r12, rdi    ; Storing array
mov r13, rsi    ; Storing size
mov r14, 0      ; Setting r14 as 0 to use as counter

check_size:
cmp r13, r14
jl fill_array

jmp exit

fill_array:
mov rax, 0
rdrand r15
mov rdi, r15
push r15
push r15
movsd xmm15, [rsp]
pop r15
pop r15

movsd xmm0, xmm15
call isnan
cmp rax, 0
je fill_array

movsd [r12+r14*8], xmm15

inc r14
jmp check_size

exit:
; Restore the GPRs
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