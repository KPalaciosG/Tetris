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

;direcciones del bloque
lea r8, [rbx+3]
lea r9, [rbx+4]
lea r10, [rbx+5]
lea r11, [rbx+6]

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

;direcciones del bloque
lea r8, [rbx+4]
lea r9, [rbx+5]
lea r10, [rbx+14]
lea r11, [rbx+15]

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

;direcciones del bloque
lea r9, [rbx+5]
lea r8, [rbx+14]
lea r10, [rbx+15]
lea r11, [rbx+16]

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

;direcciones del bloque
lea r8, [rbx+4]
lea r9, [rbx+5]
lea r10, [rbx+13]
lea r11, [rbx+14]

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

;direcciones del bloque
lea r8, [rbx+4]
lea r9, [rbx+5]
lea r10, [rbx+15]
lea r11, [rbx+16]

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

;direcciones del bloque
lea r9, [rbx+4]
lea r8, [rbx+14]
lea r10, [rbx+15]
lea r11, [rbx+16]

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

;direcciones del bloque
lea r9, [rbx+6]
lea r8, [rbx+14]
lea r10, [rbx+15]
lea r11, [rbx+16]

mov r12, 3  ; limite de movimientos hacia derecha 
mov r13, 4  ; limite de movimientos hacia la izquierda
mov r14, 18 ; limite de movimientos hacia abajo
;--------------end definicion de bloques----------

;----------get block-----------
getBlock:
	mov sil, byte[r8]
	
;---------- end getBlock-----------

	
;-----------moveRight---------------
;mover hacia la derecha
;+1 para mover hacia la derecha

moveRight:
	;verificar si se puede mover a la derecha

	cmp r12, 0 ; se verifica límite derecho
	je end

	;verifica si los dos bloques de la derecha tienen un 0, sino, no lo mueve
	cmp byte[r11+1], 0
	jne end

	cmp byte[r11], '1'	;si el bloque es I solo necesita verificar la última dirección
	je startMoveRight

	cmp byte[r9+1], 0
	jne end
	
	startMoveRight:
	mov [r11+1], sil
	mov byte[r11], 0
	mov [r10+1], sil
	mov byte[r10], 0
	mov [r9+1], sil
	mov byte[r9],0
	mov [r8+1], sil
	mov byte[r8], 0

	;nuevas direcciones de memoria del bloque
	inc r11
	inc r10
	inc r9
	inc r8

	dec r12    ;le resta 1 al límite derecho
	inc r13    ;incrementa el limite izquierdo

;-----------end moveRight-------------

;-----------moveLeft-----------------
;mover hacia la izquierda

moveLeft:
	;verificar si se puede mover a la izquierda
	cmp r13, 0
	je end

	;verifica si los dos bloques de la derecha de tienen un 0, sino, no lo mueve
	cmp byte[r8-1], 0 
	jne end

	cmp byte[r11], '1'	;si el bloque es I solo necesita verificar la primera dirección
	je startMoveLeft

	;verificacion solo para los bloques O, S y Z
	cmp sil, '3'
	je verificacion2
	cmp sil, '6'
	je verificacion2
	cmp sil, '7'
	je verificacion2

	cmp byte[r10-1], 0 
	jne end
	jmp startMoveLeft

	verificacion2: 
	;verificacion para los bloques T, J y L
	cmp byte[r9-1], 0 
	jne end

	startMoveLeft:
	mov [r8-1], sil
	mov byte[r8], 0
	mov [r9-1], sil
	mov byte[r9], 0
	mov [r10-1], sil
	mov byte[r10],0
	mov [r11-1], sil
	mov byte[r11], 0

	;nuevas direcciones de memoria del bloque
	dec r11
	dec r10
	dec r9
	dec r8

	dec r13    ;le resta 1 al límite derecho
	inc r12    ;incrementa el limite izquierdo

;----------end moveLeft-------------------

;----------moveDown----------------
moveDown:
	;verificar si se puede mover hacia abajo
	cmp r14, 0
	je end

	;todos deben verificar estos 2
	cmp byte[r10+10], 0 
	jne end

	cmp byte[r11+10], 0 
	jne end

	cmp byte[r11], '2'	;si el bloque es O solo verifica estos 2
	je startMoveDown

	cmp byte[r11], '4'	;si el bloque es S necesita verificar r9
	je verificacion3
	
	cmp byte[r8+10], 0 ; bloque I, T, Z, J y L
	jne end
	cmp byte[r11], '1'	;si el bloque I tengo que verificar todos
	je verificacion3
	jmp startMoveDown

	verificacion3:
	cmp byte[r9+10], 0 
	jne end
	
	startMoveDown:
	mov [r11+10], sil
	mov byte[r11], 0
	mov [r10+10], sil
	mov byte[r10], 0
	mov [r9+10], sil
	mov byte[r9],0
	mov [r8+10], sil
	mov byte[r8], 0

	;nuevas direcciones de memoria del bloque
	add r11, 10
	add r10, 10
	add r9, 10
	add r8, 10

;---------endMoveDown-------------------


;generacion de bloques




;rotar

;verificar estado
verificarEstado:


;----------limpiarBloque-----------
cleanBlock:

	xor r8, r8
	xor r9, r9
	xor r10, r10
	xor r11, r11

;----------limpiarBloque-----------

end:
	mov rax, 60
	mov rdi, 0
	syscall
