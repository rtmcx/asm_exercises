;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 2
; Write a program that takes a number m as input, and prints back 1 to the
; console if m is a prime number. Otherwise, it prints 0.
; 
; We need to divide 'n' with every number from 2 to 'n'/2 and check if there is a reminder
; after the division. 
; If there is not a reminder, the number is divisible by the number tested and 'n' is not a prime.
; If the loop completes the number is a prime, since no other divisor has been found.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
	push 	intro_text
	call	[printf]

	call	read_hex	; read 'n' into eax
	mov 	ebx, eax	; store number in ebx
	
	; since we only need to test n to n/2, we need that value.
	xor 	edx, edx	; edx = 0
	mov 	ecx, 2		; div by 2
	div 	ecx 		; div eax by 2
	
	mov 	esi, eax	; store the result in esxi 

	mov 	ecx, 2		; start at 2 (since 1 is not needed to test).

prime_loop:
	mov 	eax, 1		; assume prime as result
	
	cmp 	ecx, esi	; check if we have tested all numbers?
	ja  	exit		; nope, loop again

	xor 	edx, edx	; setup registers for division
	mov 	eax, ebx	; we should divide 'n' (users input)
	div 	ecx 		; engage!

	cmp 	edx, 0 		; is there a reminder (stored in edx)? 
	je  	not_prime	; no, then it is not a prime number (divisible by num in ecx)
	
	inc 	ecx  		; inc loop counter
	jmp 	prime_loop	; next iteration

not_prime:
	mov 	eax, 0		; we come here if a divisor was found, so not prime

exit:
	call 	print_eax	; eax holds 1 or 0 for prime or not

	; Exit the process:
	push	0
	call	[ExitProcess]

section '.rdata' data readable
	intro_text db 'Enter a number to test if it is prime:', 10, 0
