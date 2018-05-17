; Tim Leavey
; Decoder


section		.data

inputSize	db	0	; the max size of the string (compares with location)
sameCounter	db	0	; counter for characters
valueToStore	db	0
numberToDecrement	db	0
printSizeCounter	db	0


section		.bss

userInput	resb	100
userInputLen	equ	$-userInput
outputString	resb	100


section		.text

global _start

finished:
	mov eax,4		; sys_write
	mov ebx,1		; stdout
	mov ecx,outputString	; pointer to the new message to print
	mov edx,0		; number of bytes to print
	mov dl,[printSizeCounter]
	int 0x80		; call to OS
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
	jmp store_value		; jumps to storeValue label

store_value:
	cmp [eax],byte 0xA
	je finished
	mov ebx,[eax]
	mov [valueToStore],bl
	inc eax
	mov ebx,[eax]
	mov [numberToDecrement],ebx
	inc eax	

to_output:
	mov ebx,[valueToStore]
	mov [edx],bl
	inc edx
	dec byte [numberToDecrement]
	cmp [numberToDecrement],byte '0'
	je store_value
	jmp to_output

exit:
	mov eax,1	; sys_exit
	int 0x80

_start:

	jmp user_input
