all: encoder decoder

encoder: encoder.o
	ld -melf_i386 -o encoder encoder.o
encoder.o:	encoder.asm
	nasm -f elf32 -F dwarf -o encoder.o encoder.asm

decoder: decoder.o
	ld -melf_i386 -o decoder decoder.o
decoder.o:	decoder.asm
	nasm -f elf32 -F dwarf -o decoder.o decoder.asm
