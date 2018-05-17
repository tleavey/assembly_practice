section .bss

variable	resd	1


section .text
global atoi;

; atoi function: convert ASCII character string to integer number
;
; eax is pointer to ASCII buffer to convert
; ebx is length of buffer (number of digits)
;
; return value (integer dword) stored in eax
	
atoi:

	mov [variable],eax	; store the pointer in a variable
	mov edx,[eax]	; store the buffer into edx
	mov eax,dword 0	; set eax as all 0's
	mov al,dl	; move the first digit into al
	sub eax,'0'	; convert into decimal from ascii
	cmp bl,byte 1	; check the size of the input
	je exit	; if only 1 character, don't multiply	
	
	; The rest of this code is if there are 2 digits, not 1.

	push ebx	; save the string length
	mov ebx,[variable]	; put the pointer in ebx
	mov ecx,dword 0		; clear ecx to all zeros
	mov ecx,10		; put 10 in ecx
	mul ecx		; eax multiplied by ecx so the ten's digit is 1
	inc ebx		; increment ebx pointer to the next digit
	mov edx,[ebx]	; move the value at ebx into edx
	mov ebx,dword 0	; clear ebx to all zeros
	mov bl,dl	; move the digit into bl
	sub ebx,'0'	; subtract '0' so the ascii character becomes decimal
	add eax,ebx	; add 10 to the second digit and store in eax
	pop ebx		; put the string length back in ebx (in case needed for future)	
exit:
	ret 
