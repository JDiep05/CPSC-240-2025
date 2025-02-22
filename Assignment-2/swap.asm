global swap

segment .data
    ; This segment is empty
segment .bss
    ; This segment is empty
segment .text

swap:

movsd xmm0, [rdi]    ; xmm0 = *a
movsd xmm1, [rsi]    ; xmm1 = *b

; Write swapped values back to memory
movsd [rdi], xmm1    ; *a = xmm1
movsd [rsi], xmm0    ; *b = xmm0
ret