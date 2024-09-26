ORG 0H

; Configura P2 como entrada
MOV P2, #0FFH           ; O valor 0xFF configura todos os pinos de P2 como entrada

MOV R0, #00H            ; Contador começando em 0

INIT: 
    ; Verifica se P2.0 ou P2.1 estão pressionados
    JNB P2.0, MAIN_LOOP ; Se P2.0 não estiver pressionado, pula para MAIN_LOOP
    JNB P2.1, MAIN_LOOP ; Se P2.1 não estiver pressionado, pula para MAIN_LOOP
    JMP INIT            ; Caso contrário, repete o loop inicial

MAIN_LOOP:
    MOV A, R0                   ; Move o valor do contador para o acumulador
    MOV DPTR, #SEG_TABLE        ; Carrega o endereço da tabela de segmentos
    MOVC A, @A+DPTR             ; Acessa a tabela usando DPTR
    MOV P1, A                   ; Envia a saída para o display de 7 segmentos
    
    ; Verifica qual botão foi pressionado para definir o tempo de delay
    MOV A, P2                   ; Lê novamente o estado de P2
    ANL A, #03H                 ; Aplica máscara para verificar P2.0 e P2.1
    CJNE A, #01H, CHECK_P2_1    ; Se P2.0 estiver pressionado (A == 01H), delay de 1s
    ACALL DELAY_1S              ; Chama rotina de delay de 1 segundo
    SJMP CONTINUE               ; Salta para continuar o loop

CHECK_P2_1:
    ACALL DELAY_0_25S           ; Se P2.1 estiver pressionado, chama delay de 0,25s

CONTINUE:
    INC R0                      ; Incrementa o contador
    CJNE R0, #0AH, INIT         ; Se R0 < 10, continua no loop

    MOV R0, #00H                ; Reseta o contador após alcançar 9
    SJMP INIT                   ; Volta para o início

; Rotina de Delay de 1 segundo
DELAY_1S:                       
    MOV R1, #255                ; Configura R1 para um valor alto
DELAY_1S_LOOP1:
    MOV R2, #255                ; Configura R2 para um valor alto
DELAY_1S_LOOP2:
    NOP                         ; Instrução sem operação
    NOP                         ; Dois NOPs para aumentar o tempo de delay
    DJNZ R2, DELAY_1S_LOOP2     ; Decrementa R2 e repete se não for zero
    DJNZ R1, DELAY_1S_LOOP1     ; Decrementa R1 e repete se não for zero
    RET                         ; Retorna da rotina de delay

; Rotina de Delay de 0,25 segundos
DELAY_0_25S:                   
    MOV R1, #63                 ; Configura R1 para um valor menor (aproximadamente 0,25s)
DELAY_0_25S_LOOP1:
    MOV R2, #255                ; Configura R2 para um valor alto
DELAY_0_25S_LOOP2:
    NOP                         ; Instrução sem operação
    NOP                         ; Dois NOPs para aumentar o tempo de delay
    DJNZ R2, DELAY_0_25S_LOOP2  ; Decrementa R2 e repete se não for zero
    DJNZ R1, DELAY_0_25S_LOOP1  ; Decrementa R1 e repete se não for zero
    RET                         ; Retorna da rotina de delay

; Tabela de segmentos para display de 7 segmentos
SEG_TABLE:
    DB 0C0H    ; 0
    DB 0F9H    ; 1
    DB 0A4H    ; 2
    DB 0B0H    ; 3
    DB 99H     ; 4
    DB 92H     ; 5
    DB 82H     ; 6
    DB 0F8H    ; 7
    DB 80H     ; 8
    DB 90H     ; 9

END