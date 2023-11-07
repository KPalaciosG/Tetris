section .data
    matrix:  times 210 db '0'  ; matrix de 21x10 inicializada con ceros

	currentTetrinomio: times 5 dq 0
	color: db 0

	moves: times 5 dq 0

	empty: equ '0'
	
	blockCounter db 0 ;contador de bloques
	;array de bloques
	blockOrder db 0, 1, 2, 3, 4, 5, 6
	blockOrderSize equ 7
		

section .text
	;Gets: lines 29-74
    global getMatrix
	global getBlock
	global getNextTetrinomio
	global newArray
	
	;Moves
	global rotateTetrinomio
	global moveRight
	global moveLeft
	global moveDown
	
	;Verifications
	global checkTetrinomioState
	global checkMatrixState
	
	;Auxiliar
	global clearRows
	global dropAllBlocks
	
	
; @return char*
; Returns the matrix that is need it to be display
getMatrix:
	mov r8, matrix
	add r8, 10
	mov rax, r8  
	ret
	
newArray:
	extern arrayShuffle
	call arrayShuffle
	mov rbx, blockOrder  ;se guarda la direcciòn de memoria del arreglo de bloques
	mov r8b, [rbx]
	mov r9b, [rbx+rax]
	mov [rbx], r9b
	mov [rbx+rax], r8b
	
	call arrayShuffle
	mov r8b, [rbx]
	mov r9b, [rbx+rax]
	mov [rbx], r9b
	mov [rbx+rax], r8b
	
	call arrayShuffle
	mov r8b, [rbx]
	mov r9b, [rbx+rax]
	mov [rbx], r9b
	mov [rbx+rax], r8b
		
	ret
	

;to do..
; @param rdi = char
; @return void
;
; This funtion will compare a char that represents the current tetrinomio, and will puts some values in the matrix (a number)
; that represents a color and in currentTetrinomio will put the addresses of each block that contains a color
getBlock:
	
	mov rbx, blockOrder  ;se guarda la direcciòn de memoria del arreglo de bloques
	xor rax, rax  ;se limpia el registro
	mov al, byte[blockCounter] 
		
		
	;usa el valor del contador para determinar el bloque
	
	;Si el contador supera 6, establece el contador en 0
	cmp byte[blockCounter], 7
	jae resetBlockCounter
	
	cmp byte[rbx+rax], 0
	je blockI
	cmp byte[rbx+rax], 1
	je blockO
	cmp byte[rbx+rax], 2
	je blockT
	cmp byte[rbx+rax], 3
	je blockS
	cmp byte[rbx+rax], 4
	je blockZ
	cmp byte[rbx+rax], 5
	je blockJ
	cmp byte[rbx+rax], 6
	je blockL
		
	
	blockI:
	;Pivote del Tetrinomio I es el 2 bloque
	mov r9, matrix
	add r9, 3 ;Position of the first block
	mov byte[r9], '1' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 4
	mov byte[r9], '1'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 5
	mov byte[r9], '1'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 6
	mov byte[r9], '1'
	mov qword[currentTetrinomio+24], r9

	mov r9, matrix
	add r9, 4
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '1' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al
	
	mov al, 'I'
	ret
	;-------------------------------
	blockO:
	mov r9, matrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '2' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 5
	mov byte[r9], '2'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 14
	mov byte[r9], '2'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 15
	mov byte[r9], '2'
	mov qword[currentTetrinomio+24], r9
	
	;pivote
	mov r9, matrix
	add r9, 5
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '2' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al

	mov al, 'O'
	ret
	;----------------------
	
	blockT:
	mov r9, matrix
	add r9, 5 ;Position of the first block
	mov byte[r9], '3' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 14
	mov byte[r9], '3'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 15
	mov byte[r9], '3'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 16
	mov byte[r9], '3'
	mov qword[currentTetrinomio+24], r9
	
	;pivote
	mov r9, matrix
	add r9, 15
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '3' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al
	
	mov al, 'T'
	ret
	
	;----------------------------
	
	blockS:
	mov r9, matrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '4' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 5
	mov byte[r9], '4'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 13
	mov byte[r9], '4'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 14
	mov byte[r9], '4'
	mov qword[currentTetrinomio+24], r9
	
	;pivote
	mov r9, matrix
	add r9, 4
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '4' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al

	mov al, 'S'
	ret
	;-----------------------------
	
	blockZ:
	mov r9, matrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '5' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 5
	mov byte[r9], '5'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 15
	mov byte[r9], '5'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 16
	mov byte[r9], '5'
	mov qword[currentTetrinomio+24], r9
	
	;pivote
	mov r9, matrix
	add r9, 5
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '5' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al
	
	mov al, 'Z'
	ret

	;---------------------------
	
	blockJ:
	mov r9, matrix
	add r9, 4 ;Position of the first block
	mov byte[r9], '6' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 14
	mov byte[r9], '6'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 15
	mov byte[r9], '6'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 16
	mov byte[r9], '6'
	mov qword[currentTetrinomio+24], r9
	
	;pivote
	mov r9, matrix
	add r9, 15
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '6' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al

	mov al, 'J'
	ret
	
	;-------------------------------
	
	blockL:
	mov r9, matrix
	add r9, 6 ;Position of the first block
	mov byte[r9], '7' ;color
	mov qword[currentTetrinomio], r9 ;save the address

	mov r9, matrix
	add r9, 14
	mov byte[r9], '7'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 15
	mov byte[r9], '7'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 16
	mov byte[r9], '7'
	mov qword[currentTetrinomio+24], r9
	
	;pivote
	mov r9, matrix
	add r9, 15
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '7' ; save the color of the currentTetrinomio
	inc byte[blockCounter] ;incrementa el contador de bloques
	;inc al

	mov al, 'L'
	ret
	
	;------------------------------
	;reinicia el contador de bloques en 0
	resetBlockCounter:
		mov byte[blockCounter], 0
		
		;permutaciòn del arreglo
		mov r10b, 3 ;contador loop
		loopChangeBlock:
			mov r8b, [rbx]
			mov r9b, [rbx+1]
			mov [rbx], r9b
			mov [rbx+1], r8b
			dec r10b
			add rbx, 2
			cmp r10b, 0
			je endLoopBlock
			jmp loopChangeBlock
			
		
		endLoopBlock:	
			jmp getBlock 
		
	
