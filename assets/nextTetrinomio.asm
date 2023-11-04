section .data
	subMatrix: times 16 db '0'
	
section .text
	global getSubMatrix
	global setNextTetrinomio
	
getSubMatrix:
	mov rax, subMatrix
	ret
	
setNextTetrinomio:
	
	call clearNextTetrinomio
	
	cmp rdi, 'I'
	je tetriI
	cmp rdi, 'O'
	je blockO
	cmp rdi, 'T'
	je blockT
	cmp rdi, 'S'
	je blockS
	cmp rdi, 'Z'
	je blockZ
	cmp rdi, 'J'
	je blockJ
	cmp rdi, 'L'
	je blockL
		
	
	tetriI:
	;Pivote del Tetrinomio I es el 2 bloque
	mov r9, subMatrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '1' ;color

	mov r9, subMatrix
	add r9, 5
	mov byte[r9], '1'
	
	mov r9, subMatrix
	add r9, 6
	mov byte[r9], '1'

	mov r9, subMatrix
	add r9, 7
	mov byte[r9], '1'

	ret
	;-------------------------------
	blockO:
	mov r9, subMatrix
	add r9, 5 ;Position of the first block
	mov byte[r9], '2' ;color

	mov r9, subMatrix
	add r9, 6
	mov byte[r9], '2'

	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '2'

	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '2'

	ret
	;----------------------
	
	blockT:
	mov r9, subMatrix
	add r9, 5 ;Position of the first block
	mov byte[r9], '3' ;color

	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '3'
	
	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '3'

	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '3'
	
	ret
	
	;----------------------------
	
	blockS:
	mov r9, subMatrix
	add r9, 5 ;Position of the first block
	mov byte[r9], '4' ;color

	mov r9, subMatrix
	add r9, 6
	mov byte[r9], '4'

	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '4'

	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '4'

	ret
	;-----------------------------
	
	blockZ:
	mov r9, subMatrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '5' ;color

	mov r9, subMatrix
	add r9, 5
	mov byte[r9], '5'

	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '5'

	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '5'

	ret

	;---------------------------
	
	blockJ:
	mov r9, subMatrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '6' ;color

	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '6'

	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '6'

	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '6'

	ret
	
	;-------------------------------
	
	blockL:
	mov r9, subMatrix
	add r9, 6 ;Position of the first block
	mov byte[r9], '7' ;color

	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '7'

	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '7'

	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '7'

	ret
	
clearNextTetrinomio:
	mov r8, 0
	mov r9, subMatrix
	clearNextTetrinomioLoop:
		cmp r8, 16
		jge return
		
		mov byte[r9], '0'
		inc r9
		inc r8
		jmp clearNextTetrinomioLoop
		
return: 
	ret
