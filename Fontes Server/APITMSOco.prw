#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"

WSRESTFUL APITMSOco DESCRIPTION "Servicos REST Modulo TMS - Ocorrencias"

WSDATA id AS STRING

WSMETHOD GET DESCRIPTION "Retorna Códigos de Ocorrência." WSSYNTAX "/APITMSOco || /APITMSOco/{id}" PRODUCES APPLICATION_JSON
WSMETHOD POST DESCRIPTION "Aponta ocorrência." PATH "{id}" PRODUCES APPLICATION_JSON 

END WSRESTFUL 

WSMETHOD GET WSSERVICE APITMSOco

Local lPost    := .T.
Local oResponse := JsonObject():New()

Local aOcorr := {}
Local nOco

cFilAnt := "010201"

// define o tipo de retorno do método
::SetContentType("application/json")
 
// verifica se recebeu parametro pela URL
// exemplo: http://localhost:8080/sample/1
If .T. //Len(::aURLParms) > 0
   
	aOcorr := U_HACK07() //{{"001","ENTREGA REALIZADA"},{"002","AVARIA"},{"003","INFORMATIVA"}}
	
	oResponse['ocorrencias'] := {}
	For nOco := 1 To Len(aOcorr)
		AAdd(oResponse['ocorrencias'],JsonObject():New())
		oResponse['ocorrencias'][nOco]['cod'] := aOcorr[nOco][1]
		oResponse['ocorrencias'][nOco]['desc'] := AllTrim(aOcorr[nOco][2])
	Next
	
	::SetResponse(FWJsonSerialize(oResponse, .F., .F., .T.))
	
Else
   SetRestFault(400, "idveiculo parameter is mandatory")
   lPost := .F.
EndIf

Return lPost





WSMETHOD POST PATHPARAM id WSSERVICE APITMSOco

Local lPost := .F.
Local cViagem  := PadL(Upper(AllTrim(::id)),6,"0")

Local oResponse := JsonObject():New()
Local oMessage  := JsonObject():New()
Local oRequest  := JsonObject():New()

cFilAnt := "010201"

If oRequest:fromJson(::GetContent())
	
	If oRequest:hasProperty('cViagem') .And. ;
		oRequest:hasProperty('cCodOco') .And. ;
		oRequest:hasProperty('cFilDoc') .And. ;
		oRequest:hasProperty('cDoc') .And. ;
		oRequest:hasProperty('cSerie') .And. ;
		oRequest:hasProperty('nQtdVol') .And. ;
		oRequest:hasProperty('cMotivo') .And. ;
		oRequest:hasProperty('cLatLong') .And. ;
		oRequest:hasProperty('FotoBin')
		
		lPost := U_HACK03(oRequest["cViagem"], oRequest["cCodOco"], oRequest["cFilDoc"], oRequest["cDoc"], oRequest["cSerie"], oRequest["nQtdVol"], oRequest["cMotivo"], oRequest["cLatLong"], oRequest["FotoBin"])
	
	EndIf
	
EndIf

Return lPost


