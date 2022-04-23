//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//���Programa  | zExpExcel  �  Autor � Marcos Felipe  �  Data �  28/07/20   ���
//�������������������������������������������������������������������������͹��
//���Descricao � Rotina dados da SF2/SD2 para o Excel                       ���
//�������������������������������������������������������������������������͹��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������

#include "protheus.ch"   
#include "rwmake.ch"
#include "dialog.ch"
#include "topconn.ch"
#include 'parmtype.ch'

User Function zExpSc7()

pDataDe  := ctod("  /  /  ")
pDataAte  := ctod("  /  /  ")

@ 000,000 to 130,250 dialog odlg1 title "Exportar NFS-e"
@ 005,005 say "Da Data"
@ 005,045 get pDataDe size 060,20
@ 020,005 say "Ate a Data"
@ 020,045 get pDataAte size 060,20
@ 040,020 bmpbutton type 1 action TExcel2()
@ 040,055 bmpbutton type 2 action close(odlg1)


activate dialog odlg1 centered

return()

static function TExcel2()

//----------------------------------------------------------------------------------------------------------------//
// Exportacao de dados para o Excel.
//----------------------------------------------------------------------------------------------------------------//

Local cAlias := GetNextAlias() 
Private _aCabec := {}
Private _aDados := {}

If (pDataDe = ctod("  /  /  ")) .or. (pDataAte = ctod("  /  /  "))
	MsgAlert("Informar Datas de Inicio e Fim do Periodo") 
	Return
endif 

_aCabec := {"Filial","N�mero Pedido","Produto","Valor Total","Emiss�o"}           

//Consulta SQL
 BeginSql Alias cAlias
		SELECT C7_FILIAL, C7_NUM, C7_DESCRI, C7_TOTAL, C7_EMISSAO
		FROM  %table:SC7990%
		WHERE SC7990.%NotDel%
		AND C7_EMISSAO >= %Exp:DTOS(pDataDe)% 
		AND C7_EMISSAO <= %Exp:DTOS(pDataAte)% 
		//INNER JOIN  %table:SB1990% ON SB2990.B2_COD = SB1990.B1_COD
EndSql 

While !(cAlias)->(Eof())

	aAdd(_aDados,{C7_FILIAL,C7_NUM,C7_DESCRI,C7_TOTAL,C7_EMISSAO})
	
	(cAlias)->(dbSkip()) //PASSAR PARA O PR�XIMO REGISTRO                                     
end

//JOGO TODO CONTE�DO DO ARRAY PARA O EXCEL
MsgRun("Favor Aguardar.....", "Exportando os Registros para o Excel",;
{||DlgtoExcel({{"ARRAY","Relat�rio Notas Fiscais", _aCabec, _aDados}})})
	                                          
(cAlias)->(dbClosearea())	
close(odlg1)

return
