#include <Constants.au3>
#include <IE.au3>
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
Local $tpcUsername = "hmchung@tma.com.vn"; your TPC login email
Local $mobilePassUrl = "E:\Software Center\Developer Tools\MobilePASS.exe"; MobilePass Applciatoion location
Local $tpcUrl = "https://tpc-sslvpn-apac.alcatel-lucent.com/workplace/access/home"
Local $passcode

Func LoginTPC()
    ;create the webpage
    $oIE = _IECreate ($tpcUrl, 1, 1, 1, 1)
	
	;find the object in the page with the name "Log in to"
	$o_loginTo = _IEGetObjByName ($oIE, "realmID")
	_IEFormElementSetValue ($o_loginTo, 148)

	;find the object in the page with the name "submit" and click on it
	$o_submit = _IEGetObjByName ($oIE, "realmButton")
	_IEAction ($o_submit, "click")

	;wait the end of loading
	_IELoadWait ($oIE)
	 
	;find the object in the page with the name "username"
	$o_user = _IEGetObjByName ($oIE, "data_0")
	_IEFormElementSetValue ($o_user, $tpcUsername)

	;find the object in the page with the name "password"
	$o_password = _IEGetObjByName ($oIE, "data_1")
	_IEFormElementSetValue ($o_password, $passcode )

	;find the object in the page with the name "submit" and click on it
	$o_login = _IEGetObjByName ($oIE, "okButton")
	_IEAction ($o_login, "click")
EndFunc 

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

Func loginVNC()
	; ----------------- VNC Viewer -----------------
	; Run VNC
	Local $iPID = Run("C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe")
	
	; Wait for the VNC to become active.
	Local $hWnd = WinWait("[CLASS:VNC Viewer]", "", 1)
	
	; Enter VNC Server input
	ControlSetText("VNC Viewer", "", "[CLASS:Edit; INSTANCE:1]", "192.168.92.152:11")
	
	; Connect to VNC 
	ControlClick("VNC Viewer", "", "[CLASS:Button; INSTANCE:3]")
	
	;----------------- VNC Viewer - Authentication -----------------
	; Give "VNC Viewer - Authentication" some time to load
	Sleep(1000) 
	
	; Enter the "Password" input
	ControlSetText("VNC Viewer - Authentication", "", "[CLASS:Edit; INSTANCE:2]", 123456)
	
	; Try to login
	ControlClick("VNC Viewer - Authentication", "", "[CLASS:Button; INSTANCE:1]")
EndFunc

Func loginEzProzyManager()
	; ----------------- ezProxy Manager v2.8.5 Build20090201 -----------------
	; Run ezProxy Manager
	Local $iPID = Run("C:\Program Files (x86)\ezProxy\ezProxy.exe")
	Local $iPIDService = Run("C:\Program Files (x86)\ezProxy\ezEngine.exe")
	
	; Wait for the app to become active
	Local $hWnd = WinWait("[CLASS:ezProxyManager]", "", 1)
	
	; Try to login to ezProxy Manager
	ControlClick("ezProxy Manager v2.8.5 Build20090201", "", "[CLASS:ToolbarWindow32; INSTANCE:1]", "left", 1, 25, 20)
	; ----------------- Login ezProxy -----------------
	; Give "Login ezProxy" some time to load
	Sleep(1000) 
	Send("1234{Enter}")
EndFunc

Func launchChrome($chrome_url_start)
	;Local $chrome_url_start = "https://192.168.92.152:8443/taskcenter/app/home"
	Local $chrome_arguments = " --new-window" ; --incognito --start-maximized --disable-extensions
	Local $ProgramFilesDir = EnvGet('ProgramFiles(x86)') ; for 64bit Win it will return a valid path.

	While 1
		; 32-bit OS (assuming Chrome is 32-bit)
		If Not ProcessExists( "chrome.exe" ) Then Run($ProgramFilesDir & "\Google\Chrome\Application\chrome.exe "&$chrome_url_start&$chrome_arguments)
	WEnd
EndFunc

Func launchAppViaCommandPrompt($CMD)
	; Run app via Command Prompt
	RunWait(@ComSpec & " /c start " & $CMD)
EndFunc

Func launchAppViaPath($vPath)
	Local $iPID = Run($vPath)
EndFunc

Func CloseApplicationProcess($vVar1)
	;Local $mpProc = "MobilePASS.exe"
	While ProcessExists($vVar1)
		ProcessClose($vVar1)
	Wend
EndFunc 

Func CloseWindow($vVar1)
	While WinExists($vVar1)
		WinClose($vVar1)
	Wend
EndFunc 

; *********************************************
; Event
; *********************************************
; Close MobilePASS
CloseApplicationProcess("MobilePASS.exe")

; Close TPC Portal
CloseWindow("TPC Portal - Windows Internet Explorer")

; Launch MobilePASS
OpenMobilePass()

; Launch TPC Portal
LoginTPC()

; Launch VNC
loginVNC()

; Launch exProzy
loginEzProzyManager();

; Launch Chrome
launchChrome("https://192.168.92.152:8443/taskcenter/app/home")

; Launch Microsoft Lync  (Lync)
launchAppViaPath("C:\Program Files\Microsoft Office\Office15\lync.exe")

; Launch Outlook
launchAppViaCommandPrompt("outlook");

; Launch Q-Dir
launchAppViaPath("C:\Program Files\Q-Dir\Q-Dir.exe")

; Launch Dual Monitor
launchAppViaPath("C:\Program Files (x86)\Dual Monitor\DualMonitor.exe")
