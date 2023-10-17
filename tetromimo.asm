section .bss
matrix: resb 200 ;se separan 200 espacios en memoria
section .data
x: dd 10
y: dd 20

;matrix: dd 200
marixLen: dd 200
marixLen: dd 200 ;tamaño de la matriz

section .text
global _start
@@ -29,6 +28,41 @@ mov byte[rbx+5], 2
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


;generacion de bloques

;mover hacia la derecha
;mover hacia la izquierda
;rotar
;verificar estado
mov rax, 60
mov rdi, 0
syscall
