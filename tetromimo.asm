section .bss
matrix: resb 200 ;se separan 200 espacios en memoria

section .data

x: dd 10
y: dd 20

matrixLen: dd 200 ;tamaño de la matriz

section .text
global _start
_start:


mov rbx, matrix 

;--------definicion de bloques---------
bloqueI:
;bloque I: [1][1][1][1] color rojo
mov byte[rbx+3], '1'
mov byte[rbx+4], '1'
mov byte[rbx+5], '1'
mov byte[rbx+6], '1'
mov r12, 3 	; limite de movimientos hacia derecha 
mov r13, 3 	; limite de movimientos hacia la izquierda
mov r14, 19 ; limite de movimientos hacia abajo


bloqueO:
;bloque O: [2][2] color azúl
;          [2][2]
mov byte[rbx+4], '2'
mov byte[rbx+5], '2'
mov byte[rbx+14], '2'
mov byte[rbx+15], '2'
mov r12, 4 	; limite de movimientos hacia derecha 
mov r13, 4 	; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo


bloqueT:
;bloque T:   [3]     color verde
;         [3][3][3]
mov byte[rbx+5], '3'
mov byte[rbx+14], '3'
mov byte[rbx+15], '3'
mov byte[rbx+16], '3'
mov r12, 3 	; limite de movimientos hacia derecha 
mov r13, 4 	; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo

bloqueS:
;bloque S:   [4][4] color amarillo
;         [4][4]
mov byte[rbx+4], '4'
mov byte[rbx+5], '4'
mov byte[rbx+13], '4'
mov byte[rbx+14], '4'
mov r12, 4  ; limite de movimientos hacia derecha 
mov r13, 3  ; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo

bloqueZ:
;bloque Z:   [5][5]     color rosa
;               [5][5]
mov byte[rbx+4], '5'
mov byte[rbx+5], '5'
mov byte[rbx+15], '5'
mov byte[rbx+16], '5'
mov r12, 3  ; limite de movimientos hacia derecha 
mov r13, 4  ; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo

bloqueJ:
;bloque J: [6]         color morado
;          [6][6][6]
mov byte[rbx+4], '6'
mov byte[rbx+14], '6'
mov byte[rbx+15], '6'
mov byte[rbx+16], '6'
mov r12, 3  ; limite de movimientos hacia derecha 
mov r13, 4  ; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo

bloqueL:
;bloque L        [7]  color naranja
;          [7][7][7]
mov byte[rbx+6], '7'
mov byte[rbx+14], '7'
mov byte[rbx+15], '7'
mov byte[rbx+16], '7'
mov r12, 3  ; limite de movimientos hacia derecha 
mov r13, 4  ; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo
;--------------end definicion de bloques----------

;----------get block-----------
getBlock:
	mov sil, byte[rbx]
	cmp sil, 0
	je increase

	mov rax, rsi ;muevo a rax el tipo de bloque (1:I, 2:O, 3:T etc)
	jmp end

	increase: 
	inc rbx
	loop getBlock
;---------- end getBlock-----------

;-----------moveRight---------------
;mover hacia la derecha
;+1 para mover hacia la derecha, se empieza desde abajo de la matriz hacia arriba

;verificar si se puede mover a la derecha
cmp r12, 0
je final
	
moveRight:
	
	mov ecx, 200 				;comenzamos al final de la matriz
	mov rbx, matrix

	startMoveRight:
	cmp byte[rbx+rcx], 0         ;si lo que hay en la matriz es 0, no hace nada
	je loopRight

	mov dl, byte[rbx+rcx]       ;si es diferente de 0, va moviendo hacia la derecha
	mov byte[rbx+rcx], 0
	mov byte[rbx+rcx+1], dl
	
	loopRight: 

		loop startMoveRight	

	dec r12    ;le resta 1 al límite derecho
	inc r13    ;incrementa el limite izquierdo

;-----------end moveRight-------------

;-----------moveLeft-----------------
;mover hacia la izquierda
;el ciclo va desde el principio de la matriz hasta el final
cmp r13, 0
je final

moveLeft:
	mov ecx, 200
	mov rbx, matrix
	mov rsi, 0  		;contador

	startMoveLeft:
	cmp byte[rbx+rsi], 0   ;si es 0 en la matriz no hace nada
	je loopLeft

	mov dl, byte[rbx+rsi]  ;si no es 0, mueve
	mov byte[rbx+rsi], 0
	mov byte[rbx+rsi-1], dl

	loopLeft:
		inc rsi
		loop startMoveLeft

	dec r13    ;le resta 1 al límite derecho
	inc r12    ;incrementa el limite izquierdo

;----------end moveLeft-------------------



;generacion de bloques




;rotar

;verificar estado

end:
	mov rax, 60
	mov rdi, 0
	syscall
