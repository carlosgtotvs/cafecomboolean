#Include "Protheus.ch"

/*/{Protheus.doc} TM350GRV
Marca os apontamentos realizados via aplicativo para controle.
@author izac.ciszevski
@since 02/12/2016
@version undefined
@type function
/*/
User Function TM350GRV()

	Local lMobile := FwIsInCallStack("u_HACK05")
	
	If lMobile
		RecLock( 'DTW', .F.)
		DTW->DTW_XMOBIL := "1"
		DTW->( MsUnlock())
	EndIf

Return .T.