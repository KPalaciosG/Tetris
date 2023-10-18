section .bss
matrix: resb 200 ;se separan 200 espacios en memoria
section .data
x: dd 10
y: dd 20

marixLen: dd 200 ;tamaño de la matriz
matrixLen: dd 200 ;tamaño de la matriz

section .text
global _start
@@ -70,14 +70,36 @@ getBlock:
	cmp sil, 0
	je increase

	mov rax, rsi
	mov rax, rsi ;muevo a rax el tipo de bloque (1:I, 2:O, 3:T etc)
	jmp end

	increase: 
	inc rbx
	loop getBlock
;---------- end getBlock----------
;---------- end getBlock-----------

;-----------moveRight---------------
;mover hacia la derecha
;+1 para mover hacia la derecha, se empieza desde abajo de la matriz hacia arriba
	
moveRight:
	
	mov ecx, 200
	mov rbx, matrix

	startMoveRight:
	cmp byte[rbx+rcx],0
	je loopRight

	mov dl, byte[rbx+rcx]
	mov byte[rbx+rcx],0
	mov byte[rbx+rcx+1], dl
	
	loopRight: 

	loop startMoveRight	

;-----------end moveRight-------------

;generacion de bloques

;mover hacia la derecha
;+1 para mover hacia la derecha
;mover hacia la izquierda
;rotar
;verificar estado
end:
	mov rax, 60
	mov rdi, 0
	syscall
