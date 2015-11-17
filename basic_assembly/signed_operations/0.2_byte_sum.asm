;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 0.2
; Write a program that finds every double word (4 bytes) that satisfies the
; following condition: When decomposed into 4 bytes, if we multiply those
; four bytes, we get the original double word number.

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
;	push 	intro_text
;	call	[printf]

	;call	read_hex	; read 'x' into eax
	mov	ecx, 0x01010101 ; we will use 'loop', so start at highest value

ze_loop:
	push 	ecx
	mov 	eax, ecx	; save 'x' to ecx
	mov 	ebx, ecx

	movzx	esi, al		; move-extend lowest bit to esi
	movzx	edi, ah		; and high to edi

	mov 	eax, 1		; set eax to 1 for mul
	mul 	esi 		; 1 * al
	mul 	edi 		; al * ah

	shr 	ecx, 16		; shift eax 16 bits right, to get upper bytes in cx

	movzx	esi, cl		; move-extend lowest bit to esi
	movzx	edi, ch		; and high to edi
	mul 	esi 		; multiply upper bytes ....
	mul 	edi 		; with the lower bytes already in eax
	pop ecx

	cmp	ebx, eax	; compare the 4 bytes with input value
	jne	do_loop		; not equal, don´t print
	call 	print_eax	; and print to user
do_loop:

	loop 	ze_loop

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

section '.rdata' data readable
	intro_text db 'Enter 4 bytes to be added (no spaces):', 10, 0

