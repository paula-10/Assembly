%include "../include/io.mac"

struc avg
	.quo: resw 1
	.remain: resw 1
endstruc

struc proc
	.pid: resw 1
	.prio: resb 1
	.time: resw 1
endstruc

	;; Hint: you can use these global arrays
section .data
	prio_result dd 0, 0, 0, 0, 0
	time_result dd 0, 0, 0, 0, 0

section .text
	global run_procs

run_procs:
	;; DO NOT MODIFY

	push ebp
	mov ebp, esp
	pusha

	xor ecx, ecx

clean_results:
	mov dword [time_result + 4 * ecx], dword 0
	mov dword [prio_result + 4 * ecx],  0

	inc ecx
	cmp ecx, 5
	jne clean_results

	mov ecx, [ebp + 8]      ; processes
	mov ebx, [ebp + 12]     ; length
	mov eax, [ebp + 16]     ; proc_avg
	;; DO NOT MODIFY

	;; Your code starts here
	xor edx, edx	; edx este contorul care se parcurge vectorul de procese
	code_run:
		cmp edx, ebx	; se verifica daca s-a ajuns la finalul vectorului
		jge prepare
		; daca s-a ajuns la finalul vectorului, inseamna ca in vectorii
		; prio_result sti time_result sunt stocate toate sumele necesare, asa
		; ca se poate trece la calcularea mediilor

		push eax
		push ebx
		mov ebx, edx
		push edx
		imul ebx, ebx, proc_size
		movzx eax, byte [ecx + ebx + proc.prio]
		add dword [prio_result + 4 * (eax - 1)], 1
		; pentru fiecare prioritate, se calculeaza numarul aparitiilor

		movzx edx, word [ecx + ebx + proc.time]
		add [time_result + 4 * (eax - 1)], edx
		; pentru fiecare prioritate, se calculeaza suma valorilor de timp

		pop edx
		pop ebx
		pop eax
		inc edx
		jmp code_run

	prepare:
		mov ecx, -1		; contor care itereaza in vectorul de prioritati
		mov ebx, eax	; adresa de inceput pentru avg

	calc_avg:
		inc ecx
		cmp ecx, 5
		jge end

		mov eax, [time_result + ecx * 4]
		mov edi, [prio_result + ecx * 4]
		cmp edi, 0		; se verifica ca nu se face o impartire la 0
		je calc_avg		; in acest caz, se merge la urmatorul element
		xor edx, edx
		div edi
		; se scriu in campurile corespunzatoare cat si restul impartirii
		mov [ebx + avg_size * ecx + avg.quo], ax
		mov [ebx + avg_size * ecx + avg.remain], dx

		jmp calc_avg

	end:
	;; Your code ends here

	;; DO NOT MODIFY
	popa
	leave
	ret
	;; DO NOT MODIFY
