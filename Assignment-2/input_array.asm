extern printf

extern scanf

extern atof

extern isfloat

global input_array

segment .data
  floatformat db "%s", 0
  invalid_float db "The last input was invalid and not entered into the array. Try again.", 10, 0

segment .bss      ;Declare pointers to un-initialized space in this segment.
  align 64
  backup_storage_area resb 832
  
segment .text

input_array:

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

;backup other registers/sse registers
mov rax,7
mov rdx,0
xsave [backup_storage_area]

mov r15, rdi    ;storing address
mov r14, rsi    ;storing reserved size
mov r13, 0      ;count for index

get_input:
; Prompt user for input
push qword 0
push qword 0
mov rax, 0
mov rdi, floatformat
mov rsi, rsp           ; Store user input at rsp
call scanf             ; Read user input

; Check for Control+D input
cdqe
cmp rax, -1           
je exit_input         ; If EOF, exit input loop

; Check for valid input as a floating-point number
mov rdi, rsp          ; Pass user input to isfloat
call isfloat
cmp rax, 0            ; If not a float, show error
je invalid_input      ; Jump if invalid input

; Convert valid float input from string to double value
mov rdi, rsp          ; Pass input to atof
call atof             ; Result in xmm0
movsd xmm15, xmm0     ; Store converted float in xmm15
pop r9
pop r9

; Check if input is full
cmp r13, r14          ; Compare index to max size
jge array_full        ; Stops input process if array is full

; Store float in array
movsd [r15 + r13*8], xmm15  ; Store float in array [address + index*byte]
inc r13
jmp get_input         ; Loop input

invalid_input:
; Print error message
mov rax, 0
mov rdi, invalid_float
call printf
pop r9
pop r9

jmp get_input         ; Loop input

array_full:
; The array is full, exit input loop
pop r9
pop r9
jmp exit_input

exit_input:
pop r9
pop r9
; Restore registers
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]  ; Restore SSE registers

mov rax, r13   ; Store array length in rax to return

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
