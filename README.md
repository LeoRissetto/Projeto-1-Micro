Projeto 1 - Cronômetro Digital usando Assembly e 8051

Disciplina: SEL0614/SEL0433 - Aplicação de Microprocessadores

Parte 1 - Sistemas Embarcados e Microcontroladores
1. Resumo

Este projeto consiste no desenvolvimento de um cronômetro digital em linguagem Assembly para o microcontrolador 8051, utilizando o simulador EdSim51. O cronômetro exibe números de 0 a 9 em um display de 7 segmentos, alternando entre intervalos de tempo de 0,25 segundos e 1 segundo, controlados por dois botões (SW0 e SW1). A simulação inclui o uso de registradores, portas de entrada e saída, e sub-rotinas de delay.

2. Objetivos

O objetivo deste projeto é explorar o funcionamento de sistemas embarcados e microcontroladores, especificamente o 8051, através da implementação de um cronômetro digital que utilize botões e display de 7 segmentos. Além disso, o projeto busca desenvolver habilidades na programação em Assembly e no uso de sub-rotinas de tempo.

Específicos:
Criar um cronômetro digital que conte de 0 a 9 em um display de 7 segmentos.
Alternar o tempo de contagem entre 0,25 segundos e 1 segundo utilizando botões.
Utilizar registradores, portas de entrada e saída, e sub-rotinas de delay para implementar o sistema.
3. Materiais e Métodos

Materiais:
Microcontrolador: 8051 (simulado no EdSim51).
Simulador: EdSim51.
Linguagem de programação: Assembly.
Métodos:
O projeto foi desenvolvido no simulador EdSim51 utilizando os seguintes componentes:

Botões SW0 e SW1: Utilizados para controlar o intervalo de tempo da contagem.
Display de 7 segmentos: Mostra os números de 0 a 9.
Registradores GPR e SFR: Utilizados para controle da contagem, verificação de eventos e configuração das portas de entrada e saída.
Sub-rotinas de delay: Implementadas para gerar os atrasos de 0,25 segundos e 1 segundo.
4. Descrição

Inicialização:
A porta P2 é configurada como entrada para detectar os botões SW0 e SW1.
O display de 7 segmentos está conectado à porta P1, que exibe os números de 0 a 9.
Funcionamento:
O programa inicia com o display desligado. A contagem só começa quando SW0 ou SW1 são pressionados.
SW0: Ao pressionar SW0, o cronômetro conta de 0 a 9 com um intervalo de 0,25 segundos.
SW1: Ao pressionar SW1, o intervalo de contagem é alterado para 1 segundo.
Loop: A contagem é contínua, alternando entre os intervalos de tempo conforme o botão pressionado.
Sub-rotinas de Delay:
DELAY_0_25S: Atraso de 0,25 segundos.
DELAY_1S: Atraso de 1 segundo.
Tabela de Segmentos:
O display de 7 segmentos utiliza uma tabela de valores para representar os números de 0 a 9. A porta P1 é responsável por controlar o display com base nos valores armazenados na tabela.

5. Resultados e Discussão

O projeto foi implementado com sucesso no simulador EdSim51, cumprindo os seguintes requisitos:

Contagem correta de 0 a 9: O display de 7 segmentos exibe os números na ordem correta e a contagem reinicia ao chegar a 9.
Alteração de intervalo de tempo: O cronômetro altera a base de tempo corretamente entre 0,25 segundos e 1 segundo ao pressionar SW0 e SW1.
Loop contínuo: A contagem ocorre indefinidamente até que a simulação seja parada.
Discussão: A implementação do cronômetro evidenciou a importância do uso de sub-rotinas para gerar os diferentes atrasos temporais. O controle via botões foi eficaz, demonstrando a capacidade do microcontrolador 8051 de gerenciar múltiplos eventos simultâneos com precisão.

6. Conclusão

O desenvolvimento deste projeto permitiu aplicar conceitos importantes de sistemas embarcados e microcontroladores, como o uso de registradores, portas de entrada/saída, e sub-rotinas de tempo. A implementação no EdSim51 demonstrou o funcionamento correto do cronômetro digital, alcançando os objetivos propostos. Este projeto reforçou o entendimento sobre a programação em Assembly e o uso prático do microcontrolador 8051 para controle de eventos e interfaces externas.