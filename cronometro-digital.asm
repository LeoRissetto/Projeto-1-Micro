ORG 0000h
MOV DPTR, #SEGMENT_TABLE ; Armazena o endereço da tabela de segmentos no DPTR

ORG 0033h

INIT:
    ; Inicializa a contagem e o estado do display
    MOV R2, #00          ; R2 para a contagem (0 a 9)
    MOV P1, #00h         ; Desliga o display inicialmente

WAIT_FOR_PRESS:
    ; Aguarda a pressão de SW0 ou SW1 para iniciar a contagem
    JNB P2.0, START_COUNT ; Se SW0 for pressionado, inicia a contagem
    JNB P2.1, START_COUNT ; Se SW1 for pressionado, inicia a contagem
    JMP WAIT_FOR_PRESS    ; Volta a esperar

START_COUNT:
    MOV P1, #00h          ; Liga o display (configura para 0)
    MOV R3, #0            ; R3 para armazenar o tempo de delay

CHECK_BUTTONS:
    ; Verifica qual botão está pressionado para definir o tempo de delay
    JNB P2.0, SET_DELAY_250MS ; Se SW0 for pressionado, define delay para 0,25s
    JNB P2.1, SET_DELAY_1S    ; Se SW1 for pressionado, define delay para 1s
    SJMP COUNT_LOOP           ; Se nenhum botão for pressionado, continua a contagem

SET_DELAY_250MS:
    MOV R3, #250            ; Define o delay para 0,25s
    SJMP COUNT_LOOP

SET_DELAY_1S:
    MOV R3, #1000           ; Define o delay para 1s
    SJMP COUNT_LOOP

COUNT_LOOP:
    ; Move o valor atual de R2 para o acumulador
    MOV A, R2
    ; Busca o valor correspondente na tabela de segmentos
    MOVC A, @A + DPTR
    ; Envia o valor do segmento para a porta P1
    MOV P1, A

    ; Incrementa o contador R2
    INC R2
    ; Se R2 for igual a 10, reinicia a contagem
    CJNE R2, #10, DELAY ; Se não for 10, aguarda o delay

    MOV R2, #0           ; Reinicia a contagem se atingir 10

DELAY:
    ; Chama a sub-rotina de delay
    ACALL DELAY_SUBROUTINE
    SJMP CHECK_BUTTONS    ; Volta a verificar os botões

DELAY_SUBROUTINE:
    ; Loop para criar o delay
    MOV R0, R3            ; Carrega o valor do delay
DELAY_LOOP:
    DJNZ R0, DELAY_LOOP   ; Decrementa R0 até zero
    RET                    ; Retorna da sub-rotina

; Tabela de segmentos para o display de 7 segmentos
SEGMENT_TABLE:
    db 0c0h               ; 0
    db 0f9h               ; 1
    db 0a4h               ; 2
    db 0b0h               ; 3
    db 99h                ; 4
    db 92h                ; 5
    db 82h                ; 6
    db 0f8h               ; 7
    db 80h                ; 8
    db 90h                ; 9

END