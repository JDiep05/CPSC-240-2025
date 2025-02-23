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
;   File name: manager.asm
;   Language: X86-64
;   Max page width: 124 columns
;   Assemble (standard): nasm -f elf64 -l manager.lis -o manager.o manager.asm
;   Assemble (debug): nasm -f elf64 -gdwarf -l manager.lis -o manager.o manager.asm
;   Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;   Prototype of this function: extern double triangle();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


extern printf

extern input_array

extern output_array

extern sum

extern sort

global manager

segment .data
info_1 db "This program will manage your arrays of 64-bit floats", 10, 0
info_2 db "For the array enter a sequence of 64-bit floats separated by white space.", 10, 0
info_3 db "After the last input press enter followed by Control+D:", 10, 0
info_4 db 10, "These numbers were received and placed into an array", 10, 0
info_5 db "The sum of the inputted number is %.9lf", 10, 0
info_6 db "The arithmetic mean of the numbers in the array is %.6lf", 10, 0
info_7 db "This is the array after the sort process completed:", 10, 0
floatformat db 10, "%lf", 10, 0 ; To test if floats are passing
intformat db 10,"%d", 10, 0     ; To test if size is working

segment .bss
align 64
backup_storage_area resb 832

my_array resq 16    ; reserve 16 quadword (128 bytes)

segment .text
manager: 

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

; Backup other registers
mov rax, 7
mov rdx, 0
xsave [backup_storage_area]

; Print first message
mov rax, 0 
mov rdi, info_1
call printf

; Print second message
mov rax, 0
mov rdi, info_2
call printf

; Print third message
mov rax, 0
mov rdi, info_3
call printf

; Calling input_array(array, size)
mov rax, 0
mov rdi, my_array   ; The name of the array
mov rsi, 16         ; The size of the array
call input_array    ; Calling the function to implement user's input into the array

mov r13, rax        ; Saving length of array

; Print fourth message
mov rax, 0
mov rdi, info_4
call printf

; Printing out the array
mov rax, 0
mov rdi, my_array   ; The array with the user's input
mov rsi, r13        ; The length of the array
call output_array   ; Function for printing out all the numbers in the array onto one line

; Calling sum function to add all the numbers in the array
mov rax, 0
mov rdi, my_array
mov rsi, r13
call sum            ; Function that will add all the numbers in the array

movsd xmm15, xmm0   ; Moving the sum result from the function into a non-violatile register

mov rax, 1          ; Passing one floating-point number
mov rdi, info_5
movsd xmm0, xmm15   ; Moving sum into xmm0 to print
call printf         ; Prints the fifth message and implementing xmm0(sum) into the placeholder

mov r14, r13        ; Backing up r13 (length of array)

cvtsi2sd xmm1, r13  ; Convert r13 (number of elements) to a double into xmm1
movsd xmm0, xmm15   ; Using sum to find the mean by dividing with count
divsd xmm0, xmm1    ; xmm0 = sum / count

mov r13, r14        ; Restoring r13 (length of array)

; Print the Mean
mov rax, 1          ; Passing one floating-point number
mov rdi, info_6     ; The mean is already in xmm0, which is needed to pass into printf
call printf         ; Prints the sixth message with the Arithmetic Mean Value

; Print seventh message
mov rax, 0
mov rdi, info_7
call printf

; Sort the array in numerical order
mov rax, 0
mov rdi, my_array
mov rsi, r13
call sort           ; A function that uses nested loop to iterate through the array and sort it numerically

; Print out the sorted array
mov rax, 0
mov rdi, my_array   ; Contains the sorted array
mov rsi, r13
call output_array   ; Passing the sorted array into the output_array function to print

; Saving xmm15 (sum) 
mov rax, 0
push qword 0        ; Reserving 8 bytes to maintain the sum
movsd [rsp], xmm15  ; Passing the sum into the reserved q word

; Restoring registers
mov rax, 7
mov rax, 0
xrstor [backup_storage_area]

; Sending the sum to main
movsd xmm0, [rsp]   ; Passing rsp to xmm0, xmm0 will be returned
pop rax

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
pop rbp
ret



