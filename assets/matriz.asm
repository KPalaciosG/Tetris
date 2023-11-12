section .data
    matrix:  times 210 db '0'  ; matriz de 21x10 inicializada con ceros

	currentTetrinomio: times 5 dq 0 ; posiciones de memoria de los bloques que componen el tetrinomio actual
	color: db 0 ; color del tetrinomio actual

	moves: times 5 dq 0 ; array que se usa de auxiliar para almacenar posibles movimientos

	empty: equ '0' ; valor de un bloque vacio
	
	tetrinomioCounter db 0 ;contador del orden de salida de los tetrinomios futuros
	;array con el orden de salida de los tetrinomios
	tetrinomioOrder db 1, 2, 3, 4, 5, 6, 7
	tetrinomioOrderSize equ 7
		

section .text
	;"Delete"
	global clearAll

	;Gets: lines 29-74
    global getMatrix
	global getTetrinomio
	global getNextTetrinomio
	
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
	
	

; @brief Pone todos los valores como al inicio, en caso de que inicie una nueva partida	
; @param 
; @return void
clearAll:
	call clearMatrix
	call clearCurrentTetrinomio
	call clearMoves
	;call resetTetrinomioCounter
	

; @brief Pone todas los bytes de la matriz con el valor '0', para decir que vuelve a estar vacia	
; @param 
; @return void
clearMatrix:
	mov r8, matrix 
	mov r9, 0 ; contador
	
		clearMatrixLoop:
			cmp r9, 210
			jge return	
			
			mov byte[r8], '0'
			inc r8
			inc r9
			jmp clearMatrixLoop

; @brief Pone el array con las posiciones del tetrinomio actual en 0, es decir no hay tetrinomio
; @param 
; @return void			
clearCurrentTetrinomio:
	mov r8, matrix
	mov r9, 0 ;contador
	
		clearCurrentTetrinomioLoop:
			cmp r9, 5
			jge return	
			
			mov byte[r8], '0'
			inc r8
			inc r9
			jmp clearCurrentTetrinomioLoop
	
	
; @brief Retorna un puntero al primer byte del array de la matriz principal del juego
; @param 
; @return char*
getMatrix:
	mov r8, matrix
	add r8, 10
	mov rax, r8  
	ret


; @brief Toma el contador de futuro tetrinomio y el array que contiene el orden de salida de los tetrinomio
;		 Luego toma el valor que esta alamacenado en el array+contador
;		 Dependiendo del valor, va a la funcion encargada de graficar cada Tetrinomio en especifico
; @param 
; @return char
getTetrinomio:
	mov rbx, tetrinomioOrder  ;se guarda la direcciòn de memoria del arreglo de bloques
	xor rax, rax  ;se limpia el registro
	mov al, byte[tetrinomioCounter] 
		
	;usa el valor del contador para determinar el bloque
	;Si el contador supera 6, establece el contador en 0
	cmp byte[tetrinomioCounter], 7
	jae resetTetrinomioCounter
	
	cmp byte[rbx+rax], 1
	je blockI
	cmp byte[rbx+rax], 2
	je blockO
	cmp byte[rbx+rax], 3
	je blockT
	cmp byte[rbx+rax], 4
	je blockS
	cmp byte[rbx+rax], 5
	je blockZ
	cmp byte[rbx+rax], 6
	je blockJ
	cmp byte[rbx+rax], 7
	je blockL
		
		
; @brief Pone '1' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockI:
	; forma inicial
	; [1][2][3][4] -> 2 pivote
	
	;1
	mov r9, matrix
	add r9, 3 ;posicion del bloque
	mov byte[r9], '1' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 4 
	mov byte[r9], '1'  
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 5
	mov byte[r9], '1'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 6
	mov byte[r9], '1'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 4
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '1'
	inc byte[tetrinomioCounter] 
	
	mov al, 'I'
	ret
	
;-------------------------------
; @brief Pone '2' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockO:
	; forma inicial
	; [1][2] -> 2 pivote
	; [3][4] 
	
	;1
	mov r9, matrix
	add r9, 4 ;posicion del bloque
	mov byte[r9], '2' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 5
	mov byte[r9], '2'
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 14
	mov byte[r9], '2'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 15
	mov byte[r9], '2'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 5
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '2' 
	inc byte[tetrinomioCounter] 

	mov al, 'O'
	ret
	
;-------------------------------
; @brief Pone '3' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockT:
	; forma inicial
	;    [1] 	-> 3 pivote
	; [2][3][4] 
	
	;1
	mov r9, matrix
	add r9, 5 ;posicion del bloque
	mov byte[r9], '3' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 14
	mov byte[r9], '3'
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 15
	mov byte[r9], '3'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 16
	mov byte[r9], '3'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 15
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '3' 
	inc byte[tetrinomioCounter]
	
	mov al, 'T'
	ret

;-------------------------------
; @brief Pone '4' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockS:
	; forma inicial
	;    [1][2]	-> 1 pivote
	; [3][4] 
	
	;1
	mov r9, matrix
	add r9, 4  ;posicion del bloque
	mov byte[r9], '4' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 5
	mov byte[r9], '4'
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 13
	mov byte[r9], '4'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 14
	mov byte[r9], '4'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 4
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '4'
	inc byte[tetrinomioCounter]

	mov al, 'S'
	ret
	
