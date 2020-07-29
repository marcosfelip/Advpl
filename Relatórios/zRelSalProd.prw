#include "topconn.ch"
#include "protheus.ch"                                                     

//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//���Programa  | zExpExcel  �  Autor � Marcos Felipe  �  Data �  28/07/20   ���
//�������������������������������������������������������������������������͹��
//���Descricao � Rotina dados da SF2/SD2 para o Excel                       ���
//�������������������������������������������������������������������������͹��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������

User Function zExpExcel()

Local cAlias := GetNextAlias() 

Private aCabec := {} //ARRAY DO CABE�ALHO
Private aDados := {} //ARRAY QUE ARMAZENAR� OS DADOS

//COME�O A MINHA CONSULTA SQL
BeginSql Alias cAlias
		SELECT B1_COD, B1_DESC, B2_LOCAL, B2_QATU FROM  %table:SB2990%
		INNER JOIN  %table:SB1990% ON SB2990.B2_COD = SB1990.B1_COD

EndSql //FINALIZO A MINHA QUERY

//CABE�ALHO

aCabec := {"CODIGO","DESCRICAO","LOCAL","QUANTIDADE ATUAL"}

While !(cAlias)->(Eof())

	aAdd(aDados,{B1_COD,B1_DESC, B2_LOCAL, B2_QATU})
	
	(cAlias)->(dbSkip()) //PASSAR PARA O PR�XIMO REGISTRO                                     
enddo

//JOGO TODO CONTE�DO DO ARRAY PARA O EXCEL
MsgRun("Favor Aguardar.....", "Exportando os Registros para o Excel",;
{||DlgtoExcel({{"ARRAY","Relat. Saldo de produtos", aCabec, aDados}})})
	                                          
(cAlias)->(dbClosearea())	

return


