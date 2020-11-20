#include "protheus.ch"
/*
+===========================================+
| Programa: C�lculo do Fatorial |
| Autor : Microsiga Software S.A. |
| Data : 02 de outubro de 2001 |
+===========================================+
*/
User Function CalcFator()
Local nCnt
Local nResultado := 1 // Resultado do fatorial
Local nFator := 5 // N�mero para o c�lculo
// C�lculo do fatorial
For nCnt := nFator To 1 Step -1
nResultado *= nCnt
Next nCnt
// Exibe o resultado na tela, atrav�s da fun��o alert
MsgAlert("O fatorial de " + cValToChar(nFator) + ;
 " � " + cValToChar(nResultado))
// Termina o programa
Return( NIL )
