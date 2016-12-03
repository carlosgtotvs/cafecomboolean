#Include "Protheus.ch"

/*/{Protheus.doc} HACK02
Abre arquivo passado por parâmetro
@author izac.ciszevski
@since 02/12/2016
@version undefined
@param cFilePath, characters, Caminho completo do arquivo
@type function
/*/
User Function HACK02(cFilePath)
    If !empty(cFilePath) .and. File(cFilePath)
        
        Define MsDialog oDlg1 TITLE "FOTO DE OCORRÊNCIA" FROM 0,0 TO 600, 800 PIXEL
         oTBitmap1 := TBitmap():New(01,01, 400, 300,,cFilePath,.T.,oDlg1,;
        	{||},,.F.,.F.,,,.F.,,.T.,,.F.)
		 oTBitmap1:lStretch := .T.
        Activate MsDialog oDlg1 CENTERED
    Else
    	MsgInfo("Foto não registrada para esta ocorrência.","Foto")
    EndIf
Return