;-------------------------------
; @brief Pone '5' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockZ:
	; forma inicial
	; [1][2]	-> 2 pivote
	;    [3][4] 
	
	;1
	mov r9, matrix
	add r9, 4 ;posicion del bloque
	mov byte[r9], '5' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 5
	mov byte[r9], '5'
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 15
	mov byte[r9], '5'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 16
	mov byte[r9], '5'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 5
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '5' 
	inc byte[tetrinomioCounter]
	
	mov al, 'Z'
	ret

;-------------------------------
; @brief Pone '6' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockJ:
	; forma inicial
	; [1]		-> 3 pivote
	; [2][3][4] 
	
	;1
	mov r9, matrix
	add r9, 4 ;posicion del bloque
	mov byte[r9], '6' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 14
	mov byte[r9], '6'
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 15
	mov byte[r9], '6'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 16
	mov byte[r9], '6'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 15
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '6'
	inc byte[tetrinomioCounter]

	mov al, 'J'
	ret

;-------------------------------
; @brief Pone '7' que corresponde al color del tetrinomio en la matriz del juego en ciertas posiciones para ubicar el tetrinomio que se va a usar
;		 Ademas estas posiciones se guardan en currentTetrinomio para poder manipularlo en el futuro
;		 Se guarda la posicion del pivote y el color del tetrinomio actual
;		 Retorna un char que corresponde al cual tetrinomio se va a usar
; @param 
; @return char 
blockL:
	; forma inicial
	;       [1]	 -> 3 pivote
	; [2][3][4] 
	
	;1
	mov r9, matrix
	add r9, 6 ;posicion del bloque
	mov byte[r9], '7' ;color
	mov qword[currentTetrinomio], r9 ;guarda la direccion del bloque
	;2
	mov r9, matrix
	add r9, 14
	mov byte[r9], '7'
	mov qword[currentTetrinomio+8], r9
	;3
	mov r9, matrix
	add r9, 15
	mov byte[r9], '7'
	mov qword[currentTetrinomio+16], r9
	;4
	mov r9, matrix
	add r9, 16
	mov byte[r9], '7'
	mov qword[currentTetrinomio+24], r9
	
	;guarda el pivote del tetrinomio
	mov r9, matrix
	add r9, 15
	mov qword[currentTetrinomio+32], r9
	;guarda el color y aumenta el contador del orden de los tetrinomios de salida
	mov byte[color], '7' 
	inc byte[tetrinomioCounter]

	mov al, 'L'
	ret
		
;------------------------------	
; @brief Cambia el orden de salida de los tetrinomios
; @param 
; @return 
;to do....
resetTetrinomioCounter:
	mov byte[tetrinomioCounter], 0
	
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
		jmp getTetrinomio 
		
; @brief Toma el array del orden de salida de los tetrinomios y toma el contador que dice el siguiente tetrinomio
;		 Se suma la direccion inicial del array y el contador y se sabe que cual sera el siguiente tetrinomio que se graficara
;		 Se retorna un char que corresponde al siguiente tetrinomio
; @param 
; @return char
getNextTetrinomio:
	mov rbx, tetrinomioOrder  ;se guarda la direcciòn de memoria del array del orden de salida de los tetrinomios
	xor rax, rax  ;se limpia el registro
	mov al, byte[tetrinomioCounter] ;contador del orden

	add rbx, rax ;obtiene la direccion del valor que contiene el siguiente tetrinomio
	
	cmp byte[rbx], 1
	mov al, 'I'
	je return
	cmp byte[rbx], 2
	mov al, 'O'
	je return
	cmp byte[rbx], 3
	mov al, 'T'
	je return
	cmp byte[rbx], 4
	mov al, 'S'
	je return
	cmp byte[rbx], 5
	mov al, 'Z'
	je return
	cmp byte[rbx], 6
	mov al, 'J'
	je return
	cmp byte[rbx], 7
	mov al, 'L'
	je return

	ret


;---------------------------
; MOVES
;---------------------------

; @brief Mueve el tetrinomio a la derecha
; 		 Recibe el char que corresponde al tetrinomio actual
; @param rdi = char
; @return void
moveRight:
	call clearMoves ;limpia el array que contendra los futuros posibles movimientos

	call checkRightBorder ;verifica si ya el tetrinomio esta en el borde derecho
	cmp al, 0 ; 0 = ya esta en el borde y no se puede mover a la derecha
	je return
	
	call movingRight ;obtiene los posibles movimientos que debe hacer cada bloque
	call validMove ;verifica si esos posibles movimientos son validos
	cmp al, 0 ; 0 = encontro algo que impide el movimiento, no se puede mover
	je return

	call deleteTetrinomio ;se puede mover, entonces limpia sus viejas posiciones
	call move ;mueve el tetrinomio a sus nuevas posiciones

	ret

