section .data

section .text
	global checkers

checkers:
	;; DO NOT MODIFY
	push ebp
	mov ebp, esp
	pusha

	mov eax, [ebp + 8]	; x
	mov ebx, [ebp + 12]	; y
	mov ecx, [ebp + 16] ; table

	;; DO NOT MODIFY
	;; FREESTYLE STARTS HERE
	xor edx, edx
	code:
		; copiez coordonatele pozitiei initiale pentru calcule
		mov edi, eax
		mov esi, ebx

		; asociez fiecarei directii de deplasare o valoare
		cmp edx, 0		; 0 pentru directia sus-stanga
		je up_left
		cmp edx, 1		; 1 pentru directia sus-dreapta
		je up_right
		cmp edx, 2		; 2 pentru directia jos-stanga
		je down_left
		cmp edx, 3		; 3 pentru directia jos-dreapta
		je down_right
		cmp edx, 4		; daca edx are valoarea 4, ca au fost verificate toate
		jge end

	up_left:
		add edi, 1		; calculez noua linie x_new = x + 1
		sub esi, 1		; calculez noua coloana y_new = y - 1
		jmp verify

	up_right:
		add edi, 1 		; calculez noua linie x_new = x + 1
		add esi, 1		; calculez noua coloana y_new = y + 1
		jmp verify

	down_left:
		sub edi, 1		; calculez noua linie x_new = x - 1
		sub esi, 1		; calculez noua coloana y_new = y - 1
		jmp verify

	down_right:
		sub edi, 1		; calculez noua linie x_new = x - 1
		add esi, 1		; calculez noua coloana y_new = y + 1
		jmp verify

	verify:
		cmp edi, 0  	; verific dacă noua coordonată x este în afara tablei
		jl continue
		cmp edi, 7  	; verific dacă noua coordonată x este în afara tablei
		jg continue
		cmp esi, 0  	; verific dacă noua coordonată y este în afara tablei
		jl continue
		cmp esi, 7  	; verific dacă noua coordonată y este în afara tablei
		jg continue

	modify:
		imul edi, 8		; calculez pozitia urmatoarei mutari
		add edi ,esi
		mov byte [ecx + edi], 1		; pe acea pozitie, modific valoarea
		jmp continue

	continue:
		inc edx
		jmp code

	end:
	;; FREESTYLE ENDS HERE
	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY
