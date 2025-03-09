;*******************************************************************************************************************************
; Program name: "Huron's Triangle". This program takes user input's of sides to create a triangle and output the area of the triangle.
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
;   Program Name: Huron's Triangle
;   Programming language: One module in C, Four module in X86, and One module in bash.
;   Date program began: 2025-Mar-03
;   Date of last update: 2025-Mar-08
;   Files in this program: triangle.c, huron.asm, isfloat.asm, istriangle.asm, manager.asm, triangle.inc, r.sh
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
;Purpose
;   This program takes three number inputs as sides to create a valid triangle
;   The program will calculate the area of the triangle
;
;This file:
;   File name: istriangle.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l istriangle.lis -o istriangle.o istriangle.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l istriangle.lis -o istriangle.o istriangle.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double istriangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



global istriangle

true equ 1
false equ 0

segment .data
    ; This segment is empty

segment .bss
    ; This segment is empty

segment .text

istriangle:
push rbp
mov rbp, rsp
sub rsp, 32             ; Allocating 32 bytes for sides argument
movsd xmm11, xmm0       ; side_1 - a
movsd xmm12, xmm1       ; side_2 - b
movsd xmm13, xmm2       ; side_3 - c

; Check triangle inequality: side_1 + side_2 > side_3
movsd xmm0, xmm11       ; Moving side_1 for calculation
addsd xmm0, xmm12       ; xmm0 = (side_1) + side_2
ucomisd xmm0, xmm13     ; Compare (side_1 + side_2) with side_3
jbe not_triangle        ; If (side_1 + side_2) <= side_3, not a triangle

; Check side_1 + side_3 > side_2
movsd xmm0, xmm11       ; Reload side_1
addsd xmm0, xmm13       ; xmm0 = side_1 + side_3
ucomisd xmm0, xmm12     ; Compare (side_1 + side_3) with side_2
jbe not_triangle        ; If (side_1 + side_3) <= side_2, not a triangle

; Check side_2 + side_3 > side_1
movsd xmm0, xmm12       ; Reload side_2
addsd xmm0, xmm13       ; xmm0 = side_2 + side_3
ucomisd xmm0, xmm11     ; Compare (side_2 + side_3) with side_1
jbe not_triangle        ; If (side_2 + side_3) <= side_1, not a triangle

; If all checks pass, it's a valid triangle
jmp valid_triangle      ; Jump to exit block to return back to manager.asm

not_triangle:
; If any check fails, it's not a valid triangle
mov rax, false          ; Return False (0)
add rsp, 32             ; Deallocate bytes for local variables
pop rbp
ret

valid_triangle:
; Restore non-volatile registers
mov rax, true           ; Return True (1)
add rsp, 32             ; Deallocate bytes for local variables
pop rbp
ret