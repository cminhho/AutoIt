#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
Func launchAppViaPath($vPath)
	Local $iPID = Run($vPath)
EndFunc

; Launch Microsoft Lync  (Lync)
launchAppViaPath("C:\Program Files\Microsoft Office\Office15\lync.exe")