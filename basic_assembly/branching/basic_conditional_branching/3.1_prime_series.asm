;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 3.1 
; Write a program that takes a number n as input, and prints back to the
; console all the primes that are larger than 1 but not larger than n.
	
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

	mov	ecx, 0		; loop from 1 to num

main_loop:
	inc 	ecx
	mov 	eax, ecx
	mov 	ebx, ecx
	call	is_prime
	call	print_eax
	
	cmp	ecx, ebx
	jle	main_loop	; no, next num 

	jmp 	exit		; exit of main loop, exit		
	

is_prime:
	; since we only need to test n to n/2, we need that value.
	xor 	edx, edx	; edx = 0
	mov 	ecx, 2		; div by 2
	div 	ecx 		; div eax by 2
	
	mov 	esi, eax	; store the result in esxi 

	mov 	ecx, 2		; start at 2 (since 1 is not needed to test).

prime_loop:
	mov 	eax, 1		; assume prime as result
	
	cmp 	ecx, esi	; check if we have tested all numbers?
	ja  	return		; nope, loop again

	xor 	edx, edx	; setup registers for division
	mov 	eax, ebx	; we should divide 'n' (users input)
	div 	ecx 		; engage!

	cmp 	edx, 0 		; is there a reminder (stored in edx)? 
	je  	not_prime	; no, then it is not a prime number (divisible by num in ecx)
	
	inc 	ecx  		; inc loop counter
	jmp 	prime_loop	; next iteration

return:	
	ret

not_prime:
	mov 	eax, 0		; we come here if a divisor was found, so not prime
	
	jmp	return

exit:
	call 	print_eax	; eax holds 1 or 0 for prime or not

	; Exit the process:
	push	0
	call	[ExitProcess]

section '.rdata' data readable
	intro_text db 'Enter a number to test if it is prime:', 10, 0
