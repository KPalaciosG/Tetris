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
mov byte[rbx+3], 1
mov byte[rbx+4], 1
mov byte[rbx+5], 1
mov byte[rbx+6], 1
mov r12, 3 ; limite de movimientos hacia derecha 
mov r13, 3 ; limite de movimientos hacia la izquierda

bloqueO:
;bloque O: [2][2] color azúl
;          [2][2]
mov byte[rbx+4], 2
mov byte[rbx+5], 2
mov byte[rbx+14], 2
mov byte[rbx+15], 2
mov r12, 4 ; limite de movimientos hacia derecha 
mov r13, 4 ; limite de movimientos hacia la izquierda

bloqueT:
;bloque T:   [3]     color verde
;         [3][3][3]
mov byte[rbx+5], 3
mov byte[rbx+14], 3
mov byte[rbx+15], 3
mov byte[rbx+16], 3
mov r12, 3 ; limite de movimientos hacia derecha 
mov r13, 4 ; limite de movimientos hacia la izquierda

bloqueS:
;bloque S:   [4][4] color amarillo
;         [4][4]
mov byte[rbx+4], 4
mov byte[rbx+5], 4
mov byte[rbx+13], 4
mov byte[rbx+14], 4
mov r12, 4 ; limite de movimientos hacia derecha 
mov r13, 3 ; limite de movimientos hacia la izquierda

bloqueZ:
;bloque Z:   [5][5]     color rosa
;               [5][5]
mov byte[rbx+4], 5
mov byte[rbx+5], 5
mov byte[rbx+15], 5
mov byte[rbx+16], 5
mov r12, 3 ; limite de movimientos hacia derecha 
mov r13, 4 ; limite de movimientos hacia la izquierda

bloqueJ:
;bloque J: [6]         color morado
;          [6][6][6]
mov byte[rbx+4], 6
mov byte[rbx+14], 6
mov byte[rbx+15], 6
mov byte[rbx+16], 6
mov r12, 3 ; limite de movimientos hacia derecha 
mov r13, 4 ; limite de movimientos hacia la izquierda

bloqueL:
;bloque L        [7]  color naranja
;          [7][7][7]
mov byte[rbx+6], 7
mov byte[rbx+14], 7
mov byte[rbx+15], 7
mov byte[rbx+16], 7
mov r12, 3 ; limite de movimientos hacia derecha 
mov r13, 4 ; limite de movimientos hacia la izquierda
;--------------end definicion de bloques----------

;----------get block-----------
@@ -81,6 +102,10 @@ getBlock:
;-----------moveRight---------------
;mover hacia la derecha
;+1 para mover hacia la derecha, se empieza desde abajo de la matriz hacia arriba

;verificar si se puede mover a la derecha
cmp r12, 0
je final
	
moveRight:
	
@@ -99,11 +124,16 @@ moveRight:

		loop startMoveRight	

	sub r12, 1 ;le resta 1 al límite derecho
	inc r13    ;incrementa el limite izquierdo

;-----------end moveRight-------------

;-----------moveLeft-----------------
;mover hacia la izquierda
;el ciclo va desde el principio de la matriz hasta el final
cmp r13, 0
je final

moveLeft:
	mov ecx, 200
@@ -122,12 +152,14 @@ moveLeft:
		inc rsi
		loop startMoveLeft

	sub r13, 1 ;le resta 1 al límite derecho
	inc r12    ;incrementa el limite izquierdo

;----------end moveLeft-------------------

;generacion de bloques

;mover hacia la derecha
;+1 para mover hacia la derecha

;generacion de bloques



;rotar
;verificar estado
end:
	mov rax, 60
	mov rdi, 0
	syscall
