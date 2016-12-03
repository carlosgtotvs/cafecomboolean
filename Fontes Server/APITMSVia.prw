#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"

WSRESTFUL APITMSVia DESCRIPTION "Servicos REST Modulo TMS - Viagens"

WSDATA id  AS STRING
WSDATA cativvia  AS INTEGER

WSMETHOD GET DESCRIPTION "Retorno de Viagens do Veículo" PATH "{id}" WSSYNTAX "/APITMSVia || /APITMSVia/{id}" PRODUCES APPLICATION_JSON
WSMETHOD PUT DESCRIPTION "Confirma saida da Viagem" PATH "{id}/{cativvia}" WSSYNTAX "/APITMSVia/{id},{cativvia}" PRODUCES APPLICATION_JSON

END WSRESTFUL

WSMETHOD GET PATHPARAM id WSSERVICE APITMSVia
	
	Local lPost    := .T.
	Local oResponse := JsonObject():New()
	
	Local aViagens := {}
	Local nVia
	
	Local cVeiculo := PadL(Upper(AllTrim(::id)),7,"0")
	
	cFilAnt := "010201" //base aproveitada de cliente estava errada
	
	// define o tipo de retorno do método
	::SetContentType("application/json")
	
	// verifica se recebeu parametro pela URL
	// exemplo: http://localhost:8080/sample/1
	If !Empty(::id)
		
		aViagens := U_HACK04(cVeiculo)
		
		oResponse['id'] := cVeiculo
		oResponse['viagens'] := {}
		For nVia := 1 To Len(aViagens)
			AAdd(oResponse['viagens'],JsonObject():New())
			oResponse['viagens'][nVia]['cod'] := aViagens[nVia]
		Next
		
		::SetResponse(FWJsonSerialize(oResponse, .F., .F., .T.))
		
	Else
		SetRestFault(400, "id parameter is mandatory")
		lPost := .F.
	EndIf
	
Return lPost

WSMETHOD PUT PATHPARAM id, cativvia WSREST APITMSVia

Local cViagem   := PadL(Upper(AllTrim(::id)),6,"0")
Local lPost     := .T.
Local oResponse := JsonObject():New()
Local aDocs
Local nDoc

cFilAnt := "010201"


If( lPost := (( nResult := U_HACK05( cViagem, ::cativvia == 2)) > 0  ))
	oResponse['Mensagem'] := 'Viagem '+cViagem+' '+Iif(::cativvia == 1,'Iniciada.','Finalizada')
	aDocs := U_HACK06(cViagem)
	oResponse['documentos'] := {}
	oResponse['result'] := nResult
	For nDoc := 1 To Len(aDocs)
		AAdd(oResponse['documentos'],JsonObject():New())
		oResponse['documentos'][nDoc]['documento'] := aDocs[nDoc][1]
		oResponse['documentos'][nDoc]['destinatario'] := AllTrim(aDocs[nDoc][2])
	Next
	
	::SetResponse(FWJsonSerialize(oResponse, .F., .F., .T.))
	
Else
	SetRestFault(400, "erro ao apontar inicio da viagem.")
	
EndIf

Return lPost




