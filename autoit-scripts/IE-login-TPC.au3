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
Local $tpcUsername = "hmchung@tma.com.vn"; your TPC login email
Local $tpcUrl = "https://tpc-sslvpn-apac.alcatel-lucent.com/workplace/access/home"
Local $passcode = 1234;

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

; Login TPC
LoginTPC();