getNextTetrinomio:
	
	mov rbx, blockOrder  ;se guarda la direcciòn de memoria del arreglo de bloques
	xor rax, rax  ;se limpia el registro
	mov al, byte[blockCounter] 

	add rbx, rax
	
	cmp byte[rbx], 0
	mov al, 'I'
	je return
	cmp byte[rbx], 1
	mov al, 'O'
	je return
	cmp byte[rbx], 2
	mov al, 'T'
	je return
	cmp byte[rbx], 3
	mov al, 'S'
	je return
	cmp byte[rbx], 4
	mov al, 'Z'
	je return
	cmp byte[rbx], 5
	mov al, 'J'
	je return
	cmp byte[rbx], 6
	mov al, 'L'
	je return

	ret


;---------------------------
; MOVES
;---------------------------

; @param rdi = char (currentTetrinomio)
; @return void
;
; This funtion moves the current tetrinomio to the right
moveRight:
	call clearMoves 

	call checkRightBorder ; verify if the tetrinomio is in the left border
	cmp al, 0 ; 0 = can't move to the right and 1 = can move right
	je return
	
	call movingRight ; calculates the future moves, and save them
	call validMove ; verify if the future moves, won't be done above another block
	cmp al, 0 ; 0 = found something in the new positions, 1 = can move it, it's clean
	je return

	call deleteTetrinomio ; clean the positions of the current tetrinomio
	call move ; puts the color of the current tetrinomio in the new positions and update the currentTetrinomio

	ret
	
movingRight:
	mov rdi, 1
	call saveMove
	ret

; @param rdi = char (currentTetrinomio)
; @return void
;
; This funtion moves the current tetrinomio to the left
; Note: it's the same logic has "moveRight"
moveLeft:
	call clearMoves 
	
	call checkLeftBorder
	cmp al, 0
	je return
	
	call movingLeft
	call validMove
	cmp al, 0
	je return

	call deleteTetrinomio 
	call move

	ret

