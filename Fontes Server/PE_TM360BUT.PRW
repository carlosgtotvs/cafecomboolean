#Include "Protheus.ch"

/*/{Protheus.doc} TM360BUT
Adiciona Botões na tela de Registro de Ocorrências
@author izac.ciszevski
@since 02/12/2016
@version undefined

@type function
/*/
User Function TM360BUT()
	Local aButtons := {}
	If !INCLUI
		AAdd( aButtons, {'LOCALIZA',{|| u_HACK01(DUA->DUA_XLATLG, Posicione("DT2",1,xFilial("DT2")+DUA->DUA_CODOCO,"DT2_DESCRI")) }, 'Exibe a localização da ocorrência'})
		AAdd( aButtons, {'FOTO'    ,{|| u_HACK02("\"+StrZero(DUA->(Recno()), 10 )+".jpg")                                             }, 'Exibe a foto da ocorrência.'      })
	EndIf
Return aButtons
