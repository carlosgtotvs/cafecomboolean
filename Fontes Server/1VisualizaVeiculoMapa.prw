#Include "Protheus.ch"

/*/{Protheus.doc} HACK01
Abre um mapa com um marcador da geoposição informada no parâmetro.
@author izac.ciszevski
@since 02/12/2016
@version undefined
@param cLatLong, characters, Latitude e longitude formato -23.5205844,-46.6217074
@param cToolTip, characters, Descricao do Marcador
@type function
/*/
User Function HACK01(cLatLong, cToolTip)
	Local cPath := ""
	
	Default cToolTip := "tooltip padrao"
	Default cLatLong := "-23.5205844,-46.6217074"
	
	cPath := GetMapPath(cLatLong, cToolTip)//cLatLong)
	//ShellExecute('open','cmd','/k '+cPath , "", 0)
	Define MsDialog oDlg1 TITLE "FOTO DE OCORRÊNCIA" FROM 0,0 TO 600, 800 PIXEL
	
	oTIBrowser := TIBrowser():New(0,0, 400, 300, cPath, oDlg1 )
	
	Activate MsDialog oDlg1 CENTERED
Return

Static Function GetMapPath(cLatLong, cToolTip)
	Local cPath := "C:\Users\izac.ciszevski\Desktop\exemploComCEP12355.html"
	cPath := WriteMapFile(cLatLong, cToolTip)
Return cPath

Static Function WriteMapFile(cLatLong, cToolTip)
	Local cHTML     := ""
	Local cFilePath := GetTempPath()+FwTimeStamp()+".html"
	Local aGeoPos := StrTokArr(cLatLong, ',')
	
	cHTML +=" <!DOCTYPE html>" + CRLF
	cHTML +=" <html>" + CRLF
	cHTML +="   <head>" + CRLF
	cHTML +="     <meta http-equiv=" + CHR(34) + "X-UA-Compatible" + CHR(34) + " content=" + CHR(34) + "IE=edge" + CHR(34) + ">" + CRLF
	cHTML +="     <meta name=" + CHR(34) + "viewport" + CHR(34) + " content=" + CHR(34) + "initial-scale=1.0, user-scalable=no" + CHR(34) + ">" + CRLF
	cHTML +="     <meta charset=" + CHR(34) + "utf-8" + CHR(34) + ">" + CRLF
	cHTML +="     <title>Simple markers</title>" + CRLF
	cHTML +="     <style>" + CRLF
	cHTML +="       html, " + CRLF
	cHTML +=" 	  body {height: 100%; margin: 0; padding: 0;}" + CRLF
	cHTML +="       #map { height: 100%; }" + CRLF
	cHTML +="     </style>" + CRLF
	cHTML +="   </head>" + CRLF
	cHTML +="   <body>" + CRLF
	cHTML +="     <div id=" + CHR(34) + "map" + CHR(34) + "></div>" + CRLF
	cHTML +="     <script>" + CRLF
	cHTML +=" function initMap() {" + CRLF
	cHTML +="   var myLatLng = {lat: " + aGeoPos[1] + ", lng:" + aGeoPos[2] + "};" + CRLF
	cHTML +="   var map = new google.maps.Map(document.getElementById(" + CHR(39) + "map" + CHR(39) + "), {" + CRLF
	cHTML +="     zoom: 17," + CRLF
	cHTML +="     streetViewControl: false," + CRLF
	cHTML +="     mapTypeControl: false," + CRLF
	cHTML +="     center: myLatLng" + CRLF
	cHTML +="   });" + CRLF
	cHTML +=" " + CRLF
	cHTML +="   var marker = new google.maps.Marker({" + CRLF
	cHTML +="     position: myLatLng," + CRLF
	cHTML +="     map: map," + CRLF
	cHTML +="     title: " + CHR(39) + cToolTip + CHR(39) + "" + CRLF
	cHTML +="   });" + CRLF
	cHTML +=" }" + CRLF
	cHTML +="     </script>" + CRLF
	cHTML +="     <script async defer" + CRLF
	cHTML +="         src=" + CHR(34) + "https://maps.googleapis.com/maps/api/js?key=AIzaSyCdp8FmuWpTSK9AeJf9knOpkIZKSp_Vlgg&callback=initMap" + CHR(34) + "></script>" + CRLF
	cHTML +="   </body>" + CRLF
	cHTML +=" </html>" + CRLF
	
	MemoWrite(cFilePath, cHtml)
	
Return cFilePath
