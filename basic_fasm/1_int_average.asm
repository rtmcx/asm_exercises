;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Excercise 1.  
; Write a program that receives two numbers a,b and calculates their integral (integer?) average.
;
; Algorithm to use: (num1 + num2) / 2

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
	call	read_hex	  	; read num1 into eax
	mov 	ebx, eax		; save num1 in ebx

	call    read_hex		; read num2 into eax

	add 	eax, ebx 		; add num1 and num2, store result in eax
	
	mov 	edx, 0x0		; since we work with "full" regisers, we need to zero out edx

	mov 	ebx, 2h			; setup ebx with 2 for division
	div 	ebx 			; div edx-eax with ebx, store result in eax

	call 	print_eax		; print result to user

	; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
