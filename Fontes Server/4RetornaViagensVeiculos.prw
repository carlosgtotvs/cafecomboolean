#Include "Protheus.ch"

/*/{Protheus.doc} HACK04
Retorna as viagens de determinado veículo. Se tiver viagem em transito, retorna somente ela.
@author izac.ciszevski
@since 02/12/2016
@version undefined
@param cVeiculo, characters, Cod. Protheus do Veículo
@type function
/*/
User Function HACK04(cVeiculo)

	Local cQuery   := ''
	Local cAlias   := GetNextAlias()
	Local aViagens := {}

	cQuery := " SELECT DISTINCT"
	cQuery += "    DTR.DTR_VIAGEM, DTQ.DTQ_STATUS " 
	cQuery += " FROM "+ RetSqlName("DTR") + " DTR "
	cQuery += " INNER JOIN "+RetSqlName("DTQ")+" DTQ  "
	cQuery += "     ON DTQ.DTQ_FILIAL = '"+xFilial("DTQ")+"' "
	cQuery += "    AND DTQ.DTQ_VIAGEM = DTR.DTR_VIAGEM "
	cQuery += "    AND (DTQ.DTQ_STATUS = '2' OR DTQ.DTQ_STATUS = '5')" 
	cQuery += "    AND DTQ.D_E_L_E_T_ = ' ' "
	cQuery += " WHERE "
	cQuery += "        DTR.DTR_FILIAL = '"+xFilial("DTR")+"' "
	cQuery += "    AND DTR.DTR_CODVEI = '" + cVeiculo + "'" 
	cQuery += "    AND DTR.D_E_L_E_T_ = ' ' "
	cQuery += "    ORDER BY DTQ.DTQ_STATUS "

	cQuery := ChangeQuery( cQuery)

	dbUseArea( .T., 'TOPCONN', TCGenQry( , , cQuery), cAlias, .F., .T.)

	While (cAlias)->( !Eof())
		AAdd(aViagens, (cAlias)->DTR_VIAGEM)
		(cAlias)->( DbSkip())
		If (cAlias)->DTQ_STATUS == '2'
			exit
		EndIf
	End
	(cAlias)->( DbCloseArea())	

Return aViagens