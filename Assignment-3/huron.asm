global huron
extern printf

segment .data
    half dq 0.5
    
segment .bss
align 64
backup_storage_area resb 832

segment .text

huron:

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

sub rsp, 32
movsd [rsp], xmm0
movsd [rsp+8], xmm1
movsd [rsp+16], xmm2


; Calculate the semi-perimeter (s = (a + b + c) / 2)
addsd xmm0, xmm1   ; xmm15 = a + b
addsd xmm0, xmm2   ; xmm15 = a + b + c
mulsd xmm0, [half]  ; xmm15 = (a + b + c) * 0.5 = s
movsd xmm15, xmm0
movsd xmm0, [rsp]

; Calculate (s - a), (s - b), and (s - c)
movsd xmm4, xmm15    ; xmm4 = s
subsd xmm4, xmm0     ; xmm4 = s - a

movsd xmm5, xmm15    ; xmm5 = s
subsd xmm5, xmm1     ; xmm5 = s - b

movsd xmm6, xmm15    ; xmm6 = s
subsd xmm6, xmm2     ; xmm6 = s - c

mulsd xmm4, xmm5     ; xmm4 = (s - a) * (s - b)
mulsd xmm4, xmm6     ; xmm4 = (s - a) * (s - b) * (s - c)
mulsd xmm4, xmm15    ; xmm4 = s * (s - a) * (s - b) * (s - c)

movsd xmm15, xmm4  
sqrtsd xmm15, xmm15 

movsd xmm0, xmm15   ; Moving xmm15 to xmm0 to return the area of the triangle.
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]  ; Restore SSE registers

add rsp, 32


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