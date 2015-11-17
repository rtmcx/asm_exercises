;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 1
; Write a program that takes the number n as input, and prints back all the
; pairs (x,y) such that x < y < n.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
	call	read_hex	  	; read 'x' into eax
	mov 	ecx, eax		; save 'x' to ecx

y_loop:
	push	ecx

x_loop:
	

	loop	x_loop	

	pop	ecx
	loop	y_loop
exit:
	; Exit the process:
	push	0
	call	[ExitProcess]


