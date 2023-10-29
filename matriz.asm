section .data
    matrix: db 21, 10  ; Dimensiones de la matrix (filas, columnas)
    array:  times 210 db '0'  ; matrix de 21x10 inicializada con ceros

currentTetrinomio: times 5 dq 0
color: db 0

moves: times 5 dq 0
;pivotRight: db 3
;pivotLeft: db 3

empty: equ '0'

section .text
    global getMatrix
	global getBlock
	global rotateTetrinomio
	global moveRight
	global moveLeft
	global moveDown
	
	global checkTetrinomioState
	
getMatrix:
	mov r8, array
	add r8, 10
	mov rax, r8  ; Dirección base de la matrix
	ret


getBlock:
	;Pivote del Tetrinomio I es el 2 bloque
	mov r9, matrix
	add r9, 34
	mov byte[r9], '1'
	mov qword[currentTetrinomio], r9

	mov r9, matrix
	add r9, 35
	mov byte[r9], '1'
	mov qword[currentTetrinomio+8], r9

	mov r9, matrix
	add r9, 36
	mov byte[r9], '1'
	mov qword[currentTetrinomio+16], r9

	mov r9, matrix
	add r9, 37
	mov byte[r9], '1'
	mov qword[currentTetrinomio+24], r9

	mov r9, matrix
	add r9, 35
	mov qword[currentTetrinomio+32], r9

	mov byte[color], '1'

	ret

;mover el tetronimo a la derecha
;rsi = tipo de tetrinomio
moveRight:
	call cleanMoves
	cmp rsi, 'O' ;no debe hacer nada
	je return

	call checkRightBorder
	cmp al, 0
	je return

	call deleteTetrinomio ;limpia la matriz
	call movingRight

	ret
;mover el tetronimo a la izquierda
;rsi = tipo de tetrinomio
moveLeft:
	call cleanMoves
	cmp rsi, 'O' ;no debe hacer nada
	je return
	
	call checkLeftBorder
	cmp al, 0
	je return

	call deleteTetrinomio ;limpia la matriz
	call movingLeft

	ret

;rsi = tipo de tetrinomio
moveDown:
	call cleanMoves
	
	call checkBottomBorder
	cmp al, 0
	je return
	call movingDown
	call validMove
	cmp al, 0
	je return
	
	call deleteTetrinomio ;limpia la matriz
	call move

	ret

checkTetrinomioState:
	call cleanMoves
	call checkBottomBorder
	mov rdi, 10
	call saveMove
	call validMove
	ret
	
checkLeftBorder:
	mov r8, array

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
	mov r8, array
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
	mov r8, array
	add r8, 200

	mov al, 1
	mov r10, 0
	bottomBorderLoop:
		mov rax, qword[currentTetrinomio + 8*r10]
		
		cmp rax, r8
		jg cantMove
		
		inc r10
		cmp r10, 4
		jl bottomBorderLoop
		
	ret
	
cantMove:
	mov al, 0
	ret


;rdi = cantidad de movimientos
;rsi = tipo de tetrinomio
rotateTetrinomio:
	call cleanMoves
	cmp rsi, 'O' ;no debe hacer nada
	je return

	mov rdi, rdi ;cantidad de movimientos
	call getRotateType
	
	mov rdi, rax ;manda como parametro el movimiento que debe hacer
	call getRotateMoves ;retorna los movimientos del caso
	call borderCases ;Verifica si se quiere realizar una rotacion pegado a un borde
	
	;call validMove ;verificar si no hay nada ahi y se puede mover
	;cmp al, 0
	;je return

	call deleteTetrinomio ;limpia la matriz
	call move ;dibuja en la matriz en las nuevas posiciones y las guarda en currentTetrinomio
	ret


getRotateType:
	; y el movimiento es la cantidad de movimientos que lleva % 4
	mov rdx, 0
	mov rax, rdi ; se puede hacer con 32
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

;---------------------------
;to do.. valid move



;-----------------
borderCases:
	;Verifica si el pivote esta en una posicion particular cuando se intenta girar
	;en caso de que sea asi, modifica los futuros movimientos, para que se verifiquen tambien si son validos
	mov r8, array
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
	cmp r9, array+200
	jg saveMove

	ret
	
saveMove:
	mov r10, 0
	saveMoveLoop:
		add qword[moves + 8*r10], rdi
		inc r10
		cmp r10, 4
		jle saveMoveLoop
	ret



;-----------------------------
deleteTetrinomio:
	mov r10, 0
	deleteLoop:
		mov r9, qword[currentTetrinomio + 8*r10]
		mov byte[r9], empty
		inc r10
		cmp r10, 4
		jl deleteLoop
ret

;-----------------------------
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

;Forma Alternativa de mover
movingRight:
	mov rdi, 1
	call cleanMoves
	call saveMove
	call move
	ret

movingLeft:
	mov rdi, -1
	call cleanMoves
	call saveMove
	call move
	ret

movingDown:
	mov rdi, 10
	call cleanMoves
	call saveMove
	ret

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


validMove:
	mov r8, 0
	mov al, 1
	
	innerLoop:
		cmp r8, 4
		jge return
		cmp al, 0
		je return
		
		mov r9, qword[currentTetrinomio + 8*r8]
		add r9, qword[moves + 8*r8]
		
		mov r10, 0
		mov bl, 0 ;encontro la posicion = false
		
		findDiferentBlock:
			cmp r10, 4
			jge verifyValidMove
			
			cmp r9, qword[currentTetrinomio + 8*r10]
			je encontrada
			jne nextMove
			
			encontrada:
				mov bl, 1
				jmp siguiente
				
			nextMove:
				inc r10
				jmp findDiferentBlock
			
			verifyValidMove:
				cmp bl, 0
				je isAnEmptyBlock
		
			isAnEmptyBlock:
				cmp byte[r9], empty
				je siguiente
				mov al, 0
		
			siguiente:
				inc r8
				jmp innerLoop
			
return:
ret


;---------------------------
cleanMoves:
	mov r10, 0
	mov r11, 0
	cleanMoveLoop:
		mov qword[moves + 8*r10], r11
		inc r10
		cmp r10, 4
		jle cleanMoveLoop
	ret
	
	


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
	; []
	; [][][][]  -> []
	; []
	; []
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

