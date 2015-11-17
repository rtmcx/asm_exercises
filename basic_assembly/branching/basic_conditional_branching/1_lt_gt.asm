;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 1
; Write a program that takes three numbers as input: x,y,z. 
; Then it prints 1 to the console if x < y < z. It prints 0 otherwise.
;    NOTE: The comparison should be in the unsigned sense. That means for
;    example: 0x00000003 < 0x7f123456 < 0xffffffff

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
	; get the numbers
	call	read_hex	  	; read 'x' into eax
	mov 	ebx, eax		; save 'x' to ebx

	call 	read_hex		; read 'y' into eax
	mov 	ecx, eax		; save 'y' to ecx

	call 	read_hex		; read 'z' into eax

	; check if x < y (ebx < ecx)
	cmp 	ebx, ecx		; compare ebx and ecx
	jae 	zero_exit		; x is above (positiv compare) y, exit

	; x is smaller than y and the expression can still be true 
	; check if y < z (ecx < eax)
	cmp 	ecx, eax		; compare ecx, and eax
	jae 	zero_exit		; z is above (positive compare) y, exit

	; x < y < z is TRUE
	mov 	eax , 1			; print one to user
	call 	print_eax		; print the result
	
	jmp 	exit			; skip the part where eax is set to 0

zero_exit:
	mov 	eax, 0			; zero
	call 	print_eax		; print result to user

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

