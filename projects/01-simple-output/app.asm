;--
; https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md
;--

section .data
    ;--
    ; Syscalls
    SYS_EXIT        equ 60 ; # 0x3C
    SYS_WRITE       equ 1

    ;--
    ; Strings
    STR_HELLOWORLD  db 'Hello, World!'

section .text
    global _start
    _start:
        mov rax, SYS_WRITE
        mov rdi, 1  ; Standard output file descriptor
        mov rsi, STR_HELLOWORLD
        mov rdx, 13 ; Length of our string
        syscall

        mov rax, SYS_EXIT
        mov rdi, 0x0
        syscall


