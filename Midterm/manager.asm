
;*******************************************************************************************************************************
; Program name: "Harmonic Mean". This program takes user input's of non-zero floating point number and place them into an array.
; Copyright (C) 2025  Jonthan Diep                                                                                             *
;                                                                                                                              *
; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License    *
; as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.        *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty  *
; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                *
; You should have received a copy of the GNU General Public License along with this program.  If not, see                      *
; <https://www.gnu.org/licenses/>.                                                                                             *
;*******************************************************************************************************************************



;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author information
;   Author name : Jonathan Diep
;   Author email: jonathon.dieppp@csu.fullerton.edu
;   CWID : 884973462
;   Class: 240-03 Section 03
; Program Information
;   Program Name: Harmonic Mean
;   Programming language: One module in C, Three module in X86, and One module in bash.
;   Date program began: 2025-Mar-10
;   Date of last update: 2025-Mar-10
;   Files in this program: driver.c, manager.asm, input_array.asm, output_array.asm, sum_reciprocals.asm, r.sh
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
;Purpose
;   This program takes user input's of non-zero floating point number and place them into an array.
;   The program will calculate the sum of reciprocal and the harmonic mean of the array.
;
;This file:
;   File name: manager.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l manager.lis -o manager.o manager.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double triangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



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