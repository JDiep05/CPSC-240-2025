;*******************************************************************************************************************************
; Program name: "Harmonic Mean". This program takes user input's of non-zero floating point number and place them into an array.
; Copyright (C) 2025  Jonthan Diep                                                                                            *
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
;   File name: input_array.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l input_array.lis -o input_array.o input_array.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double input_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



extern printf

extern scanf

extern atof

global input_array

segment .data
  floatformat db "%s", 0
  invalid_float db "The last input was a non-zero and was not entered into the array. Try again.", 10, 0

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
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

xorpd xmm1, xmm1    ; Sets xmm1 as 0.0 for validate inputs
mov r15, rdi        ;storing address
mov r14, rsi        ;storing reserved size
mov r13, 0          ;count for index

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

; Convert valid float input from string to double value
mov rdi, rsp          ; Pass input to atof
call atof             ; Result in xmm0
movsd xmm15, xmm0     ; Store converted float in xmm15
ucomisd xmm15, xmm1
je invalid_input
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
