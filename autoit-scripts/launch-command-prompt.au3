#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
Func launchAppViaCommandPrompt($CMD)
	; Run app via Command Prompt
	RunWait(@ComSpec & " /c start " & $CMD)
EndFunc

; Launch Outlook
;launchAppViaCommandPrompt("outlook");