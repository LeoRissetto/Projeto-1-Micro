ORG 0000h
MOV DPTR, #SEGMENTS ; Carrega a tabela de segmentos em DPTR

ORG 0033h

INIT:
    ; Verifica se SW0 está pressionado para iniciar a contagem
    JNB P2.0, START
    ; Caso SW0 não seja pressionado, espera em loop até que seja
    JMP INIT

START:
    ; Reseta a contagem para zero
    MOV R2, #00
    MOV R3, #0 ; R3 será usado para controlar o tempo de delay

LOOP:
    ; Carrega o valor de R2 no acumulador para obter o segmento correspondente
    MOV A, R2
    ; Busca o valor do segmento na tabela para o número em A
    MOVC A, @A + DPTR
    ; Envia o valor do segmento para a porta P1 para exibir no display
    MOV P1, A

    ; Verifica o estado dos botões para o delay
    CALL CHECK_DELAY

    ; Incrementa o valor de R2 para o próximo número
    INC R2
    ; Se R2 ainda não atingiu 10 (dez segmentos), continua a contagem
    CJNE R2, #10, LOOP

    ; Recomeça a contagem do zero
    MOV R2, #0
    JMP LOOP

CHECK_DELAY:
    ; Verifica se o SW0 está pressionado para um delay de 0,25s
    JNB P2.0, DELAY1
    ; Verifica se o SW1 está pressionado para um delay de 1s
    JNB P2.1, DELAY2
    ; Se nenhum botão for pressionado, usa o último delay
    SJMP DELAY_LOOP

DELAY1:
    ; Configura um delay de 0,25s
    MOV R3, #0 ; Resetando R3 para 0,25s
    MOV R1, #250
    SJMP DELAY_LOOP

DELAY2:
    ; Configura um delay de 1s
    MOV R3, #1 ; Mudando para 1s
    MOV R1, #1000
    SJMP DELAY_LOOP

DELAY_LOOP:
    ; Loop interno de delay
    MOV R0, #250
DELAY_INNER_LOOP:
    DJNZ R0, DELAY_INNER_LOOP
    DJNZ R1, DELAY_LOOP
    SJMP AFTER_DELAY

AFTER_DELAY:
    ; Verifica se já passou por todos os segmentos (0 a 9)
    CJNE R2, #10, LOOP
    ; Recomeça a contagem do zero
    MOV R2, #0
    JMP LOOP

; Tabela de segmentos para display de 7 segmentos
SEGMENTS:
    DB 0C0h ; 0
    DB 0F9h ; 1
    DB 0A4h ; 2
    DB 0B0h ; 3
    DB 99h  ; 4
    DB 92h  ; 5
    DB 82h  ; 6
    DB 0F8h ; 7
    DB 80h  ; 8
    DB 90h  ; 9

END
