section .data
	subMatrix: times 16 db '0' ; matrix 4x4
	
section .text
	global getSubMatrix 
	global setNextTetrinomio
	
; @brief Retorna un puntero al primer byte de la matriz que grafica el siguiente tetrinomio
; @param 
; @return char*	
getSubMatrix:
	mov rax, subMatrix
	ret
	
	
	
; @brief Recibe un char que representa el siguiente tetrinomio que se le dara al jugador
;		 Dependiendo del char, se introducen ciertos valores en la submatriz que se utiliza para mostrar el siguiente tetrinomio
; @param rdi = char
; @return void	
setNextTetrinomio:
	
	call clearNextTetrinomio ; elimina el tetrinomio que se estaba mostrando antes
	
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
	; forma inicial
	; [1][2][3][4] 
	
	;1
	mov r9, subMatrix
	add r9, 4 ; posicion del bloque
	mov byte[r9], '1' ; color
	;2
	mov r9, subMatrix
	add r9, 5
	mov byte[r9], '1'
	;3
	mov r9, subMatrix
	add r9, 6
	mov byte[r9], '1'
	;4
	mov r9, subMatrix
	add r9, 7
	mov byte[r9], '1'

	ret
;-------------------------------

blockO:
	; forma inicial
	; [1][2] 
	; [3][4] 
	mov r9, subMatrix
	add r9, 5 ; posicion del bloque
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
	; forma inicial
	;    [1] 	
	; [2][3][4] 
	;1
	mov r9, subMatrix
	add r9, 5 ;posicion del bloque
	mov byte[r9], '3' ; color
	;2
	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '3'
	;3
	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '3'
	;4
	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '3'

	ret

;----------------------------

blockS:
	; forma inicial
	;    [1][2]	-> 1 pivote
	; [3][4] 
	;1
	mov r9, subMatrix
	add r9, 5 ; position del bloque
	mov byte[r9], '4' ; color 
	;2
	mov r9, subMatrix
	add r9, 6
	mov byte[r9], '4'
	;3
	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '4'
	;4
	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '4'

	ret
;-----------------------------

blockZ:
	; forma inicial
	; [1][2]	-> 2 pivote
	;    [3][4] 
	;1
	mov r9, subMatrix
	add r9, 4 ; posicion del bloque
	mov byte[r9], '5' ; color
	;2
	mov r9, subMatrix
	add r9, 5
	mov byte[r9], '5'
	;3
	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '5'
	;4
	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '5'

	ret

;---------------------------

blockJ:
	; forma inicial
	; [1]		-> 3 pivote
	; [2][3][4] 
	;1
	mov r9, subMatrix
	add r9, 4 ; posicion del bloque
	mov byte[r9], '6' ; color
	;2
	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '6'
	;3
	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '6'
	;4
	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '6'

	ret

;-------------------------------

blockL:
	; forma inicial
	;       [1]	 -> 3 pivote
	; [2][3][4] 
	;1
	mov r9, subMatrix
	add r9, 6 ; posicion del bloque
	mov byte[r9], '7' ;  color
	;2
	mov r9, subMatrix
	add r9, 8
	mov byte[r9], '7'
	;3
	mov r9, subMatrix
	add r9, 9
	mov byte[r9], '7'
	;4
	mov r9, subMatrix
	add r9, 10
	mov byte[r9], '7'

	ret

; @brief Pone todos los valores de la submatriz que grafica el siguiente tetrinomio en '0'
; @param 
; @return void		
clearNextTetrinomio:
	mov r8, 0 ; contador
	mov r9, subMatrix 
	clearNextTetrinomioLoop:
		cmp r8, 16 ; verifica si ya recorrio toda la matriz
		jge return
		
		mov byte[r9], '0' ; pone '0' en las posiciones de la matriz
		inc r9
		inc r8
		jmp clearNextTetrinomioLoop

; @brief Return
; @param 
; @return void	
return: 
	ret
