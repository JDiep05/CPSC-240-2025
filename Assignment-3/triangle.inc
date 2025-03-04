%macro print_str 1
    mov rdi, %1    ; Address to print author_info
    call printf    ; Call printf function
%endmacro