#!/bin/bash
nasm -f elf64 -o app.obj -l app.lst app.asm
#gcc -nostdlib -m64 -o app app.o # -nostdlib stops c library
#gcc -m64 -o app app.o

ld -melf_x86_64 -o app-dbg app.obj
ld -melf_x86_64 -o app -s app.obj # -s Strips all symbols