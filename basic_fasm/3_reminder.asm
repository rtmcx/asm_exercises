;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 3.  
; Write a program that receives two numbers a,b as input, and outputs the remainder of dividing a by b.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:

	call	read_hex	  	; read 'a' into eax
	mov 	ebx, eax		; save 'a' in ebx

	call 	read_hex		; read 'b' into eax
	mov 	ecx, eax		; save 'b' in ecx

	mov 	edx, 0x0 		; zero out edx to avoid unwanted result 
	
	mov 	eax, ebx 		; 'a' needs to be in eax for division
	div 	ecx 			; divide a by b

	mov 	eax, edx		; reminder is stored in edx, move that value to eax
	call 	print_eax		; print result to user


	; Exit the process:
	push	0
	call	[ExitProcess]

