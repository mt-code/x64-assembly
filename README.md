# x64 Assembly Book

A collection of various projects throughout my journey to learn assembly via the x64-assembly book.

## Usage

Assemble the file:

```
nasm -f elf64 -o app.o -l app.lst app.asm
```

Link the file:

```
ld -melf_x86_64 -o app -s app.o
```

Alternatively, use the `compile-and-link.sh` script within the correct directory.