; @brief Mueve rdi con 1 que es el valor que se debe sumar a las direcciones para moverse a la derecha	
; 		 Llama a saveMove que se encarga de calcular las direcciones nuevas
; @param 
; @return void
movingRight:
	mov rdi, 1
	call saveMove
	ret

; @brief Mueve el tetrinomio a la izquierda
; 		 Recibe el char que corresponde al tetrinomio actual
;		 Aplica la misma logica que mover a la derecha
; @param rdi = char
; @return void
moveLeft:
	call clearMoves 
	
	call checkLeftBorder ;Verifica si ya el tetrinomio se encuentra en el borde izquierdo
	cmp al, 0 ; 0 = ya esta en el borde y no se puede mover a la izquierdas
	je return
	
	call movingLeft 
	call validMove
	cmp al, 0
	je return

	call deleteTetrinomio 
	call move

	ret

; @brief Mueve rdi con -1 que es el valor que se debe sumar a las direcciones para moverse a la izquierda	
; 		 Llama a saveMove que se encarga de calcular las direcciones nuevas
; @param 
; @return void
movingLeft:
	mov rdi, -1
	call saveMove
	ret

; @brief Mueve el tetrinomio a la izquierda
; 		 Recibe el char que corresponde al tetrinomio actual
;		 Aplica la misma logica que mover a la derecha
; @param rdi = char
; @return void
moveDown:
	call clearMoves

	call movingDown
	call validMove
	cmp al, 0
	je return
	
	call deleteTetrinomio
	call move

	ret
; @brief Mueve rdi con 10 que es el valor que se debe sumar a las direcciones para moverse hacia abajo	
; 		 Llama a saveMove que se encarga de calcular las direcciones nuevas
; @param 
; @return void
movingDown:
	mov rdi, 10
	call saveMove
	ret
	
; @brief Rota el tetrinomio actual hacia la derecha
; 		 Recibe un int que es la cant de rotaciones que se han hecho en ese tetrinomio
;				un char que representa el tetrinomio que se quiere rotar
; @param rdi = int 
; 		 rsi = char
; @return void
rotateTetrinomio:
	call clearMoves ;limpia el array que contendra los futuros posibles movimientos
	cmp rsi, 'O' ;Este no rota, entonces se sale directamente
	je return
	
	;rdi = cant de rotaciones
	call getRotateType ;dependiendo de la cant de rotaciones que se han hecho, se calcula la rotacion que hay que hacer
	
	mov rdi, rax ;rax = el tipo de rotacion que hay que hacer
	call getRotateMoves ;calcula y guarda los posibles movimientos que se deben aplicar si se puede rotar el tetrinomio
	call borderCases ;Verifica y aplica cambios en los movimientos si se quiere rotar el tetrinomio estando en  un borde
	
	call validMove ;Verifica si la rotacion es valida, es decir todas las futuras posiciones estan vacias
	cmp al, 0 ; 0 = no se puede rotar
	je return

	call deleteTetrinomio  ;se puede rotar, entonces limpia sus viejas posiciones
	call move ;mueve el tetrinomio a sus nuevas posiciones
	ret

; @brief el tipo de rotacion que se va a hacer es el modulo entre 4 de la cantidad de rotaciones actuales
;		 esto porque solo podra retonar valores entre 0-3 es decir 4 tipos de rotaciones
; 		 Recibe un int que es la cant de rotaciones que se han hecho en ese tetrinomio
; @param rdi = int 
; @return int
getRotateType:
	mov rdx, 0 ; limpia rdx para aplicar la division
	mov rax, rdi ; mueve el dividendo
	mov r8, 4 ; el divisor es 4
	div r8 ; divide cantDeRotaciones / 4
	mov rax, rdx ; mueve a rax el modulo
	ret


; @brief Se encarga de ver cual es el tipo de tetrinomio que se quiere rotar y brinca a las rotaciones especificas de cada tetrinomio
;		 Primero ubica el tetrinomio que se va rotar y luego apartir del tipo de rotaciones, calcula los valores para la posible rotacion
; 		 Recibe un int que es el tipo de rotacion
;				un char que representa el tetrinomio que se quiere rotar
; @param rdi = int 
;        rsi = char
; @return void
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


; @brief toma las direcciones que se alamacenan en currentTetrinomio y pone '0' en cada una de ellas
; @param 
; @return void
deleteTetrinomio:
	mov r10, 0 ; contador y offset
	deleteLoop:
		mov r9, qword[currentTetrinomio + 8*r10] ; mueve a r9 cada direccion mas offset
		mov byte[r9], empty ;pone '0' en la direccion
		inc r10
		cmp r10, 4 ;se hace solo para las primeras 4 posiciones porque en el pivote no es necesario
		jl deleteLoop
	ret


; @brief pone en el array de moves, que representa posibles movimientos a aplicar sobre el tetrinomio
;		 recibe la cantidad que se le deben de sumar a la direccion de cada bloque del tetrinomio, para que se ubique en la posible posicion futura
; @param rdi = int
; @return void
saveMove:
	mov r10, 0 ;contador y offset
	saveMoveLoop:
		add qword[moves + 8*r10], rdi ;le suma a los moves cada valor que se desea
		inc r10
		cmp r10, 4
		jle saveMoveLoop
	ret


