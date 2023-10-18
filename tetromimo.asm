section .bss
matrix: resb 200 ;se separan 200 espacios en memoria
section .data
x: dd 10
y: dd 20
marixLen: dd 200 ;tamaño de la matriz
section .text
global _start
_start:
mov rbx, matrix 
;--------definicion de bloques---------
;bloque I: [1][1][1][1] color rojo
mov byte[rbx+3], 1
mov byte[rbx+4], 1
mov byte[rbx+5], 1
mov byte[rbx+6], 1
;bloque O: [2][2] color azúl
;          [2][2]
mov byte[rbx+4], 2
mov byte[rbx+5], 2
mov byte[rbx+14], 2
mov byte[rbx+15], 2
;bloque T:   [3]     color verde
;         [3][3][3]
mov byte[rbx+5], 3
mov byte[rbx+14], 3
mov byte[rbx+15], 3
mov byte[rbx+16], 3
;bloque S:   [4][4] color amarillo
;         [4][4]
mov byte[rbx+4], 4
mov byte[rbx+5], 4
mov byte[rbx+13], 4
mov byte[rbx+14], 4
;bloque Z:   [5][5]     color rosa
;               [5][5]
mov byte[rbx+4], 5
mov byte[rbx+5], 5
mov byte[rbx+15], 5
mov byte[rbx+16], 5
;bloque J: [6]         color morado
;          [6][6][6]
mov byte[rbx+4], 6
mov byte[rbx+14], 6
mov byte[rbx+15], 6
mov byte[rbx+16], 6
;bloque L        [7]  color naranja
;          [7][7][7]
mov byte[rbx+6], 7
mov byte[rbx+14], 7
mov byte[rbx+15], 7
mov byte[rbx+16], 7
;--------------end definicion de bloques----------
;----------get block-----------
getBlock:
	mov rsi, [rbx]
	cmp rsi, 0
	je increase

	mov rax, [rsi]
	jmp end ;CAMBIAR DESPUÉS CON EL SIGUIENTE CODIGO

	increase: 
	inc rbx
	loop getBlock
;---------- end getBlock----------
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
