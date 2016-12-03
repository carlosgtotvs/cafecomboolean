#Include "Protheus.ch"

/*/{Protheus.doc} TM350VLD
Notifica que apontamento foi iniciado por aplicativo e confirma com operador.
@author izac.ciszevski
@since 02/12/2016
@version undefined
@type function
/*/
User Function TM350VLD()
    Local lRet  := .T.
    Local nOpcx := PARAMIXB[3]
    
    If nOpcx == 5 .and.  DTW->DTW_XMOBIL == "1"
    	lRet := MsgYesNo("Apontamento Iniciado por Aplicativo. Tem certeza que deseja estornar?")
    EndIf

Return lRet