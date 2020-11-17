; Instructions
;--
; mul <src>
;--
; byte: ax = al * <src>
; word: dx:ax = ax * <src>
; dword: edx:eax = eax * <src>
; qword: rdx:rax = rax * <src>

section .data
    sys_exit equ 60

    bNumA   db 42
    bNumB   db 73
    wAns1   dw 0
    wAns2   dw 0

    wNumA   dw 4321
    wNumB   dw 1234
    dAns2   dd 0

    dNumA   dd 42000
    dNumB   dd 73000
    qAns3   dq 0

section .text
    global _start
    _start:
        ;--
        ; wAns1 = bNumA^2
        mov al, byte [bNumA]
        mul al                      ; result in ax
        mov word [wAns1], ax

        ;--
        ; wAns2 = bNumA * bNumB
        mov al, byte [bNumA]
        mul byte [bNumB]            ; result in ax
        mov word [wAns2], ax

        ;--
        ; dAns2 = wNumA * wNumB
        mov ax, word [wNumA]
        mul word [wNumA]            ; result in dx:ax
        mov word [dAns2], ax
        mov word [dAns2 + 2], dx

        ;--
        ; qAns3 = dNumA * dNumB
        mov eax, dword [dNumA]
        mul dword [dNumB]           ; result in edx:eax
        mov dword [qAns3], eax
        mov dword [qAns3 + 4], edx

        ; exit
        mov rax, sys_exit
        mov rdx, 0
        syscall