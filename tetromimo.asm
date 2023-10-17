section .data

x dd, 10
y dd, 20
matrix: resb 200 ; 20x10
marixLen: equ $-matrix

section .text

;definicion de bloques
;bloque I: [1][1][1][1]


;generacion de bloques

;mover hacia la derecha
;mover hacia la izquierda
;rotar
;verificar estado
mov rax, 60
mov rdi, 0
syscall
