#!/bin/bash
nasm -f elf64 -o app.o -l app.lst app.asm
#gcc -nostdlib -m64 -o app app.o # -nostdlib stops c library
#gcc -m64 -o app app.o

# -s Strips all symbols
ld -melf_x86_64 -o app -s app.o