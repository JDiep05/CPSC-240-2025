; Program name "Huron's Triangle"
; Author: Jonathan Diep
; Author Email: jonathon.dieppp@csu.fullerton.edu
; CWID: 884973462
; Class: 240-03 Section 03
; Date program began: 2024-Mar-03
; Date of last update: 2024-Mar-08
; This file is the script file that accompanies the "Huron's Triangle" program.


%macro print_str 1
    mov rdi, %1    ; Address to print author_info
    call printf    ; Call printf function
%endmacro