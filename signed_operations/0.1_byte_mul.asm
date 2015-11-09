;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 0.1
; Write a program that does the same (as ex 0.0), except that it multiplies the four
; bytes. (All the bytes are considered to be unsigned)

format PE console
entry start

include 'win32a.inc' 
include 'training.inc'

; ===============================================
section '.text' code readable executable

start:
	push 	intro_text
	call	[printf]

	call	read_hex	; read 'x' into eax
	mov 	ecx, eax	; save 'x' to ecx

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

	call 	print_eax	; and print to user

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

section '.rdata' data readable
	intro_text db 'Enter 4 bytes to be added (no spaces):', 10, 0

