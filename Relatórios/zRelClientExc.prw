#include "protheus.ch"


//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//���Programa  | GExpExcel  �  Autor � Marcos Felipe  �  Data �  28/07/20   ���
//�������������������������������������������������������������������������͹��
//���Descricao �                                                            ���
//�������������������������������������������������������������������������͹��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������


User Function GExpExcel()

Local aCabExcel :={}
Local aItensExcel :={}

// AADD(aCabExcel, {"TITULO DO CAMPO", "TIPO", NTAMANHO, NDECIMAIS})
AADD(aCabExcel, {"A1_FILIAL" ,"C", 02, 0})
AADD(aCabExcel, {"A1_COD" ,"C", 06, 0})
AADD(aCabExcel, {"A1_LOJA" ,"C", 02, 0})
AADD(aCabExcel, {"A1_NOME" ,"C", 40, 0})
AADD(aCabExcel, {"A1_MCOMPRA" ,"N", 18, 2})

MsgRun("Favor Aguardar.....", "Selecionando os Registros",;
{|| GProcItens(aCabExcel, @aItensExcel)})

MsgRun("Favor Aguardar.....", "Exportando os Registros para o Excel",;
{||DlgToExcel({{"GETDADOS",;
"POSI��O DE T�TULOS DE VENDOR NO PER�ODO",;
aCabExcel,aItensExcel}})})

Return

//-------------------------------------------------------------------------------------------------------------------------------------------------------------

Static Function GProcItens(aHeader, aCols)

Local aItem
Local nX

DbSelectArea("SA1")
DbSetOrder(1)
DbGotop()

While SA1->(!EOF())

aItem := Array(Len(aHeader))

For nX := 1 to Len(aHeader)
IF aHeader[nX][2] == "C"
aItem[nX] := CHR(160)+SA1->&(aHeader[nX][1])
ELSE
aItem[nX] := SA1->&(aHeader[nX][1])
ENDIF
Next nX

AADD(aCols,aItem)
aItem := {}
SA1->(dbSkip())

End

Return
