section .text
    global _start

_start:
    xor r8, r8                  ; r8 = 0
    xor r10, r10                ; r10 = 0

    .loop:                      ; while (r8 != 10) {
        cmp r8, 10              ;
        je .endloop             ; 
                                ;
        .innerloop:             ;   while (r10 != r8) {
            cmp r10, r8         ;       
            je .endinnerloop    ;
                                ;
            mov rdi, star       ;       rdi = "* "
            call print          ;       print(rdi)
                                ;       
            inc r10             ;       r10++
                                ;
            jmp .innerloop      ;   
        .endinnerloop:          ;   }
        xor r10, r10            ;   r10 = 0
                                ;
        mov rdi, newLine        ;   rdi = '\n'
        call print              ;   print(rdi)
                                ;
        inc r8                  ;   r8++
                                ;
        jmp .loop               ;
    .endloop:                   ; }

    jmp exit                    ; exit()

;-------------------------
; str_len(char*)
; > Get the string length 
;
; @param {char*} RDI
; @returns {int} RAX
;-------------------------
str_len:
    xor rax, rax                ; rax = 0

    .loop:                      ; while (rdi[rax] != 0) {
        cmp byte[rdi + rax], 0  ;   
        je .endloop             ; 
                                ;
        inc rax                 ;   rax++
        jmp .loop               ;
    .endloop:                   ; }

    ret                         ; return rax


;-------------------------
; print(char*)
; > Write to console
;
; @param {char*} RDI
;-------------------------
print:
    call str_len
    mov rdx, rax
    mov rsi, rdi
    mov rdi, 1
    mov rax, 1
    syscall

    ret


exit:
    mov rax, 60
    mov rdi, 0
    syscall

section .data
    star: db "* ", 0
    newLine: db 0xA, 0xD, 0