; @brief toma cada direccion del currentTetrinomio y le suma los valores almacenados en moves
;		 para poder ubicar cada bloque del tetrinomio en la posicion deseada
; @param 
; @return void
move:
	mov r10, 0 ; contador y offset
	moveLoop:
		mov r9, qword[currentTetrinomio + 8*r10] ; mueve a r9 la direccion de cada bloque
		add r9, qword[moves + 8*r10] ; se le suma a la direccion el valor correspondiente para obtener la direccion deseada
		mov r12b, byte[color]  
		mov byte[r9], r12b ;pone el valor que representa cada color de bloque en la nueva direccion del bloque
		mov qword[currentTetrinomio + 8*r10], r9 ;Toma la nueva direccion calcula de cada bloque y la almacena en el currentTetrinomio
		inc r10
		cmp r10, 4
		jl moveLoop

		;Actualizar el pivote
		mov r9, qword[currentTetrinomio + 8*r10] ;mueve el pivote a r9
		add r9, qword[moves + 8*r10] ;le suma el valor para obtener la nueva posicion del pivote
		mov qword[currentTetrinomio + 8*r10], r9 ;guarda la nueva posicion del pivote

		ret


;---------------------------
;VERIFICATIONS
;---------------------------

; @brief Se encarga de verificar si las futuras direcciones que compondran el currentTetrinomio, es decir currentTetrinomio + moves, son validas, es decir es posible ubicar un bloque ahi
;		 Esto lo hace buscando una direccion que cuando se le sume el valor de moves, no pertenezca a una direccion actual de currentTetrinomio
;		 Es decir, si un bloque se va a mover donde ya hay un bloque del tetrinomio actual, si se puede mover, porque a su vez ese se movera
;		 Cuando se tiene una direccion que no pertenece a currentTetrinomio, verifica si esta esta vacia
; @param 
; @return bool
validMove:
	mov r8, 0 ; contador y offset externo para ir calculando todas las futuras direcciones
	mov al, 1 ; bool que dice si es valido el movimiento, se inicia asumiendo en verdadero
	
	validMoveLoop:
		cmp r8, 4 ; si es >= 4 ya recorrio todas las futuras direcciones
		jge return 
		cmp al, 0 ; verifica si ya se sabe que no es un movimiento valido
		je return
		
		;Calcula la futura direccion que contendra un bloque
		mov r9, qword[currentTetrinomio + 8*r8]
		add r9, qword[moves + 8*r8]
		
		mov r10, 0 ; contador y offset interno que se mueve en las direcciones del currentTetrinomio
		mov bl, 0 ; bool que indica si la futura direccion ya se encuentra en una direccion del currentTetrinomio, se inicia asumiendo en falso
		
		findDifferentAddress:
			cmp r10, 4 ; verifica si ya termino de recorrer currentTetrinomio
			jge verifyValidMove
			
			cmp r9, qword[currentTetrinomio + 8*r10] ; compara la futura direccion con las direcciones en currentTetrinomio
			je found ; la encontro
			jne nextMove ; verificar en la siguiente direccion de currentTetrinomio
			
			found: ; si la encontro, pone el bool en verdadero y sigue buscando alguna que no este en currentTetrinomio
				mov bl, 1
				jmp nextPossibleMove
				
			nextMove: ; aumenta el contador interno para comparar con la siguiente direccion de currentTetrinomio
				inc r10
				jmp findDifferentAddress
			
			verifyValidMove: ; si la direccion no se encontraba en las direcciones de currentTetrinomio, se verifica si esta vacia
				cmp bl, 0
				je isAnEmptyBlock
		
			isAnEmptyBlock: ; verifica si la direccion esta vacia, es decir contiene '0'
				cmp byte[r9], empty
				je nextPossibleMove ; si esta vacia, verifica el siguiente movimiento que se quiere realizar
				mov al, 0 ; si no esta vacia, entonces no es un movimiento valido
		
		nextPossibleMove: ; incrementa el contador externo para seguir verificando los movimientos que se quieren realizar
			inc r8
			jmp validMoveLoop	


; @brief Verifica si el currentTetrinomio puede seguir bajando
;		 Lo que hace es "mover" el tetrinomio hacia abajo y ver si lo logro
; @param 
; @return bool
checkTetrinomioState:
	call clearMoves ; limpia los movimientos
	call checkBottomBorder ; verifica si esta en el final de la matriz
	mov rdi, 10
	call saveMove ; "mueve" el tetrinomio hacia abajo
	call validMove ; verifica si ese movimiento es valido, es decir, es posible bajar
	ret


