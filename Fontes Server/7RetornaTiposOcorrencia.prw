#Include "Protheus.ch"

/*/{Protheus.doc} HACK07
Retorna os Tipos de Ocorrência do TMS.
@author izac.ciszevski
@since 02/12/2016
@version undefined
@type function
/*/
User Function HACK07()

	Local cQuery   := ''
	Local cAlias   := GetNextAlias()
	Local aTpOcor := {}

	cQuery := " SELECT "
	cQuery += "    DT2.DT2_CODOCO, " 
	cQuery += "    DT2.DT2_DESCRI "
	cQuery += " FROM "+ RetSqlName("DT2") + " DT2 "
	cQuery += " WHERE "
	cQuery += "        DT2.DT2_FILIAL = '"+xFilial("DT2")+"' "
	cQuery += "    AND DT2.DT2_SERTMS = '3' "
	cQuery += "    AND DT2.D_E_L_E_T_ = ' ' "

	cQuery := ChangeQuery( cQuery)

	dbUseArea( .T., 'TOPCONN', TCGenQry( , , cQuery), cAlias, .F., .T.)

	While (cAlias)->( !Eof())
		AAdd(aTpOcor, {(cAlias)->DT2_CODOCO, (cAlias)->DT2_DESCRI})
		(cAlias)->( DbSkip())
	End
	(cAlias)->( DbCloseArea())	

Return aTpOcor

