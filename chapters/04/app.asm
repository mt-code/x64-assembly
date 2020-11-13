;--
; Simple application that initialises different variables types, performs
; basic addition and stores the result into another variable.

section .data
    ;--
    ; Constants
    SYS_EXIT    equ 60

    ;--
    ; Byte (8-bit) variables.
    bVar1       db 17
    bVar2       db 9
    bResult     db 0

    ;--
    ; Word (16-bit) variables.
    wVar1       dw 17000
    wVar2       dw 9000
    wResult     dw 0

    ;--
    ; Double word (32-bit) variables.
    dVar1       dd 17000000
    dVar2       dd 9000000
    dResult     dd 0

    ;--
    ; Quad word (64-bit) variables.
    qVar1       dq 17000000
    qVar2       dq 9000000
    qResult     dd 0

section .text
    global _start
    _start:
        ;--
        ; Byte example (bVar1 + bVar2)
        mov al, byte [bVar1]
        add al, byte [bVar2]
        mov byte [bResult], al

        ;--
        ; Word example (wVar1 + wVar2)
        mov ax, word [wVar1]
        add ax, word [wVar2]
        mov word [wResult], ax

        ;--
        ; Double word example (dVar1 + dVar2)
        mov eax, dword [dVar1]
        add eax, dword [dVar2]
        mov dword [dResult], eax

        ;--
        ; Quad word example (qVar1 + qVar2)
        mov rax, qword [qVar1]
        add rax, qword [qVar2]
        mov qword [qResult], rax

        mov rax, SYS_EXIT
        mov rdi, 0 ; Exit code 0 = success
        syscall
