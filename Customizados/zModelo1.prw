#Include 'PROTHEUS.CH'
#Include 'RWMAKE.CH'

User function MODELUM()

Local cAlias := "ZZ1"
Local cTitulo := "Cadastro de Alunos"
Local cFunExc := "U_MODELUMA()"
Local cFunAlt := "U_MODELUMB()"

AxCadastro(cAlias, cTitulo, cFunExc, cFunAlt)

Return

User function MODELUMA()

    Local lRet := MsgBox("Tem certeza que deseja excluir o registro selecionado?", "Confirma��o", "YESNO")

Return lRet 

User function MODELUMB()

    Local lRet := .F.
    Local cMsg := ""

if INCLUI 
    cMsg := "Confirma inclus�o do registro?"
Else 
    cMsg := "Confirma a altera��o do Registro?"
EndIf 

    lRet := MsgBox(cMsg, "Confirma��o", "YESNO")

Return lRet
