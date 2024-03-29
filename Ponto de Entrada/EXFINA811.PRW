#include "TOTVS.CH"
//-------------------------------------------------------------------
/*/{Protheus.doc} 
ExecAuto Fina811()
//FINA810
@author Thiago Prado
@since 17/11/2021
@version 12.1.27
@
/*/
//-------------------------------------------------------------------
function U_xFina811()
	//<<NAO MANIPULAR O FONTE>> APENAS CHUMBE OS VALORES NAS VARIAVEIS
	local a811Param           :={}         as array
	local cCliD               :="000001"   as character //Filtro Cliente DE
	local cLojD               :="01"       as character //Filtro Cliente loja DE
	local cCliAt              :="999999"   as character //Filtro Cliente loja At�
	local cLojAt              :="01"       as character //Filtro Cliente loja At�
	local cLay                :="000001"   as character //Carta de cobran�a
	
	Private aRetorno :={} 
	private lMsErroAuto     := .F.         as logical
	private lAutoErrNoFile  := .T.         as logical

	
	//Prepara��o do Ambiente
	RpcSetEnv("01","01","Admin","","FIN","FINA811",{"SA1"})

	dbSelectArea("FWP")
	FWP->(DbGoTop())
	FWP->(DbSetOrder(1))//FWP_FILIAL, FWP_CODCRT, R_E_C_N_O_, D_E_L_E_T_ 
	if !FWP->(DbSeek(xFilial("FWP") + cLay))  // Valido se encontrou o layout da carta de cobran�a
		conOut("Layout nao encontrado")
		RETURN
	endIf
	//Parametros padroes da rotina
	aAdd( a811Param,  cCliD         							)   //C�digo do cliente De (tipo caracter)
	aAdd( a811Param,  cLojD       								)   //Loja do cliente De (tipo caracter)
	aAdd( a811Param,  cCliAt         							)   //C�digo do cliente At� (tipo caracter)
	aAdd( a811Param,  cLojAt     								)   //Loja do cliente At� (tipo caracter)
	aAdd( a811Param,  dDataBase - 999                           )   //Data de emiss�o De (tipo data)
	aAdd( a811Param,  dDataBase + 180                           )   //Data de emiss�o At� (tipo data)
	aAdd( a811Param,  dDataBase                                 )   //Data de refer�ncia (tipo data)
	aAdd( a811Param,  0                                         )   //Valor de (tipo num�rico)
	aAdd( a811Param,  999999999.99                              )   //Valor At� (tipo num�rico)
	aAdd( a811Param,  '2'                                       )   //"2" (tipo caracter) - IMPORTANTE:  SEMPRE 2 PARA N�O APRESENTAR TELA DE SELE��O DE FILIAIS
	aAdd( a811Param,  '1'                                       )   //T�tulos a vencer (tipo caracter  sendo "1" = Sim ou "2" = N�o)
	aAdd( a811Param,  '1'                                       )   //Considera valor (tipo caracter sendo "1" = Total ou  "2" = Saldo)
	aAdd( a811Param,  '2'                                       )   //2" (tipo caracter) - IMPORTANTE: SEMPRE 2 PARA N�O APRESENTAR TELA DE SELE��O DE SITUA��O DE COBRAN�A
	aAdd( a811Param,  {}                                        )   //{} (tipo array) - IMPORTANTE: ENVIAR ARRAY VAZIO
	aAdd( a811Param,  ''                                        )   //"" (tipo caracter) - IMPORTANTE: SEMPRE VAZIO
	aAdd( a811Param,  cLay                                      )   //C�digo do layout da carta a ser utilizado (tipo caracter)
    aAdd( a811Param,  '2'                                       )   //A1_MSBLQL


	MSExecAuto({|x,y| Fina811(x,y)},0,a811Param)

	if lMsErroAuto
		ConOut("Erro !")
		MostraErro()
		aLog := GetAutoGRLog()
	else
		//FwAlertSucess("Sucesso!")

		Alert("Sucesso!")
	endif

	RpcClearEnv()

Return


