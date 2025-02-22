extern printf

global sum

segment .data
    ; This segment is empty

segment .bss
align 64
backup_storage_area resb 832

segment .text

sum:

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

;backup other registers
mov rax,7
mov rdx,0
xsave [backup_storage_area]

mov r12, rdi
mov r13, rsi
mov r14, 0    ; Index/loop counter

sum_loop:
sub rsp, 8
movsd xmm15, [r12 + r14*8]
addsd xmm14, xmm15
add rsp, 8

inc r14
cmp r14, r13
jl sum_loop     ; If index < length then continue the loop
jg sum_exit     ; If index > length then exit the loop

sum_exit:
movsd xmm0, xmm14
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