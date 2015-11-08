;
; Part of the exercises for the "Assembly Language Adventures" course at http://xorpd.net
;
; Exercise 0.0
; Write a program that takes a double word (4 bytes) as an argument, and
; then adds all the 4 bytes. It returns the sum as output. Note that all the
; bytes are considered to be of unsigned value.

; Example: For the number 03ff0103 the program will calculate 0x03 + 0xff +
; 0x01 + 0x3 = 0x106, and the output will be 0x106

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
	mov 	ecx, 0x2	; save 'x' to ecx
	mov 	edi, 0		; Use edi as result register

	movzx	esi, al		; move-extend lowest bit to esi
	add 	edi, esi	; add to edi
	movzx	esi, ah		; move-extend ah byte to esi
	add 	edi, esi	; edd to result

	shr 	eax, 16		; shift eax 16 bits right, to get upper bytes in ax
	movzx	esi, al		; repeat as above
	add 	edi, esi	; to get highest bytes 
	movzx	esi, ah		; added to esi
	add 	edi, esi	; and then to edi

	mov 	eax, edi	; move result 
	call 	print_eax	; and print to user

exit:
	; Exit the process:
	push	0
	call	[ExitProcess]

section '.rdata' data readable
	intro_text db 'Enter 4 bytes to be added (no spaces):', 10, 0

