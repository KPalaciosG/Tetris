section .data
    matrix: db 21, 10  ; Dimensiones de la matrix (filas, columnas)
    array:  times 210 db '0'  ; matrix de 21x10 inicializada con ceros
	
	currentTetrinomio: times 5 dq 0
	color: db 0
	
	moves: times 5 dq 0
	
	empty: equ '0'

section .text
    global getMatrix
	global getBlock
	global rotateTetrinomio

getMatrix:
	mov r8, array
	add r8, 10
    mov rax, r8  ; Dirección base de la matrix
    ret
	
	
getBlock:
	mov r9, matrix
	add r9, 38
	mov byte[r9], '1'
	mov qword[currentTetrinomio], r9
	
	mov r9, matrix
	add r9, 46
	mov byte[r9], '1'
	mov qword[currentTetrinomio+8], r9
	
	mov r9, matrix
	add r9, 47
	mov byte[r9], '1'
	mov qword[currentTetrinomio+16], r9
	
	mov r9, matrix
	add r9, 48
	mov byte[r9], '1'
	mov qword[currentTetrinomio+24], r9
	
	mov r9, matrix
	add r9, 36
	mov qword[currentTetrinomio+32], r9
	
	mov byte[color], '1'
	
	ret


;rdi = cantidad de movimientos
;rsi = tipo de tetrinomio
rotateTetrinomio:
	cmp rsi, 'O' ;no debe hacer nada
	je return
	
	mov rdi, rdi ;cantidad de movimientos
	call getTypeMove
	mov rdi, rax ;manda como parametro el movimiento que debe hacer
	call getMoves ;retorna los movimientos del caso
	
	call validMove ;verificar si no hay nada ahi y se puede mover, tambien los bordes
	cmp al, 0
	je return
	
	call deleteTetrinomio ;limpia la matriz
	call rotate ;dibuja en la matriz en las nuevas posiciones y las guarda en currentTetrinomio	
	ret
	
	
getTypeMove:
	; y el movimiento es la cantidad de movimientos que lleva % 4
	mov rdx, 0
	mov rax, rdi ; se puede hacer con 32
	mov r8, 4
	div r8
	mov rax, rdx
	ret
	
	
getMoves:
	cmp rsi, 'I'
	je getMovesI
	
	cmp rsi, 'T'
	je getMovesT
	
	cmp rsi, 'S'
	je getMovesS
	
	cmp rsi, 'Z'
	je getMovesZ
	
	cmp rsi, 'J'
	je getMovesJ
	
	cmp rsi, 'L'
	je getMovesL
	
;---------------------------------
;movimientos de la I
getMovesI:
	cmp rdi, 0
	je moveI0
	cmp rdi, 1
	je moveI1
	cmp rdi, 2
	je moveI0
	cmp rdi, 3
	je moveI1

moveI0: ;vuelve a la forma inicial
	;	[]
	;	[]		->	[][][][] 
	;	[]
	;	[]
	mov qword[moves], 9
	mov qword[moves + 8], 0
	mov qword[moves + 16], -9
	mov qword[moves + 24], -18
	jmp return

moveI1:	
	;					[]
	;	[][][][]  ->	[]
	; 					[]
	;					[]
	mov qword[moves], -9
	mov qword[moves + 8], 0
	mov qword[moves + 16], 9
	mov qword[moves + 24], 18
	mov qword[moves + 32], 0
	jmp return


;------------------------------------------------
;movimientos de la T
getMovesT:	
	cmp rdi, 0
	je moveT0
	cmp rdi, 1
	je moveT1
	cmp rdi, 2
	je moveT2
	cmp rdi, 3
	je moveT3

moveT0:	; vuelve a la forma inicial
	mov qword[moves], -9
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return

moveT1:	
	mov qword[moves], 11
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return
	
moveT2:	
	mov qword[moves], 9
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return
	
moveT3:	
	mov qword[moves], -11
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return
	
	
;------------------------------------------------
;movimientos de la S
getMovesS:	;se puede reducir a 2 movimientos
	cmp rdi, 0
	je moveS0
	cmp rdi, 1
	je moveS1
	cmp rdi, 2
	je moveS0
	cmp rdi, 3
	je moveS1

moveS0:	;el ultimo que hace, vuelve a la forma original
	;	[]	  	  	  [][]
	;	[][]	->	[][]
	;	  []
	;
	mov qword[moves], 0
	mov qword[moves + 8], 11
	mov qword[moves + 16], -2
	mov qword[moves + 24], 9
	jmp return