; @brief Verifica si algun bloque del tetrinomio actual se encuentra en la primer fila de la matriz
;		 Lo hace verificando si alguna direccion del currentTetrinomio es menor a la direccion incial de la matriz + 10, es decir si la direccion es alguna de las primeras 10 de la matriz
;		 Se utiliza para decir si ya termino la partida
; @param 
; @return bool
checkMatrixState:
	mov r8, 0 ;contador y offset
	mov al, 1 ;bool que dice si alguna direccion es parte de las primeras 10 de la matriz
	checkMatrixStateLoop:
		mov r9, qword[currentTetrinomio + 8*r8] ;mueve cada direccion del currentTetrinomio a r9
		cmp r9, matrix + 10 ; compara si la direccion es menor que la primer direccion de la matriz + 10
		jl finishedGame ; si esta en las primeras 10, significa que ya termino la partida
		inc r8
		cmp r8, 4
		jl checkMatrixStateLoop
		ret
	
	finishedGame:
		mov al, 0
		ret
	
; @brief Verifica si algun bloque del tetrinomio actual se encuentra en la primer columna de la matriz, es decir la columna mas izquierda
;		 Se le resta a cada direccion del currentTetrinomio, la primer direccion de la matriz
;		 A ese valor se le calcula el modulo 10, y si es 0, significa que esa direccion esta en el primer columna
;		 retorna un bool que dice si se encuentra en el borde izquierdo o no
; @param 
; @return bool
checkLeftBorder:
	mov r8, matrix ; mueve a r8 la primer direccion de la matriz

	mov al, 1 ; bool que dice si se encuentra en el borde izquierdo
	mov r10, 0 ; contador y offset para el currentTetrinomio
	leftBorderLoop:
		mov rdx, 0 ; limpia rdx para la division
		mov rax, qword[currentTetrinomio + 8*r10] ; mueve a rax cada direccion del currentTetrinomio
		sub rax, r8 ; le resta a cada direccion la primer direccion de la matriz, asi se obtiene el dividendo
		
		mov r11, 10 ; divisor
		div r11
		cmp rdx, 0 ; verifica si el modulo es 0
		je cantMove ; 0 = esta en el borde izquierdo
		
		inc r10
		cmp r10, 4
		jl leftBorderLoop
		
	ret
	
; @brief Verifica si algun bloque del tetrinomio actual se encuentra en la ultima columna de la matriz, es decir la columna mas derecha
;		 Se le resta a cada direccion del currentTetrinomio, la primer direccion de la matriz + 9, es decir, se le resta la direccion del primer bloque de la columna mas derecha de la matriz
;		 A ese valor se le calcula el modulo 10, y si es 0, significa que esa direccion esta en el ultima columna
;		 retorna un bool que dice si se encuentra en el borde derecho o no
; @param 
; @return bool
checkRightBorder:
	mov r8, matrix ; primer direccion de la matriz
	add r8, 9 ; calcula el primer bloque de la columna mas derecha
	
	mov al, 1 ; bool que dice si se encuentra en el borde derecho o no
	mov r10, 0 ; contador y offset para el currentTetrinomio
	rightBorderLoop:
		mov rdx, 0 ; limpia rdx para la division
		mov rax, qword[currentTetrinomio + 8*r10] ; mueve a rax cada direccion del currentTetrinomio
		sub rax, r8 ; le resta a cada direccion la primer direccion del primer bloque de la columna mas derecha de la matriz, asi se obtiene el dividendo
		
		mov r11, 10 ; divisor
		div r11
		cmp rdx, 0 ; verifica si el modulo es 0
		je cantMove ; 0 = esta en el borde derecho
		
		inc r10
		cmp r10, 4
		jl rightBorderLoop
		
	ret
	
; @brief Verifica si algun bloque del tetrinomio actual se encuentra en la ultima fila de la matriz
;		 Se le suma a la primer direccion de la matriz 200, obteniendo de esta forma, la primer direccion de la ultima fila de la matriz
;		 Se compara cada direccion del currentTetrinomio con esa direccionn y si es mayor, significa que se encuentra en la ultima fila
;		 retorna un bool que dice si se encuentra en la ultima fila o no
; @param 
; @return bool
checkBottomBorder:
	mov r8, matrix ; primer direccion de la matriz
	add r8, 200 ; se obtiene la primer direccion de la ultima fila de la matriz

	mov al, 1 ; bool que dice si algun bloque se encuentra en la ultima fila
	mov r10, 0 ; contador y offset del currentTetrinomio
	bottomBorderLoop:
		cmp r10, 4
		jge return
		
		mov rax, qword[currentTetrinomio + 8*r10]
		cmp rax, r8 ; verifica si la direccion del currentTetrinomio es mayor, es decir esta en la ultima fila
		jg cantMove
		
		inc r10
		jmp bottomBorderLoop
	
cantMove:
	mov al, 0
	ret


