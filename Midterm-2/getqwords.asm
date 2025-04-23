;Name: Jonathan Diep
;Cwid: 884973462
;Email: jonathon.dieppp@csu.fullerton.edu
;Date: Apr 23 2025
;Program: Final program.

global getqwords

section .text
getqwords:
    ; rdi has address
    mov rax, [rdi]   ; read quadword from memory
    ret
