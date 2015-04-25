' Run this script as administrator to enable natural scrolling on all Mice
' From an admin command prompt: cscript NetMouseFlipFlop.vbs
' Copyright 2015 Sylvain Dornadic

Dim WshShell, oExec
Set WshShell = WScript.CreateObject("WScript.Shell")
Set oExec = WshShell.Exec("reg query hklm /v ""FlipFlopWheel"" /s")

x = oExec.StdOut.ReadLine

Do Until oExec.StdOut.AtEndOfStream
  x = oExec.StdOut.ReadLine

  If InStr(x, "HID") > 0 Then
    'reg add "HKLM\SYSTEM\ControlSet001\Enum\HID\{00001124-0000-1000-8000-00805f9b34fb}_VID&0002045e_PID&07a2&Col01\9&30f7670c&0&0000\Device Parameters" /v FlipFlopWheel /t REG_DWORD /d 0x01
    regcmd = "reg add " & """" & x & """" & " /v FlipFlopWheel /f /t REG_DWORD /d 0x01"
	Wscript.Echo(regcmd)
	WshShell.Run(regcmd)
  End If
  Loop