;-----------------
; @brief Verifica si el pivote del tetrinomio actual se encuentra en algun borde
;		 Esta funcion se utiliza para las rotaciones, ya que normalmente si el pivote esta en el borde, simplemente la figura no rotaria
;		 Sin embargo para hacer el juego mas dinamico se manipulan los movimientos para rotar, de tal forma que se mueva el tetrinomio permitiendo la rotacion y que sean validas las rotaciones en estos casos
; @param rsi = char
; @return void
borderCases:	
	mov r8, matrix 
	mov r9, qword[currentTetrinomio + 32] ;mueve a r9 el pivote

	;Case Left Border
	;Si el pivote esta en el borde izquierdo, para girar necesita correr 1 a la derecha el tetrinomio
	mov rax, r9 ; mueve a rax la direccion del pivote
	sub rax, r8 ; le resta a esta direccion la primer direccion de la matriz
	
	mov rdx, 0 
	mov r10, 10 
	div r10 ; obtener modulo 10
	
	mov rdi, 1 ; mueve un 1 a rdi, para que saveMove le sume 1 a moves que es el movimiento necesario para poder rotar
	cmp rdx, 0 ; verifica si el modulo es 0
	je saveMove ; 0 = esta en el borde izquierdo y le debe sumar 1 a los futuros movimientos

	;Case Right Border
	;Si el pivote esta en el borde derecho, para girar necesita correr 1 a la izquierda el tetrinomio
	mov rax, r9 ;mueve a rax la direccion del pivote
	add r8, 9 ; le suma 9 a la primer direccion de la matriz, para obtener la primer direccion de la columna derecha
	sub rax, r8 ; le resta a la direccion del pivote la primer direccion de la columna derecha
	
	mov rdx, 0
	mov r10, 10
	div r10 ; obtener modulo 10
	
	mov rdi, -1  ; mueve un -1 a rdi, para que saveMove le sume -1 a moves que es el movimiento necesario para poder rotar
	cmp rsi, 'I' ; en caso de ser 'I' necesita moverse 2 a la izquierda debido a su forma
	jne oneLeft
		mov rdi, -2
		
	oneLeft:
	cmp rdx, 0 ; verifica si el modulo es 0
	je saveMove ; 0 = esta en el borde izquierdo y le debe sumar 1 a los futuros movimientos
	
	;Caso especifico para 'I', ya que si esta un bloque antes de la columna derecha, tambien se necesita correr 1 hacia la izquierda para poder rotar
	;es la misma logica que antes, pero compara con 1 bloque antes del borde y es solo para 'I'
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
	;Case Bottom Border
	;Si el pivote esta en el borde de abajo, para girar necesita subir el tetrinomio, eso hace
	mov rdi, -10 ; mueve un -10 a rdi, para que saveMove le sume -10 a moves que es el movimiento necesario para poder rotar
	cmp rsi, 'I' ; si el tetrinomio es 'I' necesita subir 2 filas
	jne oneUp
		mov rdi, -20
		
	oneUp:
	cmp r9, matrix+200 ; verifica si el pivote es mayor que la primer direccion de la ultima fila de la matriz
	jg saveMove

	ret

;---------------------------
; AUXILIARES
;---------------------------

; @brief Pone todos los valores del array de moves en 0
; @param 
; @return void
clearMoves:
	mov r10, 0 ; contador y offset
	clearMoveLoop:
		mov qword[moves + 8*r10], 0 ; pone en cero cada valor
		inc r10
		cmp r10, 4
		jle clearMoveLoop
	ret
	

; @brief Limpia las filas que ya estan completas, es decir las filas que de inicio a fin tiene un valor distinto a '0' las vuelve a poner con '0'
;		 retorna un int con el puntaje obtenido = 100 * cada fila completa
; @param 
; @return int	
clearRows:
	mov r8, matrix ; primera direccion de la matriz
	add r8, 10 ; le suma 10, para obtener la primera direccion de la matriz "jugable"
	mov r9, 0 ;contador y offset externo para las filas
	
	mov r15, 0 ; alamacena el puntaje obtenido
	clearRowsLoop:
		cmp r9, 200 ; verifica si ya recorrio todas las filas
		mov rax, r15 ; se prepara para retornar el puntaje en caso de ser verdadero
		jge return
		
		mov rdi, r8 ; mueve a rdi, la primera direccion de la segunda fila de la matriz, es decir la primer fila jugable
		add rdi, r9 ; le suma el offset para obtener la primera direccion de la fila que se va a verificar si esta completa
		call isAFullRow ; verifica si la fila esta llena
		
		;Se prepara para eliminarla en caso de ser verdadero
		mov rdi, r8 ; mueve a rdi, la primera direccion de la segunda fila de la matriz, es decir la primer fila jugable
		add rdi, r9 ; le suma el offset para obtener la primera direccion de la fila que se va a verificar si esta completa
		cmp al, 1 ; 1 = fila llena
		je fullRow ; limpia la fila
		
	nextRow:
		add r9, 10 ; le suma al r9 10 para obtener la primer direccion de la siguiente fila
		jmp clearRowsLoop
	
; @brief Verifica si una fila de la matriz esta completa	
;		 recibe una direccion que corresponde a la primer direccion de la fila que verifica
;		 retorna un bool que dice si la fila esta llena
; @param rdi = direccion 
; @return bool	
isAFullRow:
	mov al, 1 ; bool que dice si la fila esta llena, se inicia asumiendo que lo esta
	
	mov r10, rdi ; mueve a rdi la direccion recibida
	mov r11, 0 ; contador y offset para la fila
	isAFullRowLoop:
		cmp r11, 10 ; verifica si ya recorrio la fila
		jge return
		cmp al, 0 ; verifica si ya se sabe que no es una fila completa para no seguir
		je return
		
		cmp byte[r10], empty ; verifica si la direccion contiene '0'
		jne nextBlock ; si no esta vacia sigue con el siguiente direccion
		mov al, 0 ; la fila no esta completa
		
		nextBlock:
			inc r10 ; siguiente direccion
			inc r11 ; aumenta contador
			jmp isAFullRowLoop
	
