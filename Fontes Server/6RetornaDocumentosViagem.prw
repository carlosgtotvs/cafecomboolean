#Include "Protheus.ch"

/*/{Protheus.doc} HACK06
Retorna os documentos de determinada viagem
@author izac.ciszevski
@since 02/12/2016
@version undefined
@param cViagem, characters, Código da Viagem
@type function
/*/
User Function HACK06(cViagem)

	Local cQuery   := ''
	Local cAlias   := GetNextAlias()
	Local aDocumentos := {}

	cQuery := " SELECT DISTINCT"
	cQuery += "    DUD.DUD_FILDOC, "
	cQuery += "    DUD.DUD_DOC, "
	cQuery += "    DUD.DUD_SERIE, "
	cQuery += "    DT6.DT6_CLIDES,"
	cQuery += "    DT6.DT6_LOJDES"
	cQuery += " FROM "+ RetSqlName("DUD") + " DUD "
	cQuery += " INNER JOIN "+RetSqlName("DT6")+" DT6  "
	cQuery += "     ON DT6.DT6_FILIAL = '"+xFilial("DT6")+"' "
	cQuery += "    AND DT6.DT6_FILDOC = DUD.DUD_FILDOC "
	cQuery += "    AND DT6.DT6_DOC    = DUD.DUD_DOC    "
	cQuery += "    AND DT6.DT6_SERIE  = DUD.DUD_SERIE "
	cQuery += "    AND DT6.D_E_L_E_T_ = ' ' "
	cQuery += " WHERE "
	cQuery += "        DUD.DUD_FILIAL = '"+xFilial("DUD")+"' "
	cQuery += "    AND DUD.DUD_VIAGEM = '"+ cViagem +"'" 
	cQuery += "    AND DUD.DUD_DOC !  = ' ' "
	cQuery += "    AND DUD.D_E_L_E_T_ = ' ' "
	cQuery := ChangeQuery( cQuery)

	dbUseArea( .T., 'TOPCONN', TCGenQry( , , cQuery), cAlias, .F., .T.)

	While (cAlias)->( !Eof())
		AAdd(aDocumentos,{(cAlias)->DUD_FILDOC + '-' + (cAlias)->DUD_DOC + '/' + (cAlias)->DUD_SERIE,;
		                  Posicione("SA1",1, xFilial("SA1")+(cAlias)->(DT6_CLIDES+DT6_LOJDES), "A1_NOME") })
		(cAlias)->( DbSkip())
	End
	(cAlias)->( DbCloseArea())	

Return aDocumentos

