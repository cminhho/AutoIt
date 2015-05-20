#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
; Insert HTML at the top and bottom of a document

;#include <IE.au3>

;Local $oIE = _IECreate("http://www.autoitscript.com")
;Local $oBody = _IETagNameGetCollection($oIE, "body", 0)
;_IEDocInsertHTML($oBody, "<h2><font color=red>This HTML is inserted After Begin</font></h2>", "afterbegin")
;_IEDocInsertHTML($oBody, "<h2><font color=red>This HTML is inserted Before End</font></h2>", "beforeend")


#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oText = _IEFormElementGetObjByName($oForm, "textExample")
_IEFormElementSetValue($oText, "Hey! This works!")