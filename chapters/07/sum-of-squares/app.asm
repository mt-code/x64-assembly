section .data
    ; Constants
    SUCCESS     equ 0
    SYS_EXIT    equ 60

    ; Vars
    n dd 10
    sumOfSquares dq 0

section .text
    global _start
    _start:
        ;--
        ; Compute sum of squares from 1 to n (inclusive).
        ;
        ; Approach:
        ; for (i = 1; i <= n; i++)
        ;     sumOfSquares += i ^ 2;
        mov rbx, 1              ; i
        mov ecx, dword [n]

    sumLoop:
        mov rax, rbx
        mul rax
        add qword[sumOfSquares], rax
        inc rbx                 ; i++

        ; These 3 instructions can be shortened to:
        ; loop sumLoop
        dec ecx
        cmp ecx, 0
        jne sumLoop

    last:
        mov rax, SYS_EXIT
        mov rdx, SUCCESS
        syscall


