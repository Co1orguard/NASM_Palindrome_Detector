BITS 32


SECTION .data 

prompt db "Please enter a string: ", 0xa
lenPrompt equ $-prompt

PalTrue db "It is a palendrome", 0xa 
lenTrue equ $-PalTrue

PalFalse db "It is NOT a palendrome", 0xa
lenFalse equ $-PalFalse


SECTION .bss

buffer RESB 1024


SECTION .text

GLOBAL _start


_start:


main:

	; prompt user for string
	mov eax, 4
	mov ebx, 1
	mov ecx, prompt
	mov edx, lenPrompt
	int 80h
	
	; read input from useri

	mov eax, 3
	mov ebx, 0
	mov ecx, buffer
	mov edx, 1024
	int 80h

	; if \n is the only input

	cmp BYTE [buffer], 10
	je end_while
	


	; calculate size of string and store into esi and edi
	

	mov esi, buffer
	sub eax, 2
	mov ecx, eax 
	mov edi, buffer
	add edi, eax

	;push source and destination to stack
	push esi
	push edi
	
	call init

	; push ebp to stack and set ebp to esp and call into while	
init:
	push ebp
	mov ebp, esp

	mov ebx, [ebp+8]
	mov edx, [ebp+12]	
	
	call while

while:
	;if size is zero
	cmp ecx, 0
	je is_palindrome
	
	;retreive ebx and edx from stack
	;mov ebx, [ebp+8] 
	;mov edx, [ebp+12]
	mov BYTE ah, [ebx]
	mov BYTE al, [edx]

	; if not equal then not palindrome
	cmp ah, al
	jne not_palindrome
	
	dec ebx
	inc edx

	dec ecx
	call while


not_palindrome:

        mov eax, 4
	mov ebx, 1
        mov ecx, PalFalse
        mov edx, lenFalse
        int 80h

        jmp main

is_palindrome:

        mov eax, 4
	mov ebx, 1
        mov ecx, PalTrue
        mov edx, lenTrue
        int 80h

        jmp main



	
end_while:
 
	; exit program
	mov eax, 1
	int 80h
