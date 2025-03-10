;*******************************************************************************************************************************
; Program name: "Harmonic Mean". This program takes user input's of non-zero floating point number and place them into an array.
; Copyright (C) 2025  Jonthan Diep                                                                                           *
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
;   File name: output_array.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l output_array.lis -o output_array.o output_array.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double output_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



extern printf

global output_array

segment .data
floatformat db "%.5f ", 0

newline db 10, 0

segment .bss
    ; This segment is empty

segment .text

output_array:

; Backup GPRs
push rbp
mov rbp, rsp
push r12
push r13
push r14

mov r12, rdi    ; Storing address to r12
mov r13, rsi    ; Storing numbers of elements
mov r14, 0      ; Set r14 as counter for loop


output_loop:
cmp r14, r13    ; Compare index with length
jge output_exit ; End loop if index < length

; Print current index
sub rsp, 8
mov rdi, floatformat
movsd xmm0, [r12 + r14*8]   ; Moving current index from the selected address to xmm0 [Address + Index*byte]
mov rax, 1
call printf
add rsp, 8

inc r14             ; Increase r14 by 1
jmp output_loop     ; Calling output_loop

output_exit:
mov rax, 0
mov rdi, newline    ; Print newline after output
call printf

pop r14
pop r13
pop r12
pop rbp
ret