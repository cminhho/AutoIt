#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Chung Ho

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

Func launchChrome()
	Local $chrome_url_start = "https://github.com/cminhho/AutoIt"
	Local $chrome_arguments = " --new-window" ; --incognito --start-maximized --disable-extensions
	Local $ProgramFilesDir = EnvGet('ProgramFiles(x86)') ; for 64bit Win it will return a valid path.

	While 1
		; 32-bit OS (assuming Chrome is 32-bit)
		If Not ProcessExists( "chrome.exe" ) Then Run($ProgramFilesDir & "\Google\Chrome\Application\chrome.exe "&$chrome_url_start&$chrome_arguments)
	WEnd
EndFunc

; Launch Chrome
launchChrome()