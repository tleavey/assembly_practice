section	.data

iteratorYesPls		db	0

section .text
global itoa;

; eax is integer to be converted to ASCII
; ebx is number of digits in integer
; ecx is output buffer to fill with ASCII characters
; e.g., integer 40320 gets converted to ASCII '40320'

itoa:

	mov [iteratorYesPls],bl	; move number of digits into counter
	add ecx,dword [iteratorYesPls]	; sets pointer location for reverse iteration

theLoop:

	mov ebx,dword 0		; set ebx with zeros
	mov edx,dword 0		; set edx with zeros
	mov ebx,dword 10	; move 10 into ebx for division prep
	div ebx			; eax is divided by 10
	add dl,byte '0'		; the remainder gets set to ascii char
	mov [ecx],byte dl	; move the char into output
	dec byte [iteratorYesPls]	; dec loop counter
	mov ebx,dword 0		; set ebx with zeros
	cmp [iteratorYesPls],byte 0	; end condition if counter is 0
	je exit
	dec ecx			; dec pointer so next digit is inserted correctly
	jmp theLoop
	
exit:

	ret;

