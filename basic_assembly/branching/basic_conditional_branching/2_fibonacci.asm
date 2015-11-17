;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 2
; The Fibonacci series is the series of numbers where every number is the sum
 ; of the two previous numbers. It begins with the numbers: 1,1,2,3,5,8,...
 ; Write a program that takes as input the number n, and prints back the n-th
 ; element of the fibonacci series.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
	push 	intro_text
	call	[printf]

	call	read_hex	  	; read 'n' into eax
	mov 	ebx, eax		; save 'n' to ebx 
	dec 	ebx			; make index "humanable" (so 1 is first index)
	
	; current number is stored in edi
	; previous number is stored in esi
	mov 	edi, 1			; start the fibonacci series with 1
	mov 	esi, 0			; set 'previous' number to 0
	mov 	ecx, 0			; in which position are we?

fibonacci:

	mov 	edx, edi		; 'save' current number
	add 	edi, esi		; add previous num to current 
	mov 	esi, edx		; set previous num to current num, before adding nums

	inc 	ecx 			; inc current index number
	
	cmp 	ecx, ebx		; are we at user wanted index?
	jl  	fibonacci		; no, next num in sequence please
	
	; here we are at the sequence index user wants to see...
	push 	found_text		
	call	[printf]
	mov 	eax, edi		; mov value to eax
	call 	print_eax		; print value

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

section '.rdata' data readable
	intro_text db 'Enter the position to print (in hex):', 10, 0
	found_text db 'The index you wanted has the follwing value (in hex)', 10, 0
