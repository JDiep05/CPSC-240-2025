global compute_resist

section .data
one dq 1.0

section .bss
    ; This segment is empty

section .text
compute_resist:

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

; Arguments: xmm1 = R1, xmm2 = R2, xmm3 = R3
; Returns xmm0 = R_total = 1 / (1/R1 + 1/(R2 + R3))

mov r12, rdi    ; Array of inputs
mov r13, rsi    ; Size of the array
mov r14, 0      ; Index/loop counter


resist_loop:
sub rsp, 8
movsd xmm13, [one]  ; initialize xmm13 as 1 and reloads it every loop
movsd xmm15, [r12 + r14*8]
divsd xmm13, xmm15
addsd xmm14, xmm13
add rsp, 8

inc r14
cmp r14, r13
jl resist_loop     ; If index < length then continue the loop
jg exit     ; If index > length then exit the loop

exit:
movsd xmm13, [one]  ; xmm13 = 1
divsd xmm13, xmm14
movsd xmm0, xmm13

; Restore general-purpose registers
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

