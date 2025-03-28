;*******************************************************************************************************************************
; Program name: "Non-deterministic Random Numbers". This program prompts the user for the number of values to generate, fills an array with random numbers, then normalizes and sorts the array.
; Copyright (C) 2025  Jonathan Diep                                                                                             *
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
;   Program Name: Non-deterministic Random Numbers
;   Programming language: Two module in C, Five module in X86, and One module in bash.
;   Date program began: 2025-Mar-25
;   Date of last update: 2025-Mar-27
;   Files in this program: gcc -m64 -no-pie -o main.out main.o executive.o fill_random_array.o isnan.o normalize_array.o show_array.o sort.o
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
;Purpose
;   This program prompts user for a value from 1-100 and generates random scientific decimal based on user input onto the array
;   The program will normalize the values to be between 1.0 and 2.0
;   The program will sort your array in numerical order
;
;This file:
;   File name: fill_random_array.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double fill_random_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


extern printf
extern isnan

global fill_random_array

segment .data
intformat db 10, "%d  %d", 10, 0 
int_float dq "%18.13g", 0           ; Format for decimal output

segment .bss

segment .text
fill_random_array:

; Backup GPRs
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

mov r12, rdi    ; Storing array
mov r13, rsi    ; Storing size
mov r14, 0      ; Setting r14 as 0 to use as counter

check_size:
cmp r14, r13
jl fill_array

jmp exit

fill_array:
mov rax, 0
rdrand r15      ; Function that generates a random number into r15
mov rdi, r15
push r15
push r15
movsd xmm15, [rsp]
pop r15
pop r15

movsd xmm0, xmm15
call isnan      ; Function that checks if current value is NaN
cmp rax, 0      ; Repeats loop if value is NaN
je fill_array

movsd [r12+r14*8], xmm15    ; Store random generated value into index of my_array

inc r14
jmp check_size

exit:
; Restore the GPRs
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