#!/bin/bash

nasm -g -f elf -F dwarf -o $1.o $1.asm

ld $1.o -m elf_i386 -o $1


./$1
