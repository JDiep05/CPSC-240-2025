;declaration

extern printf

extern atof

extern scanf

extern isfloat

extern istriangle

extern huron

global manager

segment .data
prompt_for_sides db 10, "Please enter the lengths of three sides of a triangle: ", 0
string_format db "%s %s %s", 0
sides_format db "%f %f %f", 0
float_format db 10, "%lf", 0
msg_1 db 10, "Thank you", 10, 
msg_2 db 10, "Invalid input. Please enter valid number.", 10, 0
msg_3 db 10, "These input have been tested and they are sides of a valid triangle.", 10, 0
msg_4 db 10, "The Huron formula will be applied to find the area."
msg_5 db 10, "The area is %.4lf sq units. This number will be returned to the caller module.", 10, 0

segment .bss
;declared empty arrays

align 64
backup_storage_area resb 832

side1 resb 32   ; Reserving 1 byte for double input
side2 resb 32
side3 resb 32

segment .text

manager:

; backup GPRs
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

; Backup other registers
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

ask_input:
mov rax, 0
mov rdi, prompt_for_sides
call printf

; Read three numbers as strings
mov rdi, string_format  ; "%s %s %s"
mov rsi, side1        ; First buffer
mov rdx, side2        ; Second buffer
mov rcx, side3        ; Third buffer
call scanf


; Validate and convert side1
mov rdi, side1
call isfloat
cmp rax, 0
je invalid_input
mov rdi, side1
call atof
movsd xmm12, xmm0

; Validate and convert side2
mov rdi, side2
call isfloat
cmp rax, 0
je invalid_input
mov rdi, side2
call atof
movsd xmm13, xmm0

; Validate and convert side3
mov rdi, side3
call isfloat
cmp rax, 0
je invalid_input
mov rdi, side3
call atof
movsd xmm14, xmm0

jmp next

invalid_input:
mov rax, 0
mov rdi, msg_2
call printf
jmp ask_input

next:
mov rax, 3
movsd xmm0, xmm12
movsd xmm1, xmm13
movsd xmm2, xmm14
call istriangle
cmp rax, 0
je invalid_input

mov rax, 0
mov rdi, msg_3
call printf

mov rax, 0
mov rdi, msg_4
call printf

mov rax, 3
movsd xmm0, xmm12
movsd xmm1, xmm13
movsd xmm2, xmm14
call huron

movsd xmm15, xmm0

mov rax, 1
mov rdi, msg_5
movsd xmm0, xmm15
call printf

mov rax, 0
push qword 0
movsd [rsp], xmm15

; Restoring registers
mov rax, 7
mov rax, 0
xrstor [backup_storage_area]

; Sending the area to main
movsd xmm0, [rsp]   ; Passing rsp to xmm0, xmm0 will be returned
pop rax

;Restore the GPRs
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



