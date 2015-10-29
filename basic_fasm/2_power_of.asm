;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 2.  
; Write a program that receives a number x as input, and outputs to the
; console the following values: x+1, x^2 , x^3, one after another.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:

	call	read_hex	  	; read x into eax
	mov 	ebx, eax		; save x in ebx

	; x+1
	inc 	eax 			; add 1 to x
	call 	print_eax		; print result to user

	; x^2
	mov 	eax, ebx		; "restore" x into eax
	mul 	eax 			; eax^2
	call 	print_eax		; print result to user
	
	; x^3
	mov 	eax, ebx		; "restore" x into eax
	mul 	eax 			; eax^2
	mul 	ebx 			; multiply eax(x^2) with x to get x^3	
	call 	print_eax		; print result to user


	; Exit the process:
	push	0
	call	[ExitProcess]

