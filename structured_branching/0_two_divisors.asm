;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 0
; Write a program that takes the number n as input. Then it prints all the
; numbers x below n that have exactly 2 different integral divisors (Besides 1 and x).
;   
; For example: 15 is such a number. It is divisible by 1,3,5,15. (Here 3 and 5
; are the two different divisiors, besides 1 and 15).

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
	call	read_hex	  	; read 'x' into eax
	mov 	ebx, eax		; save 'x' to ebx
	inc	ebx			; add one for looping

	mov 	ecx, 1			; the main counter
	
	mov 	esi, 0			; keep count of how many divisors 'x' have

div_loop:	
	mov	eax, ecx		; variable for div_test
	call	divisor			; check how many divisors 'x' have

	inc	ecx			; increase counter
	cmp	ecx, ebx		; have we reached 'x' yet
	jne	div_loop		; no, next iteration please

	jmp	exit			; end of the loop

	;STUB	
divisor:	; check how many divisors number in eax have..
	call 	print_eax		; print the number
	ret				; return

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