movingLeft:
	mov rdi, -1
	call saveMove
	ret

; @param rdi = char (currentTetrinomio)
; @return void
;
; This funtion moves the current tetrinomio one block down
; Note: it's the same logic has "moveRight"
moveDown:
	call clearMoves
	
	;Keylor
	;El check bottom border cuando se llama desde la funcion genera un error en la esquina inferior derecha, no sé porque
	;de igual forma sirve sin llamarla
	;call checkBottomBorder
	;cmp al, 0
	;je return
	call movingDown
	call validMove
	cmp al, 0
	je return
	
	call deleteTetrinomio ;limpia la matriz
	call move

	ret
	
movingDown:
	mov rdi, 10
	call saveMove
	ret
	
; @param rdi = int (amount of rotations) and rsi = char (currentTetrinomio)
; @return void
;
; This funtion rotate the currentTetrinomio

rotateTetrinomio:
	call clearMoves
	cmp rsi, 'O' ; this don't rotate
	je return
	
	;rdi = amount of rotations
	call getRotateType
	
	;rax = the rotation that has to be done
	mov rdi, rax 
	call getRotateMoves ; calculates the future moves if rotates
	call borderCases ;Verify if want's to rotate while the tetrinomio is in one border
	
	call validMove ; verify if the future moves, won't be done above another block
	cmp al, 0
	je return

	call deleteTetrinomio ; clean the positions of the current tetrinomio
	call move ; puts the color of the current tetrinomio in the new positions and update the currentTetrinomio
	ret

getRotateType:
	; y el movimiento es la cantidad de movimientos que lleva % 4
	mov rdx, 0
	mov rax, rdi 
	mov r8, 4
	div r8
	mov rax, rdx
	ret


getRotateMoves:
	cmp rsi, 'I'
	je rotateI

	cmp rsi, 'T'
	je rotateT

	cmp rsi, 'S'
	je rotateS

	cmp rsi, 'Z'
	je rotateZ

	cmp rsi, 'J'
	je rotateJ

	cmp rsi, 'L'
	je rotateL


deleteTetrinomio:
	mov r10, 0
	deleteLoop:
		mov r9, qword[currentTetrinomio + 8*r10]
		mov byte[r9], empty
		inc r10
		cmp r10, 4
		jl deleteLoop
ret


	
saveMove:
	mov r10, 0
	saveMoveLoop:
		add qword[moves + 8*r10], rdi
		inc r10
		cmp r10, 4
		jle saveMoveLoop
	ret


move:
	mov r10, 0
	moveLoop:
		mov r9, qword[currentTetrinomio + 8*r10]
		add r9, qword[moves + 8*r10]
		mov r12b, byte[color]
		mov byte[r9], r12b
		mov qword[currentTetrinomio + 8*r10], r9
		inc r10
		cmp r10, 4
		jl moveLoop

		;Actualizar el pivote
		mov r9, qword[currentTetrinomio + 8*r10]
		add r9, qword[moves + 8*r10]
		mov qword[currentTetrinomio + 8*r10], r9

		ret


validMove:
	mov r8, 0
	mov al, 1
	
	validMoveLoop:
		cmp r8, 4
		jge return
		cmp al, 0
		je return
		
		mov r9, qword[currentTetrinomio + 8*r8]
		add r9, qword[moves + 8*r8]
		
		mov r10, 0
		mov bl, 0 ;encontro la posicion = false
		
		findDifferentAddress:
			cmp r10, 4
			jge verifyValidMove
			
			cmp r9, qword[currentTetrinomio + 8*r10]
			je found
			jne nextMove
			
			found:
				mov bl, 1
				jmp nextPossibleMove
				
			nextMove:
				inc r10
				jmp findDifferentAddress
			
			verifyValidMove:
				cmp bl, 0
				je isAnEmptyBlock
		
			isAnEmptyBlock:
				cmp byte[r9], empty
				je nextPossibleMove
				mov al, 0
		
		nextPossibleMove:
			inc r8
			jmp validMoveLoop	


;---------------------------
;VERIFICATIONS
;---------------------------


