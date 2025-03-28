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
;   File name: isnan.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l isnan.lis -o isnan.o isnan.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double isnan();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global isnan

segment .data

segment .bss

segment .text
isnan:

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

movsd xmm15, xmm0
ucomisd xmm15, xmm15
jp nan          ; If xmm15 is NaN will return a 0
mov rax, 1      ; If xmm15 is not NaN will return 1
jmp exit


nan:
mov rax, 0


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