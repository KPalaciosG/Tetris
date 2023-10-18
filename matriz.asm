section .data
    matrix db 20, 10  ; Dimensiones de la matriz (filas, columnas)
    array  times 200 db '3'  ; Matriz de 20x10 inicializada con ceros

section .text
    global getMatrix
	global crearBloque

getMatrix:
    mov rax, array  ; Dirección base de la matriz
    ret
	
;--------definicion de bloques---------
crearBloque:
;bloque I: [1][1][1][1] color rojo
	;bloque O: [2][2] color azúl
	;          [2][2]
	mov rbx, matrix 
	mov byte[rbx+4], '2'
	mov byte[rbx+5], '2'
	mov byte[rbx+14], '2'
	mov byte[rbx+15], '2'
	mov r12, 4 ; limite de movimientos hacia derecha 
	mov r13, 4 ; limite de movimientos hacia la izquierda
	
	ret
	
	
moverBloque:
	;rdi direcciones de los bloques---------
	mov byte[rdi+1], '2'
	mov byte[rdi+2], '2'
	mov byte[rdi+3], '2'
	mov byte[rdi+4], '2'
	
	mov byte[rdi], '0'
	mov byte[rdi], '0'
	mov byte[rdi], '0'
	mov byte[rdi], '0'
	