; @brief Limpia la fila de la matriz apartir de la primer direccion de la misma	
;		 Tambien aumenta la cantidad de puntos ganados
;		 recibe una direccion que corresponde a la primer direccion de la fila que limpia
; @param rdi = direccion 
; @return void
fullRow:
	call emptyRow ; limpia la fila
	add r15, 100 ; aumenta los puntos
	jmp nextRow ; vuelve para verificar la siguiente fila
	
; @brief Limpia la fila de la matriz apartir de la primer direccion de la misma	
;		 recibe una direccion que corresponde a la primer direccion de la fila que limpia
; @param rdi = direccion 
; @return void
emptyRow:
	mov r10, rdi ; mueve la direccion recibida a r10
	mov r11, 0 ; contador y offset
	
	emptyRowLoop:
		cmp r11, 10 ; verifica si ya recorrio toda la fila
		jge return
		
		mov byte[r10], empty ; mueve a la direccion '0'

		inc r10 ; siguiente direccion
		inc r11 ; incrementa contador
		jmp emptyRowLoop


	
; @brief Baja todas las filas con bloques que tengan una fila en blanco abajo
;		 La logica que se sigue es, que si la fila siguiente a la actual analiza esta vacia, bajar lo que esta en la fila actual a la siguiente
; @param 
; @return void
dropAllBlocks:
	mov r8, matrix ; mueve a r8 la primer direccion de la matriz
	add r8, 10 ; suma 10 a r8 para obtener la primer direccion del area jugable de la matriz
	
	mov r9, 0 ; contador y offset para las filas
	
	dropAllBlocksLoop:
		cmp r9, 200 ; verifica si ya recorrio todas las filas
		jge isThereEmptyRows ; verificar si aun quedan filas vacias
		
		mov rdi, r8 ; mueve la primer direccion de la matriz jugable
		add rdi, r9 ; le suma el offset para obtener la fila que se verificara si esta vacia, es decir la siguiente
		call isAnEmptyRow ; verifica si la fila esta vacia
		
		;se preparan los valores en caso de que la fila este vacia
		mov rdi, r8 ; mueve la primer direccion de la matriz jugable
		add rdi, r9 ; le suma el offset para obtener la fila que se verificara si esta vacia, es decir la siguiente
		cmp al, 1 ; 1 = fila vacia
		je dropUpperBlocks ; si la fila esta vacia, bajar los bloques que estan sobre esa fila vacias
		
	nextRow2: 
		add r9, 10 ; le suma al r9 10 para obtener la primer direccion de la siguiente fila
		jmp dropAllBlocksLoop

; @brief Verifica si hay filas vacias, pero filas vacias que tienen bloques en la fila superior
;		 La logica que se sigue es, que si la fila actual analizada, no esta vacia y la fila siguiente si esta vacia, aun se pueden seguir bajando bloques 
; @param 
; @return void
isThereEmptyRows:
	mov r8, matrix ; mueve a r8 la primer direccion de la matriz
	
	mov r9, 0 ; contador y offset para las filas
	
	mov al, 0 ; bool que dice si encuentra alguna fila con bloques sobre una vacia
	isThereEmptyRowsLoop:
		cmp r9, 200 ; verifica si ya recorrio todas las filas
		jge return
		
		mov rdi, r8 ; mueve la primer direccion de la matriz
		add rdi, r9 ; le suma el offset para obtener la fila que se verificara si esta vacia, es decir la actual
		call isAnEmptyRow ; verifica si esta vacia
		
		cmp al, 1 ; 1 = fila vacia
		je nextRow3 ; si esta vacia entonces no es necesario verificar la siguiente y se avanza a la siguiente fila
		add rdi, 10 ; si no esta vacia, se le suma 10 a la direccion de la fila actual, para obtener la direccion de la siguiente fila y verificar si esta vacia 
		call isAnEmptyRow ; verifica si esa fila, es decir la siguiente de la actual esta vacia
		cmp al, 1 ; 1 = fila vacia
		je dropAllBlocks ; si la fila esta vacia significa que todavia se puede seguir bajando bloques y se vuelve a llamar al ciclo
		
	nextRow3:
		add r9, 10 ; le suma al r9 10 para obtener la primer direccion de la siguiente fila
		jmp isThereEmptyRowsLoop

; @brief Verifica si la fila esta vacia	 
; @param rdi = direccion
; @return bool
isAnEmptyRow:
	mov al, 1 ; bool que indica si la fila esta vacia, se asume que si lo esta
	mov r10, rdi ; se mueve a r10, la primer direccion de la fila
	mov r11, 0 ; contador y offset de la fila
	
	isAnEmptyRowLoop:
		cmp r11, 10 ; verifica si ya recorrio toda la fila
		jge return
		cmp al, 0 ; verifica si ya se sabe que no esta vacia
		je return
		
		cmp byte[r10], empty ; compara el valor de la direccion con '0' para ver si esta vacia
		je nextBlock2 ; si esta vacia se avanza a la siguiente direccion
		mov al, 0 ; no esta vacia
		
		nextBlock2:
			inc r10 ; siguiente direccion
			inc r11 ; incrementa contador
			jmp isAnEmptyRowLoop

