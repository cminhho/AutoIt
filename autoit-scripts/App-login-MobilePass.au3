#include <Constants.au3>
;
; AutoIt Version: 1.0
; Language:       English
; Platform:       Window7
; Author:         Chung Ho
;
; Script Function:
;   Opens MobilePASS, get password paste into tpc then quits the application.
;

; *********************************************
; Setup your config here
; *********************************************
Local $tokenID = 1234; your MobilePass application password 
Local $mobilePassUrl = "E:\Software Center\Developer Tools\MobilePASS.exe"; MobilePass Applciatoion location
Local $passcode

Func OpenMobilePass()
    ; Run MobilePASS
	Local $iPID = Run($mobilePassUrl)

	; Wait for the MobilePASS to become active. The classname "MobilePASS" is monitored instead of the window title
	Local $hWnd = WinWait("[CLASS:MobilePASS]", "", 1)

	; Enter Token PIN
	Local $setToken = ControlSetText("MobilePASS", "", "[CLASS:Edit;INSTANCE:1]", $tokenID)

	; Retrieve the handle of the continue control in MobilePASS. The handle returned by WinWait is used for the "title" parameter of ControlGetHandle.
	ControlClick("MobilePASS","","[CLASS:Button;INSTANCE:3]")

	;Give MobilePASS some time to load
	Sleep(2000) 

	; Retrieve the text of the edit control
	$passcode = ControlGetText("MobilePASS", "", "[CLASS:Edit;INSTANCE:1]")

	; End MobilePASS app
	ProcessClose($iPID)
EndFunc 
