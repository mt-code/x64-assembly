section .data
    ; bAns1 = bNum1 + bNum2
    bAns1   db 0
    bNum1   db 68
    bNum2   db 9

    ; bAns2 = bNum3 - bNum4
    bAns2   db 0
    bNum3   db 50
    bNum4   db 13

    ; wAns1 = bNum5 * bNum6
    wAns1   dw 0
    bNum5   db 5
    bNum6   db 7

    ; bAns3 = bNum1 / bNum5
    bAns3   db 0

    ; bRem1 = wNum1 % bNum5
    bRem1   db 0
    wNum1   dw 127

section .text
    global _start
    _start:
        ;--
        ; bAns1 = bNum1 + bNum2
        mov al, byte [bNum1]
        add al, byte [bNum2]
        mov byte [bAns1], al

        ;--
        ; bAns2 = bNum3 - bNum4
        mov al, byte [bNum3]
        sub al, byte [bNum4]
        mov byte [bAns2], al

        ;--
        ; wAns1 = bNum5 * bNum6
        mov al, byte [bNum5]
        mul byte [bNum6]
        mov word [wAns1], ax

        ;--
        ; bAns3 = bNum1 / bNum5
        mov al, byte [bNum1]
        mov ah, 0
        div byte [bNum5]
        mov byte [bAns3], al

        ;--
        ; bRem1 = wNum1 % bNum5
        mov al, byte [wNum1]
        mov ah, 0
        div byte [bNum5]
        mov byte [bRem1], ah

    exit:
        mov rax, 60 ; sys_exit
        mov rdx, 0 ; success
        syscall