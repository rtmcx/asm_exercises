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
	mov 	ecx, eax		; save 'x' to ecx

; loop from 'x' to 1...
main_loop:	
	push	ecx 			; save current 'x' for later retrieval
	
	mov 	ebx, 0 			; variable for number of divisors for 'x'
	mov 	esi, ecx		; store 'x' in inner loop counter

; for every number, divide num with every number from 'self' to 1	
div_loop:		
	xor 	edx, edx		; null edx for div 
	mov 	edi, ecx		; divide current number with inner loop number
	mov 	eax, esi		; divide 'num' 
	div 	edi			; with inner loop num

	cmp 	edx, 0			; check reminder			
	jnz 	not_even		; reminder exist
	
	inc 	ebx 			; skip adding divisor

not_even:
	loop 	div_loop		; next number..
	
	cmp 	ebx, 4			; 1, 2*divisor and 'x'
	jnz 	no_go			; do not print num if not 4 divisors

	mov 	eax, esi		; print num 
	call	print_eax
no_go:
	pop 	ecx			; restore ecx for next iteration
	loop 	main_loop

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

