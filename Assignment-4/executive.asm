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
;   File name: executive.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l executive.lis -o executive.o executive.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l executive.lis -o executive.o executive.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double executive();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


; Declaration
extern printf
extern scanf
extern fgets
extern stdin
extern strlen
extern sort
extern show_array
extern normalize_array
extern fill_random_array

global executive

string_size equ 24

segment .data
prompt_name db 10,"Please enter your name: ", 0
prompt_title db "Please enter your title (Mr, Ms, Sergeant, Chief, Project Leader, etc.): ", 0
msg_1 db "Nice to meet you %s %s", 10, 0
msg_2 db 10,"This program will generate 64-bit IEEE float numbers.", 10, 0
prompt_num db "How many numbers do you want. Today's limit is 100 per customer. ", 0
invalid_msg db 10, "Input size is under 0 or over 100. Please try again.", 10, 0
int_format db "%d", 0
msg_3 db "Your numbers have been stored in an array. Here is that array.", 10, 0
msg_4 db 10,"The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array", 10, 0
msg_5 db 10,"The array will now be sorted", 10, 0
msg_6 db 10,"Goodbye %s %s. You are welcome anytime.", 10, 0

segment .bss
align 64
backup_storage_area resb 832

name resb string_size
title resb string_size
my_array resq 100

segment .text
executive:

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

; Backup other registers
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

; Prompt text msg for user's input for name
mov rax, 0
mov rdi, prompt_name
call printf

; Ask user's input for name variable
mov rax, 0
mov rdi, name
mov rsi, string_size
mov rdx, [stdin]
call fgets

; Remove newline from fgets function
mov rax, 0
mov rdi, name
call strlen
mov [name+rax-1], byte 0

mov rax, 0
mov rdi, prompt_title
call printf

; Prompts for user's input for title
mov rax, 0
mov rdi, title
mov rsi, string_size
mov rdx, [stdin]
call fgets

; Remove newline from fgets function
mov rax, 0
mov rdi, title
call strlen
mov [title + rax - 1], byte 0

; Print greeting message with User's title and name
mov rax, 0
mov rdi, msg_1
mov rsi, title
mov rdx, name
call printf

mov rax, 0
mov rdi, msg_2
call printf

size_input:
mov rax, 0
mov rdi, prompt_num
call printf

; Reserving 16 bytes for scanf
push qword 0
push qword 0
mov rax, 0
mov rdi, int_format
mov rsi, rsp
call scanf
mov r15, [rsp]
pop rax
pop rax

; If r15 < 1 will jump to invalid_input block
cmp r15, 1
jl invalid_input

; If r15 > 100 will jump to invalid_input block
cmp r15, 100
jg invalid_input

jmp continue

invalid_input:
; Invalid block if input was rejected, causing a re-loop for a proper input
mov rax, 0
mov rdi, invalid_msg
call printf
jmp size_input

continue:
; Function that will generate the amount of random numbers into the array based on user's input
mov rax, 0
mov rdi, my_array
mov rsi, r15
call fill_random_array

mov rax, 0
mov rdi, msg_3
call printf

; Prints the random numbers generated into the array
mov rax, 0
mov rdi, my_array
mov rsi, r15
call show_array

; Reduces the array into numbers between 1.0 - 2.0
mov rax, 0
mov rdi, my_array
mov rsi, r15
call normalize_array

mov rax, 0
mov rdi, msg_4
call printf

; Print the normalized array
mov rax, 0
mov rdi, my_array
mov rsi, r15
call show_array

; Pushing array into sort to reorder array into numerical order
mov rax, 0
mov rdi, my_array
mov rsi, r15
call sort

mov rax, 0
mov rdi, msg_5
call printf

; Print the sorted array
mov rax, 0
mov rdi, my_array
mov rsi, r15
call show_array

; Prints Goodbye message with user's title and name
mov rax, 0
mov rdi, msg_6
mov rsi, title
mov rdx, name
call printf

mov rax, 7
mov rdx, 0
xrstor [backup_storage_area]

; Name is returned back to main
mov rax, name

;Restore the GPRs
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