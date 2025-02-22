extern printf

extern input_array

extern output_array

extern sum

extern sort

global manager

segment .data
info_1 db "This program will manage your arrays of 64-bit floats", 10, 0
info_2 db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
info_3 db "After the last input press enter followed by Control+D:", 10, 0
info_4 db "These numbers were received and placed into an array", 10, 0
info_5 db "The sum of the inputted number is %.9lf", 10, 0
info_6 db "The arithmetic mean of the numbers in the array is %.6lf", 10, 0
info_7 db "This is the array after the sort process completed:", 10, 0
floatformat db 10, "%lf", 10, 0

segment .bss
align 64
backup_storage_area resb 832

my_array resq 16    ; reserve 16 quadword (128 bytes)

segment .text
manager: 

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
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

mov rax, 0 
mov rdi, info_1
call printf

mov rax, 0
mov rdi, info_2
call printf

mov rax, 0
mov rdi, info_3
call printf

mov rax, 0
mov rdi, my_array
mov rsi, 16
call input_array

mov r13, rax

mov rax, 0
mov rdi, info_4
call printf

mov rax, 0
mov rdi, my_array
mov rsi, r13
call output_array

mov rax, 0
mov rdi, my_array
mov rsi, r13
call sum

mov rax, 1
mov rdi, info_5
call printf

movsd xmm15, xmm0   ; Move sum of array to non-volatile register for later use
mov r14, r13        ; Backing up r13

; Convert r13 (int count) to a double
cvtsi2sd xmm1, r13  ; Convert r13 (number of elements) to a double into xmm1

; Compute mean = sum / count
divsd xmm0, xmm1    ; xmm0 = sum / count

mov r13, r14        ; Restoring r13

; Print mean
mov rax, 1
mov rdi, info_6
call printf

mov rax, 0
mov rdi, info_7
call printf

mov rax, 0
mov rdi, my_array
mov rsi, r13
call sort

mov rax, 0
mov rdi, my_array
mov rsi, r13
call output_array

mov rax, 0
push qword 0
movsd [rsp], xmm15

mov rax, 7
mov rax, 0
xrstor [backup_storage_area]

movsd xmm0, [rsp]
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



