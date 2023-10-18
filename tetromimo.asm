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

;----------limpiarBloque-----------
cleanBlock:

xor r8, r8
xor r9, r9
xor r10, r10
xor r11, r11

ret

;----------limpiarBloque-----------

;-----------moveRight---------------
;mover hacia la derecha
;+1 para mover hacia la derecha



;verificar si los espacios para donde se mueven están vacios
	
moveRight:
	;verificar si se puede mover a la derecha

	cmp r12, 0 ; se verifica límite derecho
	ret

	;verifica si los dos bloques de la derecha tienen un 0, sino, no lo mueve
	mov ecx, 4 				
	cmp [r9+1], 0
	jne ret 

	cmp [r11+1], 0
	jne ret


	startMoveRight:
	mov [r11+1], rsi
	mov [r11], 0
	mov [r10+1], rsi
	mov [r10], 0
	mov [r9+1], rsi
	mov [r9],0
	mov [r8+1], rsi
	mov [r8], 0

	loopRight: 

		loop startMoveRight	

	dec r12    ;le resta 1 al límite derecho
	inc r13    ;incrementa el limite izquierdo

;-----------end moveRight-------------

;-----------moveLeft-----------------
;mover hacia la izquierda
;el ciclo va desde el principio de la matriz hasta el final
cmp r13, 0
je end

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