; @param 
; @return bool 
;
; This funtion verify if the currentTetrinomio can still go down
; It "moves" the tetrinomio down and verify if it could, and returns a bool for each case
checkTetrinomioState:
	call clearMoves
	call checkBottomBorder ; is it in the bottom?
	mov rdi, 10
	call saveMove
	call validMove ; can still go down?
	ret
	
; @param 
; @return bool 
;
; This funtion verify if the currentTetrinomio can still go down
; It "moves" the tetrinomio down and verify if it could, and returns a bool for each case	
checkMatrixState:
	mov r8, 0
	mov al, 1
	checkMatrixStateLoop:
		mov r9, qword[currentTetrinomio + 8*r8]
		cmp r9, matrix + 10
		jl finishedGame
		inc r8
		cmp r8, 4
		jl checkMatrixStateLoop
		ret
	
	finishedGame:
		mov al, 0
		ret
	
	
checkLeftBorder:
	mov r8, matrix

	mov al, 1
	mov r10, 0
	leftBorderLoop:
		mov rdx, 0
		mov rax, qword[currentTetrinomio + 8*r10]
		sub rax, r8
		
		mov r11, 10
		div r11
		cmp rdx, 0
		je cantMove
		
		inc r10
		cmp r10, 4
		jl leftBorderLoop
		
	ret
	
checkRightBorder:
	mov r8, matrix
	add r8, 9
	
	mov al, 1
	mov r10, 0
	rightBorderLoop:
		mov rdx, 0
		mov rax, qword[currentTetrinomio + 8*r10]
		sub rax, r8
		
		mov r11, 10
		div r11
		cmp rdx, 0
		je cantMove
		
		inc r10
		cmp r10, 4
		jl rightBorderLoop
		
	ret
	
checkBottomBorder:
	mov r8, matrix
	add r8, 200

	mov al, 1
	mov r10, 0
	bottomBorderLoop:
		cmp r10, 4
		jge return
		mov rax, qword[currentTetrinomio + 8*r10]
		
		cmp rax, r8
		jg cantMove
		
		inc r10
		jmp bottomBorderLoop
	
cantMove:
	mov al, 0
	ret


;-----------------
borderCases:
	;Verifica si el pivote esta en una posicion particular cuando se intenta girar
	;en caso de que sea asi, modifica los futuros movimientos, para que se verifiquen tambien si son validos
	mov r8, matrix
	mov r9, qword[currentTetrinomio + 32] ;pivote

	;Case Left Border
	;Si el pivote esta en el borde izquierdo, para girar necesita correr 1 a la derecha el tetrinomio, eso hace
	mov rax, r9
	sub rax, r8
	
	mov rdx, 0
	mov r10, 10
	div r10
	mov rdi, 1
	cmp rdx, 0
	je saveMove

	;Case Right Border
	;Si el pivote esta en el borde derecho, para girar necesita correr 1 a la izquierda el tetrinomio, eso hace
	mov rax, r9
	add r8, 9
	sub rax, r8
	
	mov rdx, 0
	mov r10, 10
	div r10
	mov rdi, -1
	cmp rsi, 'I'
	jne oneLeft
		mov rdi, -2
	oneLeft:
	cmp rdx, 0
	je saveMove
	
	;Case for the 'I' when it's one block away from de right border and needs 2 to turn correctly 
	cmp rsi, 'I'
	jne skip
	
	mov rax, r9
	add r8, 9
	sub rax, r8
	
	mov rdx, 0
	mov r10, 10
	div r10
	mov rdi, -1
	cmp rdx, 0
	je saveMove
	
	skip:
	;Case Up Border
	;Si el pivote esta en el borde de arriba, para girar necesita bajar el tetrinomio, eso hace
	cmp r9, r8
	mov rdi, 20
	jl saveMove

	;Case Bottom Border
	;Si el pivote esta en el borde de abajo, para girar necesita subir el tetrinomio, eso hace
	mov rdi, -10
	cmp rsi, 'I'
	jne oneUp
		mov rdi, -20
	oneUp:
	cmp r9, matrix+200
	jg saveMove

	ret


