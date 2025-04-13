%include "acdc.inc"

extern printf
extern atof
extern compute_resist
extern fgets
extern strlen
extern stdin
extern scanf

global edison

string_size equ 48

section .data
prompt_name db "Please enter your full name: ", 0
prompt_career db "Please enter the career path you are following: ", 0
thank_career db "Thank you. We appreciate all %s", 10, 0
prompt_resist db "Please enter the resistance in ohms on each of the three sub-circuits separated by ws.", 10, 0
total_resist db "The total resistance of the full circuit is computed to be %.7lf ohms.", 10, 0
emf_msg db 10, "EMF is constant on every branch of any circuit.", 10, 0
prompt_emf db "Please enter the EMF of this circuit in volts: ", 0
thank_you db "Thank you.", 10, 0
result_msg db 10, "The current flowing in this circuit has been computed: %.8lf amps", 10, 0
farewell db 10, "Thank you %s for using the program Electricity.", 10, 0

string_format db "%s %s %s", 0
single_format db "%s", 0
float_format db "%lf", 0

section .bss
align 64
backup_storage_area resb 832

input1 resb 32
input2 resb 32
input3 resb 32
emf_input resb 32
res_array resq 3

name resb string_size   ; Reserving 48 byte for string input
career resb string_size   ; 48 byte is optimal for flexibility

section .text

edison:
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
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

; ===== Prompt and read name =====
mov rax, 0
mov rdi, prompt_name
call printf

mov rax, 0
mov rdi, name
mov rsi, string_size
mov rdx, [stdin]
call fgets

mov rax, 0
mov rdi, name
call strlen
mov byte [name + rax - 1], 0   ; remove newline

; ===== Prompt and read career =====
mov rax, 0
mov rdi, prompt_career
call printf

mov rax, 0
mov rdi, career
mov rsi, string_size
mov rdx, [stdin]
call fgets

mov rax, 0
mov rdi, career
call strlen
mov byte [career + rax - 1], 0

; ===== Print appreciation =====
mov rax, 0
mov rdi, thank_career
mov rsi, career
call printf

; ===== Prompt for input =====
mov rax, 0
mov rdi, prompt_resist
call printf

; Read three numbers as strings
mov rdi, string_format  ; "%s %s %s"
mov rsi, input1          ; First input
mov rdx, input2          ; Second input
mov rcx, input3          ; Third input
call scanf

; ===== Sending input to macro =====
get_res input1, input2, input3, res_array   ; Calling macro file wtih four arguments
                                            ; Macro will convert it from string to float numbers
                                            ; Adds the input into an array

; ===== Calculating Resistance =====
mov rax, 0
mov rdi, res_array
mov rsi, 3      ; Size of the array is three
call compute_resist
movsd xmm15, xmm0   ; Saving value in a non-violatile register

; ===== Printing Total Resistance =====
mov rax, 1
mov rdi, total_resist
movsd xmm0, xmm15
call printf

; ===== Prompt and read EMF =====
mov rax, 0
mov rdi, prompt_emf
call printf

mov rax, 0
mov rdi, single_format
mov rsi, emf_input
call scanf

mov rdi, emf_input
call atof
movsd xmm14, xmm0

; ===== Thank the user =====
mov rax, 0
mov rdi, thank_you
call printf

; ===== Compute current I = E / R =====
divsd xmm14, xmm15

; ===== Print current =====
mov rax, 1
mov rdi, result_msg
movsd xmm0, xmm14
call printf

; ===== Print farewell =====
mov rax, 0
mov rdi, farewell
mov rsi, name
call printf

; ===== Return result to faraday =====
mov rax, 0
push qword 0
movsd [rsp], xmm14

; Restore registers
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

movsd xmm0, [rsp]
pop rax

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