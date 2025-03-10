;*******************************************************************************************************************************
; Program name: "Arrays of Floating Point Numbers". This program takes user input's of floating point number and place them into an array.
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
;   File name: sum_reciprocals.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l sum_reciprocals.lis -o sum_reciprocals.o sum_reciprocals.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l sum_reciprocals.lis -o sum_reciprocals.o sum_reciprocals.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double sum_reciprocals();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



global sum_reciprocals

segment .data
one dq 1.0

segment .bss
align 64
backup_storage_area resb 832

segment .text

sum_reciprocals:

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
mov rax,7
mov rdx,0
xsave [backup_storage_area]

mov r12, rdi
mov r13, rsi
mov r14, 0    ; Index/loop counter

sum_loop:
sub rsp, 8
movsd xmm13, qword [one]    ; Add 1.0 to xmm13 to divide number and reloads 1.0 after calculation
movsd xmm15, [r12 + r14*8]
divsd xmm13, xmm15          ; xmm13 = 1.0 / xmm15
addsd xmm14, xmm13
add rsp, 8

inc r14
cmp r14, r13
jl sum_loop     ; If index < length then continue the loop
jg sum_exit     ; If index > length then exit the loop

sum_exit:
movsd xmm0, xmm14
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
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret