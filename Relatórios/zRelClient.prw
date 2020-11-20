#include "protheus.ch"

User Function tReport1()
   //Informando o vetor com as ordens utilizadas pelo relat�rio
   MPReport("MPREPORT1","SA1","Relacao de Clientes","Este relat�rio ir� imprimir a relacao de clientes",{"Por Codigo","Alfabetica","Por "+RTrim(RetTitle("A1_CGC"))})
Return
 
User Function tReport2()
   //Informando para fun��o carregar os �ndices do Dicion�rio de �ndices (SIX) da tabela
   MPReport("MPREPORT2","SA1","Relacao de Clientes","Este relat�rio ir� imprimir a relacao de clientes",,.T.)
Return
