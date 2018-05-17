section	.text
global count_digits;

; count_digits counts the number of digits in an integer value
; e.g., 1000 has 4 digits.
;
; eax contains integer value to count 
; return value (number of digits) stored in eax

count_digits:

	push ebx		; push ebx onto stack (because I like keeping this number that apparently I'm never going to use!)
	mov ebx,dword 0		; clear out ebx

divideThrough:

	mov edx,dword 0		; clear edx
	inc ebx			; using ebx as a counter so increment it
	mov ecx,dword 10	; move 10 into ecx
	div ecx			; divide the value in eax by 10
	cmp eax,dword 0		; compare if eax is 0
	jne divideThrough	; if not zero go through loop again

exit:

	mov eax,ebx		; move the number of digits into eax
	pop ebx	 		; put the original length of user input into ebx
	ret;

