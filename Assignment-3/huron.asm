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
;   Programming language: One module in C, Four module in X86, One in macro, and One module in bash.
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
;   File name: huron.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l huron.lis -o huron.o huron.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l huron.lis -o huron.o huron.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double huron();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



global huron

segment .data
half dq 0.5     ; variable of one-half for later calculation
float_format db "%lf", 10,0


segment .bss
align 64
backup_storage_area resb 832


segment .text

huron:

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

;backup other registers
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

sub rsp, 32                 ; Allocating 32 bytes for sides
movsd xmm12, xmm0           ; xmm12 = a
movsd xmm13, xmm1           ; xmm13 = b
movsd xmm14, xmm2           ; xmm14 = c

; Calculate the semi-perimeter (s = (a + b + c) / 2)
addsd xmm15, xmm12          ; xmm15 = a
addsd xmm15, xmm13          ; xmm15 = a + b
addsd xmm15, xmm14          ; xmm15 = a + b + c
mulsd xmm15, [half]         ; xmm15 = (a + b + c) * 0.5 = s

; Calculate (s - a), (s - b), and (s - c)
movsd xmm11, xmm15          ; xmm4 = s
subsd xmm11, xmm12          ; xmm4 = s - a

movsd xmm10, xmm15          ; xmm5 = s
subsd xmm10, xmm13          ; xmm5 = s - b

movsd xmm9, xmm15           ; xmm6 = s
subsd xmm9, xmm14           ; xmm6 = s - c

mulsd xmm11, xmm10          ; xmm4 = (s - a) * (s - b)
mulsd xmm11, xmm9           ; xmm4 = (s - a) * (s - b) * (s - c)
mulsd xmm11, xmm15          ; xmm4 = s * (s - a) * (s - b) * (s - c)
sqrtsd xmm11, xmm11         ; xmm15 = sqrt(s * (s - a) * (s - b) * (s - c))

movsd xmm0, xmm11           ; Moving xmm15 to xmm0 to return the area of the triangle.
movsd [rsp], xmm0
; Restore registers
mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

movsd xmm0, [rsp]
add rsp, 32                 ; Deallocate bytes for variable

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