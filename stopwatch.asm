ORG 0000h              ; Define o endereço inicial do programa

MOV DPTR, #SEG_TABLE   ; Carrega o endereço da tabela de segmentos no registrador DPTR

ORG 0033h              ; Define o endereço de início da execução do programa

MOV R0, #00H           ; Inicializa o contador R0 em 0

INIT: 
    ; Verifica se os botões P2.0 ou P2.1 estão pressionados
    JNB P2.0, MAIN_LOOP     ; Se P2.0 estiver pressionado, salta para MAIN_LOOP
    JNB P2.1, MAIN_LOOP     ; Se P2.1 estiver pressionado, salta para MAIN_LOOP
    JMP INIT                ; Se ambos os botões estiverem pressionados, repete o loop INIT

MAIN_LOOP:
    MOV A, R0              ; Move o valor do contador (R0) para o acumulador (A)
    MOVC A, @A + DPTR     ; Acessa a tabela de segmentos usando o valor em A como índice
    MOV P1, A              ; Envia o valor do acumulador para o display de 7 segmentos (P1)

    ; Verifica qual botão foi pressionado para definir o tempo de delay
    JNB P2.0, DELAY_0_25S   ; Se P2.0 estiver pressionado, salta para DELAY_0_25S
    JMP DELAY_1S           ; Caso contrário, salta para DELAY_1S

CONTINUE:
    INC R0                  ; Incrementa o contador R0
    CJNE R0, #0AH, INIT     ; Se R0 for menor que 10, volta para INIT
    MOV R0, #00H            ; Reseta o contador R0 para 0 após atingir 9
    JMP INIT                ; Volta para o início do loop

DELAY_1S:
    MOV R1, #10             ; Inicializa o contador R1 para o delay de 1 segundo
DELAY_1S_LOOP1:
    MOV R2, #100            ; Inicializa o contador R3
DELAY_1S_LOOP2:
    MOV R3, #250            ; Inicializa o contador R2 para o delay interno
    DJNZ R3, $              ; Decrementa R2 e repete até chegar a 0
    DJNZ R2, DELAY_1S_LOOP2 ; Decrementa R3 e repete até chegar a 0
    DJNZ R1, DELAY_1S_LOOP1 ; Decrementa R1 e repete até chegar a 0
    JMP CONTINUE            ; Após o delay, volta para CONTINUE

DELAY_0_25S:
    MOV R1, #1              ; Inicializa o contador R1 para o delay de 0,25 segundos
DELAY_0_25S_LOOP1:
    MOV R2, #250            ; Inicializa o contador R3
DELAY_0_25S_LOOP2:
    MOV R3, #250            ; Inicializa o contador R2 para o delay interno
    DJNZ R3, $              ; Decrementa R2 e repete até chegar a 0
    DJNZ R2, DELAY_0_25S_LOOP2 ; Decrementa R3 e repete até chegar a 0
    DJNZ R1, DELAY_0_25S_LOOP1 ; Decrementa R1 e repete até chegar a 0
    JMP CONTINUE            ; Após o delay, volta para CONTINUE

; Tabela de segmentos para o display de 7 segmentos
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

END                     ; Finaliza o programa