extern printf
extern scanf
extern atof
extern isfloat

global istriangle

true equ 1
false equ 0

segment .data
    ; This segment is empty

segment .bss
    ; This segment is empty

segment .text

istriangle:
push rbp
mov rbp, rsp
sub rsp, 32
movsd [rsp], xmm0
movsd [rsp+8], xmm1
movsd [rsp+16], xmm2
; Input: xmm0 = side_1, xmm1 = side_2, xmm2 = side_3
; Output: rax = 1 if valid triangle, 0 otherwise

; Check triangle inequality: side_1 + side_2 > side_3
addsd xmm0, xmm1      ; xmm0 = side_1 + side_2
ucomisd xmm0, xmm2    ; Compare (side_1 + side_2) with side_3
jbe not_triangle      ; If (side_1 + side_2) <= side_3, not a triangle

; Check side_1 + side_3 > side_2
movsd xmm0, [rsp] ; Reload side_1 (assuming it was passed on the stack)
addsd xmm0, xmm2      ; xmm0 = side_1 + side_3
ucomisd xmm0, xmm1    ; Compare (side_1 + side_3) with side_2
jbe not_triangle      ; If (side_1 + side_3) <= side_2, not a triangle

; Check side_2 + side_3 > side_1
movsd xmm0, [rsp + 8] ; Reload side_2 (assuming it was passed on the stack)
addsd xmm0, xmm2      ; xmm0 = side_2 + side_3
ucomisd xmm0, [rsp] ; Compare (side_2 + side_3) with side_1
jbe not_triangle      ; If (side_2 + side_3) <= side_1, not a triangle

; If all checks pass, it's a valid triangle
mov rax, true
jmp exit

not_triangle:
; If any check fails, it's not a valid triangle
mov rax, false
jmp exit

exit:
; Restore non-volatile registers
add rsp, 32             ; Deallocate space for local variables
pop rbp
ret