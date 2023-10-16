section .data

matrix: resb 200 ; 20x10

section .text

;definicion de bloques

;generacion de bloques

;mover hacia la derecha

;mover hacia la izquierda

;rotar

;verificar estado

mov rax, 60
mov rdi, 0
syscall
