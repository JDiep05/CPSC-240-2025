
global huron

segment .data
    half db 0.5

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
movsd [rbp - 8], xmm12
movsd [rbp - 16], xmm13
movsd [rbp - 24], xmm14

movsd xmm12, xmm0   ; Moving side_1 into non-violatile register = a
movsd xmm13, xmm1   ; Moving side_2 into non-violatile register = b
movsd xmm14, xmm2   ; Moving side_3 into non-violatile register = c

; Calculate the semi-perimeter (s = (a + b + c) / 2)
addsd xmm15, xmm12   ; xmm15 = a
addsd xmm15, xmm13   ; xmm15 = a + b
addsd xmm15, xmm14   ; xmm15 = a + b + c
mulsd xmm15, [half]  ; xmm15 = (a + b + c) * 0.5 = s

; Calculate (s - a), (s - b), and (s - c)
movsd xmm1, xmm15   ; xmm1 = s
subsd xmm1, xmm12  ; xmm1 = s - a

movsd xmm2, xmm15   ; xmm2 = s
subsd xmm2, xmm13  ; xmm2 = s - b

movsd xmm3, xmm15   ; xmm3 = s
subsd xmm3, xmm14  ; xmm3 = s - c

; Calculate s * (s - a) * (s - b) * (s - c)
mulsd xmm15, xmm1   ; xmm15 = s * (s - a)
mulsd xmm15, xmm2   ; xmm15 = s * (s - a) * (s - b)
mulsd xmm15, xmm3   ; xmm15 = s * (s - a) * (s - b) * (s - c)

; Calculate the square root to get the area
sqrtsd xmm15, xmm15  ; xmm15 = sqrt(s * (s - a) * (s - b) * (s - c)) = area

; Store the result in the reserved memory location
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]  ; Restore SSE registers

movsd xmm12, [rbp - 8]
movsd xmm13, [rbp - 16]
movsd xmm14, [rbp - 24]
add rsp, 32

movsd xmm0, xmm15   ; Moving xmm15 to xmm0 to return the area of the triangle.

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
