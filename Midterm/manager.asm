; Jonathan Diep
; CPSC 240-03
; March 10, 2025 
; jonathon.dieppp@csu.fullerton.edu


;declaration

extern printf

extern input_array

extern output_array

extern sum_reciprocals

global manager

segment .data
msg_1 db "Welcome to Harmonic Means!", 10, 0
msg_2 db 10, "For the array enter a sequence of non-zero float numbers separated by white space.", 10, 0
msg_3 db "After the last input press enter followed by Control+D to exit:", 10, 0
msg_4 db "The Sum of Reciprocals of the numbers in the array is %.5lf", 10, 0
msg_5 db "This is the Harmonic Mean of the numbers in the array: %.5lf", 10, 0
msg_6 db "The Harmonic Mean will now be returned to main.", 10, 0
msg_array db 10,"These non-zero numbers were received and added into the array", 10, 0

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

; Backup other registers
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

mov rax, 0
mov rdi, msg_1
call printf

mov rax, 0
mov rdi, msg_2
call printf

mov rax, 0
mov rdi, msg_3
call printf

mov rax, 0
mov rdi, my_array
mov rsi, 16
call input_array

mov r13, rax        ; Saving array length into non-violatile register for later useful

mov rax, 0
mov rdi, msg_array
call printf

mov rax, 0
mov rdi, my_array
mov rsi, r13
call output_array

mov rax, 0
mov rdi, my_array
mov rsi, r13
call sum_reciprocals

movsd xmm15, xmm0   ; Saving sum of reciprocal to non-violatile register

mov rax, 1
mov rdi, msg_4
movsd xmm0, xmm15
call printf

cvtsi2sd xmm0, r13  ; Convert r13 (number of elements) to a double into xmm1
divsd xmm0, xmm15   ; (length of array) / (sum of reciprocals)
movsd xmm14, xmm0   ; Saving the harmonic mean in non-violatile register

mov rax, 1
mov rdi, msg_5
movsd xmm0, xmm14
call printf

mov rax, 0
mov rdi, msg_6
call printf

; Saving xmm14 (harmonic mean) 
mov rax, 0
push qword 0        ; Reserving 8 bytes to maintain the sum
movsd [rsp], xmm14  ; Passing the sum into the reserved q word

; Restoring registers
mov rax, 7
mov rax, 0
xrstor [backup_storage_area]

; Sending the sum to main
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