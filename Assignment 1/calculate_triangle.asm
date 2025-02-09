;*******************************************************************************************************************************
; Program name: "Triangle". This program calculates the third side of a triangle with two sides and an angle of a triangle based on user input
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
;   Program Name: Triangle
;   Programming language: One module in C, one in X86, and one in bash.
;   Date program began: 2025-Feb-06
;   Date of last update: 2025-Feb-08
;   Files in this program: geometry.c, calculate_triangle.asm, run.sh.
;   Testing: Alpha testing completed. All functions are correct.
;   Status: Ready for release to customers
;
;Purpose
;   This program is a calculator for finding the third side of a triangle based on user input
;
;This file:
;   File name: calculate_triangle.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l calculate_triangle.lis -o calculate_triangle.o calculate_triangle.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l calculate_triangle.lis -o calculate_triangle.o calculatetriangle.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double calculate_triangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declaration

extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern cos

global calculate_triangle

string_size equ 48   ; Assign string_size with 48
pi dq 3.141592653589793238462643383279502884197
two dq 2.0
straight dq 180.0


segment .data
;declared initialized arrays

prompt_for_last_name db 10, "Please enter your last name: ", 0
prompt_for_title db 10, "Please enter your title (Mr., Ms., Dr., Officer, Sergant, etc: ", 0

prompt_trig_sides db 10, "Please enter the two sides of the triangle seperated by ws: ", 0
side_format db "%lf %lf", 0
prompt_trig_angle db 10, "Please enter the angle in degrees between the two sides of the triangle: ", 0
angle_format db "%lf", 0
result_side3 db 10, "The length of the third side is %.9lf units", 10, 0   ; Rounds the float by 9 decimal places

msg db 10, "Please enjoy your triangle %s %s.", 10, 0


segment .bss
;declared empty arrays

align 64
backup_storage_area resb 832

last_name resb string_size   ; Reserving 48 byte for string input
title_name resb string_size   ; 48 byte is optimal for flexibility

side_1 resq 1   ; Reserving 1 byte for double input
side_2 resq 1
angle resq 1

segment .text

calculate_triangle:

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
mov rax, 7
mov rax, 0
xsave [backup_storage_area]

;output prompt for user input's last name
mov rax, 0
mov rdi, prompt_for_last_name
call printf

;input for user's last name
mov rax, 0
mov rdi, last_name
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline from fgets, replacing with null
mov rax, 0
mov rdi, last_name
call strlen   ; rax = length of last_name + newline
mov [last_name+rax-1], byte 0   ; rax points to the index of last_name based on the value it holds 
                                ; and replaces it with null

;output prompt for user input's title
mov rax, 0
mov rdi, prompt_for_title
call printf

;input for user's title
mov rax, 0
mov rdi, title_name
mov rsi, string_size
mov rdx, [stdin]
call fgets

;remove newline from fgets, replacing with null
mov rax, 0
mov rdi, title_name
call strlen
mov [title_name+rax-1], byte 0

input_sides:
;prompt for user's input for the two sides of the triangle
mov rax, 0
mov rdi, prompt_trig_sides
call printf

;input for user's two sides of the triangle as a string variable
mov rdi, side_format
mov rsi, side_1
mov rdx, side_2
call scanf

; Move the input values into xmm registers
movsd xmm14, [side_1]   ; Move first side into xmm14 (Dereference to get the value in side_1)
movsd xmm15, [side_2]   ; Move second side into xmm15 (Dereference to get the value in side_2)

input_angle:
; Prompt for user's input for angle between the two sides of the triangle
mov rax, 0
mov rdi, prompt_trig_angle
call printf

; Input for user's triangle angle
mov rdi, angle_format
mov rsi, angle
call scanf

; Move the input values into xmm registers
movsd xmm13, [angle]   ; Move first angle into xmm13 (Dereference to get the value in angle)

input_calculate:
; Setting values for cos(angle) (calculation: 2(side_1)(side_2)*cos(angle))
movsd xmm12, xmm14   ; Moving side_1 into xmm12
mulsd xmm12, xmm15   ; Multiplying side_1 with side_2 (a * b)
mulsd xmm12, [two]   ; Multiplying two(2.0) with xmm12 (2 * (a*b))

; Convert angle in Degrees into Radians
mulsd xmm13, [pi]   ; d = (d * 3.141592653589793238462643383279502884197)
divsd xmm13, [straight]   ; d = d/180

; Getting Cos value
mov rax, 1
movsd xmm0, xmm13
call cos   ; cos(d)
movsd xmm13, xmm0

; Getting Squared of side_1
mulsd xmm14, xmm14   ; (a*a)

; Getting Squared of side_2
mulsd xmm15, xmm15   ; (b*b)

; Getting the value of the third side
addsd xmm14, xmm15   ; a^2 + b^2
mulsd xmm13, xmm12   ; (2 *(a*b) * (cos(d)))
movsd xmm11, xmm14   ; c^2 = a^2 + b^2
subsd xmm11, xmm13   ; c^2 = a^2 + b^2 - (2 *(a*b) * (cos(d)))
sqrtsd xmm11, xmm11   ; c = sqrt(a^2 + b^2 - (2 *(a*b) * (cos(d))))

; Print third side
mov rax, 1   ; Passing 1 float number
movsd xmm0, xmm11
mov rdi, result_side3
call printf

; Print message
mov rax, 0
mov rdi, msg
mov rsi, title_name
mov rdx, last_name
call printf

; Move result to stack
mov rax, 0
push qword 0
movsd [rsp], xmm11

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send back side 3 length
movsd xmm0, [rsp]    ; Move side_3 to xmm0 to send to main
pop rax

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
mov rsp, rbp
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret