section .data
path:       db      "Scores.txt", 0 ; null-terminated
headerbuffer:	    resb    54
pixel_buffer: resb 3 ;bytes por color
LF equ 10 ; cambio de linea
	NULL equ 0 ; caracter de final de string
	TRUE equ 1
	FALSE equ 0
	EXIT_SUCCESS equ 0 ; codigo de exito
	STDIN equ 0 ; standard input
	STDOUT equ 1 ; standard output
	STDERR equ 2 ; standard error
	SYS_read equ 0 ; lectura
	SYS_write equ 1 ; escritura
	SYS_open equ 2 ; abrir archivo
	SYS_close equ 3 ; cerrar archivo
	SYS_exit equ 60 ; terminar
	SYS_creat equ 85 ; abrir/crear archivo
	SYS_time equ 201 ; obtener tiempo
	
	
	O_CREAT equ 0x40
	O_TRUNC equ 0x200
	O_APPEND equ 0x400
	O_RDONLY equ 000000q ; solo lectura
	O_WRONLY equ 000001q ; solo escritura
	O_RDWR equ 000002q ; lectura y escritura
	
	S_IRUSR equ 00400q
	S_IWUSR equ 00200q
	S_IXUSR equ 00100q
	
	; ------ Variables para el principal
	
	newLine db LF, NULL
	header db LF, "File Write Example."
	db LF, LF, NULL
	fileName db "scores.txt", NULL
	db LF, NULL
	len dq 0
	writeDone db "Write Completed.", LF, NULL
	newFileDesc dq 0
    originalImageFileDesc: dq 0
	errMsgOpen db "Error opening file.", LF, NULL
	errMsgWrite db "Error writing to file.", LF, NULL

section .text

global create     
create:
		    mov rax, SYS_write	; crear el archivo
		    mov rdi, fileName ;nombre del archivo a crear
		    mov rsi, S_IRUSR | S_IWUSR ; permitir lectura/escritura
		    syscall; crea archivo
            jmp Exit


Exit:
    ret