moveS1:	
	;	  [][]		[]	 
	;	[][]	->	[][]
	;		 	 	  []
	;
	mov qword[moves], 0
	mov qword[moves + 8], -11
	mov qword[moves + 16], 2
	mov qword[moves + 24], -9
	jmp return
	
;moveS2:	
;	mov qword[moves], 0
;	mov qword[moves + 8], 11
;	mov qword[moves + 16], -2
;	mov qword[moves + 24], 9
;	jmp return
	
;moveS3:	
;	mov qword[moves], 0
;	mov qword[moves + 8], -11
;	mov qword[moves + 16], 2
;	mov qword[moves + 24], -9
;	jmp return
	
	
;------------------------------------------------
;movimientos de la Z
getMovesZ:	;se puede reducir a 2 movimientos
	cmp rdi, 0
	je moveZ0
	cmp rdi, 1
	je moveZ1
	cmp rdi, 2
	je moveZ0
	cmp rdi, 3
	je moveZ1

moveZ0:	;el ultimo que hace, vuelve a la forma original
	;	  []		[][]
	;	[][]	->	  [][]
	;	[]
	;
	mov qword[moves], 9
	mov qword[moves + 8], 0
	mov qword[moves + 16], 11
	mov qword[moves + 24], 2
	jmp return

moveZ1:	
	;	[][]		  []
	;	  [][]	->	[][]
	;				[]
	;
	mov qword[moves], -9
	mov qword[moves + 8], 0
	mov qword[moves + 16], -11
	mov qword[moves + 24], -2
	jmp return
	
;moveZ2:	
;	mov qword[moves], 9
;	mov qword[moves + 8], 0
;	mov qword[moves + 16], 11
;	mov qword[moves + 24], 2
;	jmp return
	
;moveZ3:	
;	mov qword[moves], -9
;	mov qword[moves + 8], 0
;	mov qword[moves + 16], -11
;	mov qword[moves + 24], -2
;	jmp return
	
	
;------------------------------------------------
;movimientos de la Z
getMovesJ:	;se puede reducir a 2 movimientos
	cmp rdi, 0
	je moveJ0
	cmp rdi, 1
	je moveJ1
	cmp rdi, 2
	je moveJ2
	cmp rdi, 3
	je moveJ3

moveJ0:	;el ultimo que hace, vuelve a la forma original
	mov qword[moves], -2
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return

moveJ1:	
	mov qword[moves], 20
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return
	
moveJ2:	
	mov qword[moves], 2
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return
	
moveJ3:	
	mov qword[moves], -20
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return	
	


;------------------------------------------------
;movimientos de la L
getMovesL:	;se puede reducir a 2 movimientos
	cmp rdi, 0
	je moveL0
	cmp rdi, 1
	je moveL1
	cmp rdi, 2
	je moveL2
	cmp rdi, 3
	je moveL3

moveL0:	;el ultimo que hace, vuelve a la forma original
	mov qword[moves], 2
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return

moveL1:	
	mov qword[moves], 20
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return
	
moveL2:	
	mov qword[moves], -2
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return
	
moveL3:	
	mov qword[moves], -20
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return	
	
	

validMove:
	mov r10, 0
	mov al, 1
	
validMoveLoop:
	cmp al, 0
	je return
	
	mov r9, qword[currentTetrinomio + 8*r10]
	add r9, qword[moves + 8*r10]
	cmp r9, empty
	jne isNotEmpty
	
	inc r10
	cmp r10, 4
	jl validMoveLoop
	
	je return
	
isNotEmpty: ;hay algun bloque donde se iba a mover
	mov al, 0
	je return
	
	
	
deleteTetrinomio:
	mov r10, 0
deleteLoop:
	mov r9, qword[currentTetrinomio + 8*r10]
	mov byte[r9], empty
	inc r10
	cmp r10, 4
	jl deleteLoop
	ret

rotate: ; to do hacer esto en un ciclo ; cambiar el pivote
	mov r10, 0
	
rotateLoop:
	mov r9, qword[currentTetrinomio + 8*r10]
	add r9, qword[moves + 8*r10]
	mov r12b, byte[color]
	mov byte[r9], r12b
	mov qword[currentTetrinomio + 8*r10], r9
	inc r10
	cmp r10, 4
	jl rotateLoop
	
	ret
	
	
return:
	ret