;Movimientos
;Katherine
;movingRight:
;	mov r10, 0
;	mRloop:
;		mov r9, qword[currentTetrinomio + 8*r10]
;		add r9, 1
;		mov r12b, byte[color]
;		mov byte[r9], r12b
;		mov qword[currentTetrinomio + 8*r10], r9
;		inc r10
;		cmp r10, 4
;	       jle mRloop

;ret

;movingLeft:
;	mov r10, 0
;	mLloop:
;		mov r9, qword[currentTetrinomio + 8*r10]
;		add r9, -1
;		mov r12b, byte[color]
;		mov byte[r9], r12b
;		mov qword[currentTetrinomio + 8*r10], r9
;		inc r10
;		cmp r10, 4
;	       jle mLloop
;
;ret

;movingDown:
;	mov r10, 0
;	mDloop:
;		mov r9, qword[currentTetrinomio + 8*r10]
;		add r9, 10
;		mov r12b, byte[color]
;		mov byte[r9], r12b
;		mov qword[currentTetrinomio + 8*r10], r9
;		inc r10
;		cmp r10, 4
;	       jle mDloop
;
;ret



;---------------------------
; AUXILIARES
;---------------------------
clearMoves:
	mov r10, 0
	mov r11, 0
	cleanMoveLoop:
		mov qword[moves + 8*r10], r11
		inc r10
		cmp r10, 4
		jle cleanMoveLoop
	ret
	
	
clearRows:
	mov r8, matrix
	add r8, 10
	mov r9, 0
	
	clearRowsLoop:
		cmp r9, 200
		jge return
		
		mov rdi, r8
		add rdi, r9
		call isAFullRow
		
		mov rdi, r8
		add rdi, r9
		cmp al, 1
		je fullRow
	nextRow:
		add r9, 10
		jmp clearRowsLoop
		
isAFullRow:
	mov al, 1
	mov r10, rdi
	mov r11, 0
	isAFullRowLoop:
		cmp r11, 10
		jge return
		cmp al, 0
		je return
		
		cmp byte[r10], empty
		jne nextBlock
		mov al, 0
		
		nextBlock:
			inc r10
			inc r11
			jmp isAFullRowLoop
	
fullRow:
	call emptyRow
	
	jmp nextRow
	
emptyRow:
	mov r10, rdi
	mov r11, 0
	emptyRowLoop:
		cmp r11, 10
		jge return
		
		mov byte[r10], empty

		inc r10
		inc r11
		jmp emptyRowLoop


dropAllBlocks:
	mov r8, matrix
	add r8, 10
	mov r9, 0
	
	dropAllBlocksLoop:
		cmp r9, 200
		jge isThereEmptyRows
		
		mov rdi, r8
		add rdi, r9
		call isAnEmptyRow
		
		mov rdi, r8
		add rdi, r9
		cmp al, 1
		je dropUpperBlocks
	nextRow2:
		add r9, 10
		jmp dropAllBlocksLoop

isThereEmptyRows:
	mov r8, matrix
	mov r9, 0
	mov al, 0
	isThereEmptyRowsLoop:
		cmp r9, 200
		jge return
		
		mov rdi, r8
		add rdi, r9
		call isAnEmptyRow
		cmp al, 1
		je nextRow3
		add rdi, 10
		call isAnEmptyRow
		cmp al, 1
		je dropAllBlocks
		
	nextRow3:
		add r9, 10
		jmp isThereEmptyRowsLoop
	
isAnEmptyRow:
	mov al, 1
	mov r10, rdi
	mov r11, 0
	isAnEmptyRowLoop:
		cmp r11, 10
		jge return
		cmp al, 0
		je return
		
		cmp byte[r10], empty
		je nextBlock2
		mov al, 0
		
		nextBlock2:
			inc r10
			inc r11
			jmp isAnEmptyRowLoop


dropUpperBlocks:
	mov r10, rdi
	sub r10, 10
	
	mov r11, 0
	dropUpperBlocksLoop:
		cmp r11, 10
		jge dropped
			
		mov r12b, byte[r10]
		mov byte[r10+10], r12b
		
		inc r10
		inc r11
		jmp dropUpperBlocksLoop

