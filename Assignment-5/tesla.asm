;*******************************************************************************************************************************
; Program name: "Faraday Program". This program takes three inputs and calculate the resistance and uses an EMF input to calculate the flow
; Copyright (C) 2025  Jonathan Diep                                                                                            *
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
;   Program Name: Faraday Program
;   Programming language: Three module in X86, One module in Macro, and One module in bash.
;   Date program began: 2025-Apr-10
;   Date of last update: 2025-Apr-12
;   Files in this program: faraday.asm, edison.asm, tesla.asm, acdc.inc, r.sh
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
;Purpose
;   This program takes three inputs and calculate the resistance and uses an EMF input to calculate the flow
;
;
;
;This file:
;   File name: tesla.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l tesla.lis -o tesla.o tesla.asm
;   Assemble (debug): nasm -f elf64 -gdwarf tesla.lis -o tesla.o tesla.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double tesla();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


; Declaration

global compute_resist

section .data
one dq 1.0

section .bss
    ; This segment is empty

section .text
compute_resist:

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

; Arguments: xmm1 = R1, xmm2 = R2, xmm3 = R3
; Returns xmm0 = R_total = 1 / (1/R1 + 1/(R2 + R3))

mov r12, rdi    ; Array of inputs
mov r13, rsi    ; Size of the array
mov r14, 0      ; Index/loop counter


resist_loop:
sub rsp, 8
movsd xmm13, [one]  ; initialize xmm13 as 1 and reloads it every loop
movsd xmm15, [r12 + r14*8]
divsd xmm13, xmm15
addsd xmm14, xmm13
add rsp, 8

inc r14
cmp r14, r13
jl resist_loop     ; If index < length then continue the loop
jg exit     ; If index > length then exit the loop

exit:
movsd xmm13, [one]  ; xmm13 = 1
divsd xmm13, xmm14
movsd xmm0, xmm13

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

