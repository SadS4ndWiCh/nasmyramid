section .text
    global _start

_start:
    xor r8, r8                  ; r8 = 0
    xor r10, r10                ; r10 = 0

    .loop:                      ; while (r8 < 10) {
        cmp r8, 10              ;
        jae .endloop            ;   // Jump if r8 is above or equal (jae) to 10
                                ;   // that means to loop while r8 ins't above
                                ;   // or equal 10
                                ;
        .innerloop:             ;   while (r10 < r8) {
            cmp r10, r8         ;       
            jae .endinnerloop   ;
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

    xor rdi, rdi                ; rdi = 0
    call exit                   ; exit(rdi)

;-------------------------
; str_len(char* buf)
; > Get the string length 
;
; @param {char* buf} RDI, The string buffer
;
; @returns {int} RAX, The string length
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
; print(char* buf)
; > Write to console
;
; @param {char*} RDI, The string buffer
;-------------------------
print:
    call str_len
    mov rdx, rax
    mov rsi, rdi
    mov rdi, 1
    mov rax, 1
    syscall

    ret

;-------------------------
; exit(uint code)
; > Exit the program
;
; @param {uint code} RDI, The exit code
;-------------------------
exit:
    mov rax, 60
    syscall

section .data
    star: db "* ", 0
    newLine: db 0xA, 0xD, 0
