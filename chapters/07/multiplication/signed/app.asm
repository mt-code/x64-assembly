; Instructions
;--
; imul <src>
;--
; byte: ax = al * <src>
; word: dx:ax = ax * <src>
; dword: edx:eax = eax * <src>
; qword: rdx:rax = rax * <src>
;--
; imul <dest>, <src/imm>
;--
; byte: n/a
; word: <reg16> = <reg16>, <op8/imm>
; dword: <reg32> = <reg32>, <op32/imm>
; qword: <reg64> = <reg64>, <op64/imm>
;--
; imul <dest>, <op>, <imm>
;--
; byte: n/a
; word: <reg16> = <reg16>, <op16>, <imm>
; dword: <reg32> = <reg32>, <op32>, <imm>
; qword: <reg64> = <reg64>, <op64>, <imm>

section .data
    sys_exit equ 60

    ; word
    wNumA   dw 1200
    wNumB   dw -1200
    wAns1   dw 0
    wAns2   dw 0

    ; dword
    dNumA   dd 42000
    dNumB   dd -13000
    dAns1   dd 0
    dAns2   dd 0

    ; qword
    qNumA   dq 120000
    qNumB   dq -230000
    qAns1   dq 0
    qAns2   dq 0

section .text
    global _start

    _start:
        ;--
        ; wAns1 = wNumA * -13
        mov ax, word [wNumA]
        imul ax, -13
        mov word [wAns1], ax

        ;--
        ; wAns2 = wNumA * wNumB
        mov ax, word [wNumA]
        imul ax, word [wNumB]
        mov word [wAns2], ax

        ;--
        ; dAns1 = dNumA * 113
        mov eax, dword [dNumA]
        imul eax, 113
        mov dword [dAns1], eax

        ;--
        ; dAns2 = dNumA * dNumB
        mov eax, dword [dNumA]
        imul eax, dword [dNumB]
        mov dword [dAns2], eax

        ;--
        ; qAns1 = qNumA * 7096
        mov rax, qword [qNumA]
        imul rax, 7096
        mov qword [qAns1], rax

        ;--
        ; qAns1 = qNumA * 7096
        ; 3 operand instruction
        mov rcx, qword [qNumA]
        imul rbx, rcx, 7096     ; result stored in rbx
        mov qword [qAns1], rbx

        ;--
        ; qAns2 = qNumA * qNumB
        mov rax, qword [qNumA]
        imul rax, qword [qNumB]
        mov qword [qAns2], rax

        mov rax, sys_exit
        mov rdx, 0
        syscall
