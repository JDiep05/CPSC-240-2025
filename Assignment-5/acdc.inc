; ====================================================
; Macro: convert_res_to_array
; Purpose: Convert 3 resistance strings to floats,
;          store in float array
; Arguments:
;   %1 = input1 string
;   %2 = input2 string
;   %3 = input3 string
;   %4 = array label to store converted floats
; Output:
;   [%4 + 0]   = double of input1
;   [%4 + 8]   = double of input2
;   [%4 + 16]  = double of input3
; ====================================================

%macro get_res 4
    ; Convert input1
    mov rdi, %1
    call atof
    movsd [%4], xmm0

    ; Convert input2
    mov rdi, %2
    call atof
    movsd [%4 + 8], xmm0

    ; Convert input3
    mov rdi, %3
    call atof
    movsd [%4 + 16], xmm0
%endmacro
