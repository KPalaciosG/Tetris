section .bss
matrix: resb 200 ;se separan 200 espacios en memoria

section .data

x: dd 10
y: dd 20

matrix: dd 200
marixLen: equ $-matrix
;matrix: dd 200
marixLen: dd 200

section .text
global _start
_start:

mov rbx, matrix 

;definicion de bloques
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


;generacion de bloques

;mover hacia la derecha
;mover hacia la izquierda
;rotar
;verificar estado
mov rax, 60
mov rdi, 0
syscall
