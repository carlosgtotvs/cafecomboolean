#Include "Protheus.ch"

/*/{Protheus.doc} HACK05
Faz o apontamento de Início ou Fim da Viagem
@author izac.ciszevski
@since 02/12/2016
@version undefined
@param cViagem, characters, descricao
@type function
/*/
User Function HACK05(cViagem, lChegada)
	
	Local cHorOpe    := StrTran(Left(Time(),5),":")
	Local cAtividade := ""
	Local cAtivSai   := Padr(GetMv("MV_ATIVSAI",,""), Len(DTW->DTW_ATIVID))  // Atividade de saida.
	Local cAtivChg   := Padr(GetMv("MV_ATIVCHG",,""), Len(DTW->DTW_ATIVID))  // Atividade de chegada.
	Local nResult    := -1
	
	Default lChegada := .F.
	
	cAtividade := iIf(lChegada,cAtivChg,cAtivSai)
	
	DTQ->(DbSetOrder(1))
	If DTQ->(DbSeek(xFilial("DTQ")+cViagem))
		DTW->(DbSetOrder(4))
		If DTW->(DbSeek(xFilial("DTW")+DTQ->DTQ_FILORI+cViagem+cAtividade))
			If DTW->DTW_STATUS == '1'
				If TMSA350Grv(3, DTQ->DTQ_FILORI, cViagem, cAtividade, dDataBase, cHorOpe, dDataBase, cHorOpe )
					nResult := 1
				EndIf
			ElseIf DTW->DTW_STATUS == '2'
				nResult := 2
			EndIf
		Endif
	EndIf
Return nResult
