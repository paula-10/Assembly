%include "../include/io.mac"

struc proc
	.pid: resw 1
	.prio: resb 1
	.time: resw 1
endstruc

section .text
	global sort_procs

sort_procs:
	;; DO NOT MODIFY
	enter 0,0
	pusha

	mov edx, [ebp + 8]      ; processes
	mov eax, [ebp + 12]     ; length
	;; DO NOT MODIFY

	;; Your code starts here

	mov ecx, -1		; initializez contorul cu ajutorul caruia sortez vectorul
	start:
		inc ecx
		cmp ecx, eax
		jge end
		push ecx	; adaug pe stiva un alt registru, pentru parcurgerea vect
		xor ecx, ecx

	code:
		cmp ecx, eax	; verific daca am parcurs tot vectorul
		jge end			; daca a fost parcurs tot vectorul, se sare la end
		mov ebx, ecx
		add ebx, 1		; pentru comparatii, salvez contorul elem urmator
		cmp ebx, eax
		jge sorting_done
		; daca contorul din ebx a ajuns la finalul vectorului, atunci se
		; incheie sortarea pentru elementul curent, si acestuia i se modifica
		; pozitia, asemenea algoritmului bubble sort

		push ecx
		push ebx
		imul ecx, ecx, proc_size
		imul ebx, ebx, proc_size
		movzx edi, byte [edx + ecx + proc.prio]		; prioritate elem curent
		movzx esi, byte [edx + ebx + proc.prio]		; prioritatea elem urm
		cmp edi, esi
		jg swap
		jl equal_pid

	; daca elem au aceeasi prioritate, se verifica timpul
	equal_prio:
		movzx edi, word [edx + ecx + proc.time]
		movzx esi, word [edx + ebx + proc.time]
		cmp edi, esi
		jg swap
		jl equal_pid

	; daca elem au aceeasi valoare de timp, se verifica id-ul
	equal_time:
		movzx edi, word [edx + ecx + proc.pid]
		movzx esi, word [edx + ebx + proc.pid]
		cmp edi, esi
		jg swap

	; daca doua elemente au toate campurile egale, se elimina de pe stiva
	; registrele pe care le-am adaugat suplimentar, la inceputul codului
	; si se incrementeaza contorul, pentru verificarea urmatoarelor elemente
	equal_pid:
		pop ebx
		pop ecx
		inc ecx
		jmp code

	swap:
		push eax
		; se salveaza in registre de dimensiune corespunzatoare campurile
		; elementelor si se interschimba in memorie prin instructiunea xchg
		mov al, [edx + ecx + proc.prio]
		xchg al, [edx + ebx + proc.prio]
		xchg al, [edx + ecx + proc.prio]

		mov ax, [edx + ecx + proc.time]
		xchg ax, [edx + ebx + proc.time]
		xchg ax, [edx + ecx + proc.time]

		mov ax, [edx + ecx + proc.pid]
		xchg ax, [edx + ebx + proc.pid]
		xchg ax, [edx + ecx + proc.pid]

		pop eax
		pop ebx
		pop ecx
		inc ecx
		jmp code

	sorting_done:
		pop ecx
		jmp start

	end:
	;; Your code ends here

	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY
