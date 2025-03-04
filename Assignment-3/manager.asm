;declaration

extern printf

extern atof

extern scanf

extern isfloat

extern istriangle

extern huron

%include "triangle.inc" 

global manager

segment .data
author_info db 10, "This program is brought to you as a courtesy of", 10 ,\
                    "Author: Jonathan Diep", 10 ,\
                     "CWID: 884973462", 10 ,\
                     "Email: jonathon.dieppp@csu.fullerton.edu", 10, 0

prompt_for_sides db 10, "Please enter the lengths of three sides of a triangle: ", 0
string_format db "%s %s %s", 0
sides_format db "%f %f %f", 0
float_format db 10, "%lf", 0
msg_1 db 10, "Thank you", 10, 
msg_2 db 10, "Error input try again", 10, 0
msg_3 db 10, "These input have been tested and they are sides of a valid triangle.", 10, 0
msg_4 db 10, "The Huron formula will be applied to find the area.", 10, 0
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
print_str author_info  ; Use macro to print author_info
; Backup GPRs and other registers
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

mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

ask_input:
mov rax, 0
mov rdi, prompt_for_sides
call printf

; Read three numbers as strings
mov rdi, string_format  ; "%s %s %s"
mov rsi, side1          ; First side
mov rdx, side2          ; Second side
mov rcx, side3          ; Third side
call scanf

; Validate and convert side1
mov rdi, side1          ; Passing side1 as argu for isfloat function
call isfloat            ; Function to check if argu is a float-point number
cmp rax, 0              ; If returned false will prompt invalid_msg
je invalid_input        ; Jump to invalid_input block
mov rdi, side1          ; Passing side1 as argu for string conversion into float-point number
call atof               ; Function to convert string into float-point number
movsd xmm12, xmm0       ; Saving side1 into a non-violatile register

; Validate and convert side2
mov rdi, side2          ; Passing side2 as argu for isfloat function
call isfloat            ; Function to check if argu is a float-point number
cmp rax, 0              ; If returned false will prompt invalid_msg
je invalid_input        ; Jump to invalid_input block
mov rdi, side2          ; Passing side2 as argu for string conversion into float-point number
call atof               ; Function to convert string into float-point number
movsd xmm13, xmm0       ; Saving side2 into a non-violatile register

; Validate and convert side3
mov rdi, side3          ; Passing side3 as argu for isfloat function
call isfloat            ; Function to check if argu is a float-point number
cmp rax, 0              ; If returned false will prompt invalid_msg
je invalid_input        ; Jump to invalid_input block
mov rdi, side3          ; Passing side3 as argu for string conversion into float-point number
call atof               ; Function to convert string into float-point number
movsd xmm14, xmm0       ; Saving side3 into a non-violatile register

; Call istriangle to validate the sides
movsd xmm0, xmm12       ; Passing side1
movsd xmm1, xmm13       ; Passing side2
movsd xmm2, xmm14       ; Passing side3
call istriangle         ; Function using the three side args to check if the side make a vaild triangle
cmp rax, 0              ; If returned false will prompt invalid_msg
je invalid_input        ; Jump to invalid_input block

jmp next                ; If returned true will jump to next

invalid_input:
mov rax, 0
mov rdi, msg_2          ; Display invalid_msg and prompt for re-input
call printf
jmp ask_input           ; Loop back to input

next:
mov rax, 0
mov rdi, msg_1          ; Display thank you msg
call printf

mov rax, 0
mov rdi, msg_3          ; Display msg for valid triangle
call printf

mov rax, 0
mov rdi, msg_4          ; Display msg for Heron's formula
call printf

; Call huron to calculate the area
movsd xmm0, xmm12       ; Passing side1
movsd xmm1, xmm13       ; Passing side2
movsd xmm2, xmm14       ; Passing side3
call huron              ; Function using Heron's formula to calculate for triangle's area with the three sides
movsd xmm15, xmm0       ; Saving area into non-violatile register

; Print the area
mov rax, 1              ; Passing one float-point value
mov rdi, msg_5          ; Display triangle's area msg
movsd xmm0, xmm15       ; Pass xmm15 to xmm0 to call printf
call printf

; Return the area to the caller
mov rax, 0
push qword 0            ; Reserving 8 bytes to push triangle's area
movsd [rsp], xmm15      ; Saving xmm15 into [rsp] (area)

; Restore registers
mov rax, 7
mov rax, 0
xrstor [backup_storage_area]

; Return the area in xmm0
movsd xmm0, [rsp]       ; Moving [rsp] to xmm0 to return to main
pop rax

; Restore GPRs
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
