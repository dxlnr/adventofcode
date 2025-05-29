BITS 64 

%define SYS_EXIT 60

global _start
section .text

_start:
    mov rax, SYS_EXIT
    mov rdi, 10
    syscall
