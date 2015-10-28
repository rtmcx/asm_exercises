; A program the receives three hex numbers, 
; sums those three numbers and output the result in hex
;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Excercise 0.  
; Write a program the receives three numbers and sums those three numbers. 
; Then output the result.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

section '.text' code readable executable

start:
	; get numbers from user
	call 	read_hex	; read first number into eax
	mov 	ebx,eax		; save to ebx
	
	call	read_hex   	; read second number into eax
	mov 	ecx, eax	; save to ecx
	
	call 	read_hex	; read third number into eax

	; add the numbers
	add 	eax, ebx	; add ebx to eax
	add 	eax, ecx	; add esi to ecx

	call 	print_eax	; print the result to the user

	
	; Exit the process with return code 0
	push	0		; return code 0
	call	[ExitProcess]
