; Tim Leavey
; Encoder


section		.data

location	db	0	; this increments as i go through the string to compare to the max size to know when it is finished (when they're equal to each other)
inputSize	db	0	; the max size of the string (compares with location)
sameCounter	db	0	; counter for characters
valueToCompare	db	0
printSizeCounter	db	0


section		.bss

userInput	resb	100
userInputLen	equ	$-userInput
outputString	resb	100


section		.text

global _start

finished:
	mov eax,4 ; sys_write
	mov ebx,1 ; stdout
	mov ecx,outputString ; pointer to the new message to print
	mov edx,0 ; number of bytes to print
	mov dl,[printSizeCounter]
	int 0x80 ; call to OS
	jmp exit

user_input:
	mov eax,3		; sys_read
	mov ebx,0		; stdin
	mov ecx,userInput	; pointer to memory to hold result
	mov edx,userInputLen	; max numbers of bytes to read in
	int 0x80		; call the OS
	mov [inputSize],byte al	; moves size of string into inputSize
	sub [inputSize],byte 1	; gets rid of the extra character tacked onto all strings
	mov eax,userInput	; moves the address of the string into eax
	mov edx,outputString	; moves pointer of outputString to edx
	jmp move		; jumps to move label

move:
	mov cl, byte [location]
	cmp cl, byte [inputSize]
	je finished
	mov ebx,[eax]
	mov [valueToCompare],bl
	jmp compare

compare:
	mov ebx,[eax]
	cmp bl,[valueToCompare]
	jne notTheSame
	inc byte [sameCounter]
	jmp increment

notTheSame:
	mov ebx, [valueToCompare]
	mov [edx],bl
	inc byte [printSizeCounter]
	inc edx
	add [sameCounter], dword 48
	mov ecx,[sameCounter]
	mov [edx],cl
	mov [sameCounter],byte 0
	inc byte [printSizeCounter]
	inc edx
	jmp move

increment:
	inc eax
	inc byte [location]
	jmp compare
	
exit:
	mov eax,1	; sys_exit
	int 0x80

_start:

	jmp user_input
