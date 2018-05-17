section .text
global factorial

; factorial function calculate N! (N factorial) for input N
;
; eax holds N, the integer to factorial
; return value N! (N factorial) stored in eax

factorial:

	push ebx		; push string size onto stack
	cmp eax,dword 0		; check to see if it is 0
	je ifZero		; if 0, jump to zero condition
	mov ecx,dword 0		; set ecx with zeros
	mov ecx,eax		; move eax into ecx

multiplyByN:

	dec ecx			; decrement ecx
	cmp ecx,byte 0		; if ecx is 0, exit
	je exit
	mul ecx			; multiply eax by ecx
	jmp multiplyByN		; go back and do it again
	
ifZero:
	mov eax,dword 1		; hardcode 1 if the input was 0
	jmp exit		; jump to exit

exit:
	pop ebx			; put string size back into ebx
	ret

