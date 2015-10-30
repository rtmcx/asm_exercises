;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 0.0  
; Write a program that takes the value n as input, and finds the sum of 
; all the odd numbers between 1 and 2n+1, inclusive.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:

	call	read_hex	  	; read 'n' into eax
	mov 	ebx, 0x2		; 
	mul 	ebx 			; n*2 
	inc 	eax 			; 2n +1

	mov 	ecx, eax		; store n in ecx
	mov 	ebx, 0			; clear result register
	mov 	esi, 0x2		; divide number

sum_loop:
	mov 	eax, ecx 		; get current number
	div 	esi 			; divide current number with 2 (esi)
	cmp 	edx, 0x0		; is there a reminder (1) in edx?
	je 	continue		; no, so current num is even, do not add to sum
	
	add 	ebx, ecx 		; add current number to sum s

continue:	
	dec 	ecx 			; next number
	cmp 	ecx, 0			; are we done yet?
	jnz 	sum_loop		; nope, next number

	mov 	eax, ebx 		; store sum in eax for printing
	call 	print_eax		; print result to user


	; Exit the process:
	push	0
	call	[ExitProcess]

