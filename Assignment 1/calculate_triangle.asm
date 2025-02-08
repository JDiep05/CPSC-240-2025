;declaration

extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern atof

global calculate_triangle

string_size equ 48
pi dq 3.141592653589793238462643383279502884197
two dq 2.0
line dq 180.0


segment .data
;declared initialized arrays

prompt_for_last_name db 10, "Please enter your last name: ", 0
prompt_for_title db 10, "Please enter your title (Mr., Ms., Dr., Officer, Sergant, etc: ", 0
greeting_msg db 10, "Hello, %s %s! Ready to find the third side of your triangle?", 10, 10, 0

trig_sides db 10, "Please enter the two sides of the triangle seperated by ws: "
trig_angle db "Please enter the angle in degrees between the two sides of the triangle: ", 0

result_side3 db 10, "The length of the third side is %.9lf units", 0
msg db 10, "Enjoy the triangle you have made %s %s.", 0


segment .bss
;declared empty arrays

align 64
backup_storage_area resb 832

last_name resb string_size
title_name resb string_size

side_1 resq 1  
side_2 resq 1


segment .text

calculate_triangle:

;backup GPRs
push rbp
mov rbp, rsp
mov rbx
mov rcx
mov rdx
mov rdi
mov rsi
mov r8
mov r9
mov r10
mov r11
mov r12
mov r13
mov r14
mov r15
pushf

;backup other registers
mov rax, 7
mov rax, 0
xsave [backup_storage_area]

;output prompt for user input's last name
mov rax, 0
mov rdi, prompt_for_last_name
call printf

;input for user's last name
mov rax, 0
mov rdi, last_name
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline from fgets, replacing with null
mov rax, 0
mov rdi, last_name
call strlen
mov [last_name+rax-1], byte 0

;output prompt for user input's title
mov rax, 0
mov rdi, prompt_for_title
call printf

;input for user's title
mov rax, 0
mov rdi, title_name
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline from fgets, replacing with null
mov rax, 0
mov rdi, title_name
call strlen
mov [title_name+rax-1], byte 0

;Greeting message for user
mov rax, 0
mov rdi, greeting_msg
mov rsi, title_name
mov rdx, last_name
call printf



input_sides:
;prompt for user's input for the two sides of the triangle
mov rax, 0
mov rdi, trig_sides
call printf

;input for user's two sides of the triangle as a string variable
sub rsp, 16    ; Allocating 16 bytes of space for two floats
mov rdi, side_input_format
mov rsi, side_1
mov rdx, side_2
call scanf

; Move the input values into xmm registers
movsd xmm14, [side_1]   ; Move first side into xmm14
movsd xmm15, [side_2]   ; Move second side into xmm15
add rsp, 16

