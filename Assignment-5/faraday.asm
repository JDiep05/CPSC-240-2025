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
;   Programming language: Two module in C, Five module in X86, and One module in bash.
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
;   File name: faraday.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm
;   Assemble (debug): nasm -f elf64 -gdwarf faraday.lis -o faraday.o faraday.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double faraday();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**




; Declarations
extern printf
extern edison

global main

segment .data
msg_1 db "Welcome to Electricity brought to you by Jonathan Diep", 10, 0
msg_2 db "This program will compute the resistance current flow in your direct circuit.", 10, 0
msg_3 db 10, "The driver recieved this number %.5lf, and will keep it until next semester.", 10, 0
msg_4 db "A zero will be returned to the Operating System", 10, 0


segment .bss
res_current resq 1


segment .text
main:

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

; Print welcoming msg
mov rax, 0
mov rdi, msg_1
call printf

; Print program's purpose msg
mov rax, 0
mov rdi, msg_2
call printf

; Call edison function
mov rax, 0
mov rdi, res_current
call edison

; Store the returned value (in xmm0) to res_current
movsd [res_current], xmm0

; Now print the message with the value
mov rax, 1
mov rdi, msg_3
movsd xmm0, [res_current]
call printf

mov rax, 0
mov rdi, msg_4
call printf

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

mov rax, 60       ; syscall: exit
mov rdi, 0        ; exit code 0
syscall