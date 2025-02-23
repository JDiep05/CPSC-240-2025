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
;   Program Name: Arrays of Floating Point Numbers
;   Programming language: Two module in C, Six module in X86, and One module in bash.
;   Date program began: 2025-Feb-22
;   Date of last update: 2025-Feb-22
;   Files in this program: main.c, manager.asm, input_array.asm, output_array.asm, sum.asm, sort.asm, swap.asm, isfloat.asm, run.sh.
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
;Purpose
;   This program takes user input's of floating point number and place them into an array.
;   The program will calculate the sum, the mean, and sort the array.
;
;This file:
;   File name: swap.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l swap.lis -o swap.o swap.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l swap.lis -o swap.o swap.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double swap();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



global swap

segment .data
    ; This segment is empty
segment .bss
    ; This segment is empty
segment .text

swap:

movsd xmm0, [rdi]    ; xmm0 = *a
movsd xmm1, [rsi]    ; xmm1 = *b

; Write swapped values back to memory
movsd [rdi], xmm1    ; *a = xmm1
movsd [rsi], xmm0    ; *b = xmm0
ret