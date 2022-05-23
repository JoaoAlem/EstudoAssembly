SYS_EXIT equ 60
SYS_READ equ 0
SYS_WRITE equ 1
STDIN equ 0
STDOUT equ 1

section .bss
    num1: resb 1
    num2: resb 1
    result: resb 1

section .data
    message: db "Digite o primeiro numero: ", 4
    len1: equ $ - message

    message2: db "Digite o segundo numero: ", 4
    len2: equ $ - message2

    message3: db "O resultado da soma é: ", 4
    len3: equ $ - message3

section .text
    global _start
    
_start:
    ;Mostrando a primeira mensagem
    mov rax, SYS_WRITE ;rax é o contador, mas é quem recebe o código de instrução para o kernel, 1 = write
    mov rdi, STDOUT ;rdi = destination
    mov rsi, message ;rsi = source
    mov rdx, len1 ;rdx = tamanho
    syscall
    
    ;Pedindo a inserção da primeira variavel
    mov rax, SYS_READ ;rax é o contador, 0 = read
    mov rdi, STDIN
    mov rsi, num1
    mov rdx, 2
    syscall
    
    ;Mostrando a segunda mensagem
    mov rax, SYS_WRITE 
    mov rdi, STDOUT
    mov rsi, message2
    mov rdx, len2
    syscall

    ;Pedindo a inserção da segunda variavel
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, num2
    mov rdx, 2
    syscall

    ;Mostrando a  terceira mensagem
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, message3
    mov rdx, len3
    syscall 

    ;mover os numeros para os registros
    mov rdi, [num1] ;[num1] é o local da memória do numero 1
    sub rdi, '0' ;Converter em decimal, o numero em assembly é armazenado em Ascii
    ;Quando é inserido um numero no input, como o 7, ele entra sendo 7+48
    ;(pois na tabela ascii, 7+ 48 = digito decimal de 7), então quando realizamos
    ;a subtração de var - '0', supondo que var = 7, temos 55-48 = 7
    ;logo Ascii('7') - Ascii('0') = Int(7)

    mov rsi, [num2] ;[num2] é o local da memória do numero 2
    sub rsi, '0' ;Converter em decimal

    ;Realizar a adição
    add rdi, rsi
    add rdi, '0' ;converter novamente para ascii

    ;armazenar o resultado (que está em rdi) no valor da variavel resultado
    mov [result], rdi

    ;mostrando o resultado
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, result
    mov rdx, 1
    syscall 

    ;Fechamento do programa
    mov rax, SYS_EXIT ;60 = SYS_EXIT
    xor rdi, rdi
    syscall
