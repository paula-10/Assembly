%include "../include/io.mac"

section .text
	global simple
	extern printf

simple:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     ecx, [ebp + 8]  ; len
	mov     esi, [ebp + 12] ; plain
	mov     edi, [ebp + 16] ; enc_string
	mov     edx, [ebp + 20] ; step

	;; DO NOT MODIFY

	;; Your code starts here
	xor	eax, eax	; seteaza EAX la 0, pentru a-l folosi drept contor

	code:
		mov bl, 0
		cmp eax, ecx    ; verifica daca mai sunt caractere in sir neverificate
		jge end

		mov bl, [esi + eax]    ; se muta in registrul EBX un caracterul curent
		add ebx, edx            ; se face shiftarea

		cmp bl, 90		; se verifica daca elementul este mai mare de Z
		jle good		; daca elementul se afla intre A-Z, atunci este bun
		sub bl, 26		; daca codul ASCII al elementului este mai mare decat
						; cel al lui Z, atunci se calculeaza valoarea corecta

	good:
		mov [edi + eax], bl		; se muta caracterul nou in registrul EDI
		inc eax		; se incrementeaza contorul
		jmp code

	end:

	;; Your code ends here
	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY
