#Include "Protheus.ch"

/*/{Protheus.doc} TM360EST
Notifica que apontamento foi iniciado por aplicativo e confirma com operador.
@author izac.ciszevski
@since 03/12/2016
@version undefined
@type function
/*/
User Function TM360GRV()
    Local lRet  := .T.
    
    DUA->(DbSetOrder(1))
	DUA->(DbSeek(xFilial("DTQ")+PARAMIXB[2]+PARAMIXB[3]+PARAMIXB[4]+PARAMIXB[5]))
    If !empty(DUA->DUA_XLATLG)
    	MsgAlert("A Ocorrência estornada foi Iniciada por Aplicativo.", "Atenção!")
    EndIf

Return lRet