dropped:
	sub rdi, 10
	call emptyRow
	jmp nextRow2

isMatrixEmpty:
	mov al, 1
	mov r8, matrix
	add r8, 10
	mov r9, 0
	isMatrixEmptyLoop:
		cmp r9, 200
		jge return
		cmp al, 0
		je return
		
		cmp byte[r8], empty
		je nextBlock3
		mov al, 0
		
		nextBlock3:
			inc r8
			inc r9
			jmp isMatrixEmptyLoop



;---------------------------------------
;	
;ROTACIONES
;
;---------------------------------------
;movimientos de la I
rotateI:
	cmp rdi, 0
	je I0
	cmp rdi, 1
	je I1
	cmp rdi, 2
	je I0
	cmp rdi, 3
	je I1

	I0: ;vuelve a la forma inicial
		; []
		; [] -> [][][][]
		; []
		; []
		mov qword[moves], 9
		mov qword[moves + 8], 0
		mov qword[moves + 16], -9
		mov qword[moves + 24], -18
		jmp return

	I1: ;Movimiento 1
		;			  []
		;[][][][] ->  []
		;			  []
		;			  []
		mov qword[moves], -9
		mov qword[moves + 8], 0
		mov qword[moves + 16], 9
		mov qword[moves + 24], 18
		mov qword[moves + 32], 0
		jmp return


;------------------------------------------------
;movimientos de la T
rotateT:
	cmp rdi, 0
	je T0
	cmp rdi, 1
	je T1
	cmp rdi, 2
	je T2
	cmp rdi, 3
	je T3

T0: ; vuelve a la forma inicial
	mov qword[moves], -9
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return

T1:
	mov qword[moves], 11
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return

T2:
	mov qword[moves], 9
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return

T3:
	mov qword[moves], -11
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return


;------------------------------------------------
;movimientos de la S
rotateS:
	cmp rdi, 0
	je S0
	cmp rdi, 1
	je S1
	cmp rdi, 2
	je S0
	cmp rdi, 3
	je S1

S0: ;vuelve a la forma inicial
	; []      [][]
	; [][] -> [][]
	;  []
	;
	mov qword[moves], 0
	mov qword[moves + 8], 11
	mov qword[moves + 16], -2
	mov qword[moves + 24], 9
	jmp return

S1:
	;  [][] []
	; [][] -> [][]
	;  []
	;
	mov qword[moves], 0
	mov qword[moves + 8], -11
	mov qword[moves + 16], 2
	mov qword[moves + 24], -9
	jmp return

;------------------------------------------------
;movimientos de la Z
rotateZ:
	cmp rdi, 0
	je Z0
	cmp rdi, 1
	je Z1
	cmp rdi, 2
	je Z0
	cmp rdi, 3
	je Z1

Z0: ;vuelve a la inicial
	;  [] [][]
	; [][] ->  [][]
	; []
	;
	mov qword[moves], 9
	mov qword[moves + 8], 0
	mov qword[moves + 16], 11
	mov qword[moves + 24], 2
	jmp return

Z1:
	; [][]  []
	;  [][] -> [][]
	; []
	;
	mov qword[moves], -9
	mov qword[moves + 8], 0
	mov qword[moves + 16], -11
	mov qword[moves + 24], -2
	jmp return

;------------------------------------------------
;movimientos de la Z
rotateJ:
	cmp rdi, 0
	je J0
	cmp rdi, 1
	je J1
	cmp rdi, 2
	je J2
	cmp rdi, 3
	je J3

J0: ;vuelve a la forma inicial
	mov qword[moves], -2
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return

J1:
	mov qword[moves], 20
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return

J2:
	mov qword[moves], 2
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return

J3:
	mov qword[moves], -20
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return


;------------------------------------------------
;movimientos de la L
rotateL:
	cmp rdi, 0
	je L0
	cmp rdi, 1
	je L1
	cmp rdi, 2
	je L2
	cmp rdi, 3
	je L3

L0: ;vuelve a la forma inicial
	mov qword[moves], 2
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return

L1:
	mov qword[moves], 20
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return

L2:
	mov qword[moves], -2
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return

L3:
	mov qword[moves], -20
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return


return:
	ret
