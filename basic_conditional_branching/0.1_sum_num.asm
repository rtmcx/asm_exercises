;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 0.1
; Write a program that takes the value m as input. 
; It then receives m consecutive numbers from the user, 
; sums all those numbers and prints back the total sum to the console.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:

	call	read_hex	  	; read 'm' into eax
	mov 	ecx, eax 		; store 'm' in ecx
	
	mov 	ebx, 0x0		; clear sum register

get_number:
	call 	read_hex		; read a number from user
	add 	ebx, eax 		; add the number to the sum

	dec 	ecx 			; next number

	cmp 	ecx, 0x0		; are we there yet?
	jnz 	get_number		; no, get another number

	mov 	eax, ebx 		; store sum in eax for printing
	call 	print_eax		; print result to user


	; Exit the process:
	push	0
	call	[ExitProcess]

