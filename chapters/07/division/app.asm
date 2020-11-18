; Division
; -
; Requires that the dividend must be larger than the divisor.
; 8-bit divisor requires 16-bit dividend
; 16-bit divisor requires 32-bit dividend
; 32-bit divisor requires 64-bit dividend
;
; For word, dword, qword division - the A & D registers must be set
; D register = upper-order
; A register = lower-order
;
; Result gets placed in A register (al,ax,eax,rax)
; Remainder gets placed in ah or D register (ah, dx, edx, rdx)
;
; div <src> (unsigned)
; idiv <src> (signed)
;----
; Unsigned:
; Set the lower-order register and zero the upper-order register
;
; Signed:
; Set the lower-order register and use a conversion to set the upper-order register (cwd,cdq,cqo)

section .data
    sys_exit equ 60

    ; bytes
    bNumA   db 63
    bNumB   db 17
    bNumC   db 5
    bAns1   db 0
    bAns2   db 0
    bRem2   db 0
    bAns3   db 0

    ; words
    wNumA   dw 4321
    wNumB   dw 1234
    wNumC   dw 167
    wAns1   dw 0
    wAns2   dw 0
    wRem2   dw 0
    wAns3   dw 0

    ; dwords
    dNumA   dd 42000
    dNumB   dd -3157
    dNumC   dd -293
    dAns1   dd 0
    dAns2   dd 0
    dRem2   dd 0
    dAns3   dd 0

    ; qwords
    qNumA   dq 730000
    qNumB   dq -13456
    qNumC   dq -1279
    qAns1   dq 0
    qAns2   dq 0
    qRem2   dq 0
    qAns3   dq 0

section .text
    global _start
    _start:
        ;--
        ; example byte operations (unsigned)

        ;--
        ; bAns1 = bNumA / 3
        mov al, byte [bNumA]
        mov ah, 0               ; zero the ah register after assigning al
        mov bl, 3
        div bl                  ; result in al, remainder in ah
        mov byte [bAns1], al

        ;--
        ; bAns2 = bNumA / bNumB (unsigned)
        mov ax, 0               ; zero the ax reg (ah:al) before assigning al
        mov al, byte [bNumA]
        div byte [bNumB]        ; result in al, remainder in ah
        mov byte [bAns2], al
        mov byte [bRem2], ah    ; ah = ax % bNumB

        ;--
        ; bAns3 = (bNumA * bNumC) / bNumB
        mov al, byte[bNumA]
        mul byte [bNumC]        ; result in ax (ah:al)
        div byte [bNumB]        ; result in al, remainder in ah
        mov byte[bAns3], al

        ;--
        ; example word operations (unsigned)

        ;--
        ; wAns1 = wNumA / 5
        mov eax, 0              ; zero the eax register before assigning ax
        mov ax, word [wNumA]
        mov bx, 5
        div bx                  ; result in ax, remainder in dx
        mov word [wAns1], ax

        ;--
        ; wAns2 = wNumA / wNumB
        mov eax, 0
        mov ax, word [wNumA]
        div word [wNumB]        ; result in ax, remainder in dx
        mov word [wAns2], ax
        mov word [wRem2], dx    ; dx = eax % wNumB

        ;--
        ; wAns3 = (wNumA * wNumC) / wNumB
        mov ax, word [wNumA]
        mul word [wNumC]        ; result in dx:ax
        div word [wNumB]        ; ax = dx:ax / wNumB
        mov word [wAns3], ax

        ;----
        ; example dword operations (signed)
        ;--
        ; REMEMBER: signed division requires the upper-order part
        ; of the dividend is set correctly with an application
        ; conversion instruction.

        ;--
        ; dAns1 = dNumA / 7 (signed)
        mov eax, dword [dNumA]
        cdq                     ; convert dword to qword, eax -> edx:eax
        mov ebx, 7
        idiv ebx                ; result in eax, remainder in edx
        mov dword [dAns1], eax

        ;--
        ; dAns2 = dNumA / dNumB (signed)
        mov eax, dword [dNumA]
        cdq                     ; convert dword to qword, eax -> edx:eax
        idiv dword [dNumB]      ; result in eax, remainder in edx
        mov dword [dAns2], eax
        mov dword [dRem2], edx

        ;--
        ; dAns3 = (dNumA * dNumC) / dNumB (signed)
        mov eax, dword [dNumA]
        imul dword [dNumC]      ; result in edx:eax
        idiv dword [dNumB]      ; result in eax, remainder in edx
        mov dword [dAns3], eax

        ;--
        ; example qword operations (signed)

        ;--
        ; qAns1 = qNumA / 9 (signed)
        mov rax, qword [qNumA]
        cqo                     ; convert qword to oword (octword)
        mov rbx, 9
        idiv rbx                ; result in rax, remainder in rdx
        mov qword [qAns1], rax

        ;--
        ; qAns2 = qNumA / qNumB (signed)
        mov rax, qword [qNumA]
        cqo
        idiv qword [qNumB]      ; result in rax, remainder in rdx
        mov qword [qAns2], rax
        mov qword [qRem2], rdx

        ;--
        ; qAns3 = (qNumA * qNumC) / qNumB (signed)
        mov rax, qword [qNumA]
        imul qword [qNumC]      ; result in rdx:rax
        idiv qword [qNumB]      ; result in rax, remainder in rdx
        mov qword [qAns3], rax

        ;exit
        mov rax, sys_exit
        mov rdx, 0
        syscall