#Include "Protheus.ch"

/*/{Protheus.doc} HACK03
Inclui um registro de ocorrência com os dados fornecidos no TMS
@author izac.ciszevski
@since 02/12/2016
@version undefined
@param cFilOri, characters, Filial de Origem da viagem
@param cViagem, characters, Número da Viagem
@param cCodOco, characters, Código da Ocorrência
@param cFilDoc, characters, Filial do Documento
@param cDoc, characters, Número do Documento
@param cSerie, characters, Série do Documento
@param nQtdVol, numeric, Quantidade de Volumes da Ocorrência
@param cMotivo, characters, Motivo da Ocorrência
@param cLatLong, characters, Posicionamento em latitude e longitude da ocorrência no formato "23.5205844,-46.6217074"
@param FotoBin, characters, binario da foto
@type function
/*/
User Function HACK03(cViagem, cCodOco, cFilDoc, cDoc, cSerie, nQtdVol, cMotivo, cLatLong, FotoBin)
	
	Local lRet   := .F.
	Local aCab   := {}
	Local aItens := {}
	Local cMsg   := CRLF+"Registrada via TMSDroid"
	Local cSeqOco:= StrZero(1, Len(DUA->DUA_SEQOCO))
	Local lDoc   := .F.
	
	Default cFilOri := ""
	Default cViagem := ""
	Default cCodOco := ""
	Default cFilDoc := ""
	Default cDoc    := ""
	Default cSerie  := ""
	Default cLatLong:= ""
	Default nQtdVol := 0
	
	Private lMsErroAuto := .F.
	aItens := {}
	aCab := {}
	
	DTQ->(DbSetOrder(1))
	DTQ->(DbSeek(xFilial("DTQ")+cViagem))
	
	DUA->(DbSetOrder(7))
	While DUA->(DbSeek(xFilial("DUA")+cFilDoc+cDoc+cSerie+cSeqOco))
		cSeqOco := Soma1(cSeqOco)
	End
	
	//-- Cabecalho da Ocorrencia
	Aadd(aCab, {'DUA_FILORI', DTQ->DTQ_FILORI , NIL})
	Aadd(aCab, {'DUA_VIAGEM', cViagem , NIL})
	
	aAdd(aItens,{;
		{'DUA_DATOCO', dDataBase							, NIL},;
		{'DUA_HOROCO', Strtran(Left(Time()	,5), ":", "")	, NIL},;
		{'DUA_CODOCO', cCodOco								, NIL},;
		{'DUA_SEQOCO', cSeqOco  							, NIL},;
		{'DUA_SERTMS', StrZero(3, Len(DUA->DUA_SERTMS))		, NIL},;
		{'DUA_FILDOC', cFilDoc				                , NIL},;
		{'DUA_DOC'   , cDoc					                , NIL},;
		{'DUA_SERIE' , cSerie				                , NIL},;
		{'DUA_QTDOCO', nQtdVol				                , NIL},;
		{'DUA_MOTIVO', cMotivo + cMsg   	                , NIL},;
		{'DUA_XLATLG', cLatLong 			                , NIL};
		})
	
	Begin Transaction
		//-- Inclusao da Ocorrencia
		MsExecAuto({|x, y, z|Tmsa360(x, y, z)}, aCab, aItens, {}, 3)
		
		If lMsErroAuto
			lRet := .F.
			lMsErroAuto := .F.
		Else
			lRet := .T.
			If !empty(FotoBin)
				MemoWrite("\"+StrZero(DUA->(Recno()), 10)+".jpg", FotoBin)
			EndIf
		EndIf
	End Transaction
	
Return lRet