; @brief Baja los bloques de la fila superior, es decir pone los bloques de la fila superior en la fila actual
; @param rdi = direccion
; @return void
dropUpperBlocks:
	mov r10, rdi ; mueve a r10 la primer direccion de la fila
	sub r10, 10 ; le resta 10 a la direccion para ubicarse en la fila superior
	
	mov r11, 0 ; contador y offset de la fila
	dropUpperBlocksLoop:
		cmp r11, 10 ; verifica si ya recorrio toda la fila
		jge dropped
			
		mov r12b, byte[r10] ; mueve a r12b cada valor que contienen las direcciones de la fila superior
		mov byte[r10+10], r12b ; pone cada valor del bloque superior en el bloque de la fila actual
		
		inc r10 ; siguiente direccion
		inc r11 ; incrementa contador
		jmp dropUpperBlocksLoop

	dropped:
		sub rdi, 10 ; le resta a rdi 10, para tener la direccion de la fila superior y poder limpiarla
		call emptyRow ; limpia la fila superior
		jmp nextRow2


;---------------------------------------
;	
;ROTACIONES
;
;---------------------------------------

; @brief Todas las rotaciones siguen el mismo formato, alamacenar en moves, los valores que se le deben sumar a las direcciones de currentTetrinomio para ubicar en tetrinomio en la posicion deseada
; @param rdi = tipo de movimiento
; @return void

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
		;   []		[]
		; [][] -> [][][]
		;	[]
		;
		mov qword[moves], -9
		mov qword[moves + 8], -11
		mov qword[moves + 16], 0
		mov qword[moves + 24], 11
		jmp return

	T1: ;Movimiento 1
		; 	[]		[]
		; [][][] -> [][]
		;			[]
		;
		mov qword[moves], 11
		mov qword[moves + 8], -9
		mov qword[moves + 16], 0
		mov qword[moves + 24], 9
		jmp return

	T2: ;Movimiento 2
		; []	  [][][]	
		; [][] ->   []
		; []
		;
		mov qword[moves], 9
		mov qword[moves + 8], 11
		mov qword[moves + 16], 0
		mov qword[moves + 24], -11
		jmp return

	T3: ;Movimiento 3
		; [][][]	  []
		;   []   -> [][]
		;			  []
		;
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
		; []        [][]
		; [][] -> [][]
		;  	[]
		;
		mov qword[moves], 0
		mov qword[moves + 8], 11
		mov qword[moves + 16], -2
		mov qword[moves + 24], 9
		jmp return

	S1: ;Movimiento 1
		;   [][]    []
		; [][]   -> [][]
		;  			  []
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
	;   []    [][]
	; [][] ->   [][]
	; []
	;
	mov qword[moves], 9
	mov qword[moves + 8], 0
	mov qword[moves + 16], 11
	mov qword[moves + 24], 2
	jmp return

Z1: ;Movimiento 1
	; [][]        []
	;   [][] -> [][]
	;           []
	;
	mov qword[moves], -9
	mov qword[moves + 8], 0
	mov qword[moves + 16], -11
	mov qword[moves + 24], -2
	jmp return

;------------------------------------------------
;movimientos de la J
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
	;   []	  []
 	;   [] -> [][][]
	; [][]
	;
	mov qword[moves], -20
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return

J1: ;Movimiento 1
	; []        [][]
	; [][][] -> []
	;			[]
	;
	mov qword[moves], 2
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return

J2: ;Movimiento 2
	; [][]    [][][]
	; []   -> 	  []
	; []
	;
	mov qword[moves], 20
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return

J3: ;Movimiento 3
	; [][][]      []
 	; 	  [] ->   []
	;			[][]
	;
	mov qword[moves], -2
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
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
	; [][]	      []
 	;   [] -> [][][]
	;   []
	;
	mov qword[moves], 2
	mov qword[moves + 8], -11
	mov qword[moves + 16], 0
	mov qword[moves + 24], 11
	jmp return

L1: ;Movimiento 1
	;     []    []
	; [][][] -> []
	;			[][]
	;
	mov qword[moves], 20
	mov qword[moves + 8], -9
	mov qword[moves + 16], 0
	mov qword[moves + 24], 9
	jmp return

L2: ;Movimiento 2
	; []      [][][]
	; []   -> []	 
	; [][]
	;
	mov qword[moves], -2
	mov qword[moves + 8], 11
	mov qword[moves + 16], 0
	mov qword[moves + 24], -11
	jmp return

L3: ;Movimiento 3
	; [][][]    [][]
 	; []     ->   []
	;			  []
	;
	mov qword[moves], -20
	mov qword[moves + 8], 9
	mov qword[moves + 16], 0
	mov qword[moves + 24], -9
	jmp return

return:
	ret
