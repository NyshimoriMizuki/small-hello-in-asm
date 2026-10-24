.global main

.section .rdata

msg:
.asciz "Ola, Mundo em Assembly usando as.exe!"

.text
main:
    subq $40, %rsp
    leaq msg(%rip), %rcx
    call puts
    movq $0, %rax
    addq $40, %rsp
    ret
