.global _start

.section .data
msg:
    .ascii "Hello, World!\n"
msg_len = . - msg

.section .bss
written:
    .space 4
    # Reserva 4 bytes para o Windows anotar quanto escreveu

.section .text
_start:
    # Reserva espaço na pilha (32 bytes de shadow space exigidos pelo Windows + 24 extras)
    subq $56, %rsp

    # 1. Obter o "handle" (controle) do terminal (STD_OUTPUT_HANDLE = -11)
    movq $-11, %rcx
    call GetStdHandle

    # 2. Imprimir usando WriteFile(handle, msg, tamanho, &written, NULL)
    movq %rax, %rcx         # O handle retornado cai no RAX. Movemos para RCX (1º arg)
    leaq msg(%rip), %rdx    # 2º arg: endereço da mensagem
    movq $msg_len, %r8      # 3º arg: tamanho da mensagem
    leaq written(%rip), %r9 # 4º arg: onde o Windows vai gravar os bytes escritos
    movq $0, 32(%rsp)       # 5º arg: NULL (passado pela pilha)
    call WriteFile

    # 3. Encerrar o processo limpamente (ExitProcess(0))
    movq $0, %rcx
    call ExitProcess
