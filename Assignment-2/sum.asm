extern printf

global sum

segment .data
    ; This segment is empty

segment .bss
    ; This segment is empty

segment .text

sum:

; Backup GPRs
push rbp
mov rbp, rsp
push r12
push r13
push r14

mov r12, rdi
mov r13, rsi
xor r14, r14    ; Index/loop counter

sum_loop:
movsd xmm15, [r12 + r14*8]
addsd xmm14, xmm15
cmp r14, r13
jl sum_loop     ; If index < length then continue the loop
jg sum_exit     ; If index > length then exit the loop

sum_exit:
movsd xmm0, xmm14

pop r14
pop r13
pop r12
pop rbp
ret