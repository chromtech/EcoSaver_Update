
;StartRun_Button
; Hit ENTER on all windows that contain    GC Acquisition    in Title
; Use for start Run in MH


SetTitleMatchMode 2
DetectHiddenWindows, On


WinWait ,DriverSetup(X64),,2
	;MsgBox FOUND
	WinActivate
	WinWaitActive
	ControlClick ,UNINSTALL,DriverSetup(X64)
	
FileAppend , Started Driver Uninstall, \EcoSaverUpdate\log.txt

WinWait ,,No device is found,2
	if ErrorLevel=0
	{
		;MsgBox FOUND
		WinActivate
		WinWaitActive
		ControlClick ,OK
		FileAppend , Driver was not installed `n, \EcoSaverUpdate\log.txt
	}

WinWait ,DriverSetup,,20
	;MsgBox FOUND Driver Setup window
	ControlClick ,OK,DriverSetup


WinWait ,DriverSetup(X64),,2
	;MsgBox FOUND Driver Setup window (x64)
	WinActivate
	WinWaitActive
	ControlClick ,INSTALL,DriverSetup(X64)

FileAppend , Driver Install...`n, \EcoSaverUpdate\log.txt

WinWait ,,Driver install success!,180
	;MsgBox FOUND Success
	WinActivate
	WinWaitActive
	ControlClick ,OK, DriverSetup
	FileAppend , Driver successfully installed `n, \EcoSaverUpdate\log.txt

WinClose , DriverSetup(X64),,10
	;MsgBox DONE

























































































































































































