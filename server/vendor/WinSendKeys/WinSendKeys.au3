#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=WinSendKeys
#AutoIt3Wrapper_Res_Fileversion=3.2.1.0
#AutoIt3Wrapper_Res_LegalCopyright=(c) 2011 Ath
#AutoIt3Wrapper_Res_Language=1033
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
$appVersion = "3.2.1.0"
; WinSendKeys 3.2.1.0
; By Ath, after a request by Split_e at www.donationcoder.com/forum/index.php?topic=25389.0
; Scripting added after an addition request by cranioscopical in the same thread
; History:
; 2011-10-01, version 3.2.1.0
; + Added ini variable expandvariables, to complement -v commandline parameter
; 2011-09-30, version 3.2.0.1
; * Added 5 commands to the -f mode: (All commands should be on the beginning of a line)
;   --goto label	: goto this label
;   --gosub label <parameters>	: goto this label, but keep current script position to be able to return to the next line, can be nested, parameters can be used with a --msg using $params$
;   --return		: return to the next line we where gosubbed from
;   --quit			: terminate the script immediately
;   --msg [timeout,]message text	: Display a message and wait for OK to be pressed, or until timeout (in sec) has expired, expands environment vars (%), macros (@) and variables ($) embedded, like $params$
; 2011-09-29, version 3.2.0.0
; * Added 4 commands to the -f mode: (All commands should be on the beginning of a line)
;   --winwait ["]window title or name["] [maxwaitsec]	: Wait for a window with the give name or title or exename. Wait max. number of seconds specified or endless if not specified or 0
;   --winclose ["]window title or name["] [maxwaitsec]	: Wait for the window with given name or title or exename to be- or go- away (close). Wait max. number of seconds specified or endless if not specified or 0
;   --error quit		: Depending on the result of --winwait or --winclose with timeout: If timeout is reached then error is set, 'quit' stops the script
;   --error goto label	: On error goto this label
;   --:<label>			: Define a label so we can jump there on error or on demand
; 2011-06-21, version 3.1.0.0
; * Added 3 commands to the -f mode: (All commands should start on the beginning of a line)
;   --window windowname				: activate window, the same rules as for the -w commandline parameter apply
;   --exec exename					: activate/run exename, equivalent to -x commandline parameter
;   --exec "exename"_"parameters"	: activate/run exename with some parameters, the same as both -x and -xp commandline parameters, all 4 quotes and the underscore are required!
;   --delay delay_in_msec			: delay processing for this count of milliseconds
; + Added -v parameter to enable %environment.var% and @macro@ expansion on keystrokes
; + Added %environment.var% and @macro@ expansion on -x and -xp parameters
; 2011-06-21, version 3.0.5.0
; ! Removed a left over MsgBox, strange nobody noticed that, including me...
; 2011-04-22, version 3.0.4.0
; ! Bugfix if -? was given for parameter. Is now handled properly.
; * Added version & info resource to compiled exe
; * Changed by adding #regions to allow code-folding for a little easier maintainability
; 2011-03-13, version 3.0.3
; * Improvement: A numeric WindowName is now treated as a WindowHandle (HWnd), as requested by mouser
; 2011-03-12, version 3.0.2
; ! BugFix in detecting an active application/window
; + Added application version to helpmessage
; * Minor cleanup
; * Adapted the helptext somewhat
; ! Revision history reverted, now has latest on top
; 2011-02-11, version 3.0.1
; + Added -xd delay option to wait after running the -x executable_filepath. It already has the delay of -t (100 msec), and this is added when specified. Experiment with the required delay (milliseconds).
;   as additionally requested by kikon in this thread: http://www.donationcoder.com/forum/index.php?topic=25553
; + This delay can be preset in the optional inifile, (see version 2.5 changelog)
;   Variable:
;   exedelay=0
; ! Updated helpmessage, fixed some readme typos
; 2011-02-09, version 3.0
; + Added -x executable_filepath option to start if WindowName is not found or executable filename is not found running
;   as additionally requested by kikon in this thread: http://www.donationcoder.com/forum/index.php?topic=25553
; + Added -xp executable_parameters option to specify parameters to executable_filepath
; 2011-02-07, version 2.6
; + Added -c option to read keystrokes from the clipboard, as requested by mouser & kikon in this thread: http://www.donationcoder.com/forum/index.php?topic=25553
; + Added -cn option, like -c, but does not send an {ENTER} after each line, can be added after -c -r -cc to disable the {Enter} being sent
; + Added -cc option, like -c but embeds the clipboard into the KeyStrokes commandline sequence using #$ prefix, see readme for details
; 2011-01-30, version 2.5
; ! Avoid ever overwriting the script with debug-log-file (if not .au3 or .exe extension, add .log to scriptname)
; + Added reading settings from optional .ini file:
;   Get parameters from .ini file with the same name as this script/exe, only if the file exists, create file manually!
;   Sectionname: [Settings]
;   Variables:
;   delay=100 : delay between keystrokes/mousestrokes sent to the application
;   mousestrokes=0 : Enable mousestrokes by setting this to 1
;   mousespeed=0 : Speedfactor for mouse move, value between 0 and 100, 0 = immediate, 1 = fast, 100 = slow
; - Documented and optimized script functions
; 2011-01-29, version 2.5-beta
; + Added -f strokesfile option to read keystrokes and mousestrokes from named file,
;            commandline strokes are handled first
; - Minor adjustments
; 2011-01-28, version 2.0,
; * Changed WinTitleMatchMode to be case-insensitive
; ! Fixed MouseClick mode
; + Allow Activate-Only by giving no keystrokes
; - Window not found message shows only in debug mode
; - Updated helpmessage
; 2011-01-27, version 2.0-beta,
; + Added mouse-modes, postfix with ## for ControlClick, #% for MouseClick
; + Added more logging and messages
; 2011-01-25
; ! upx compression disabled
; + Debug mode writes to .log file
; - Formatted helpmessage a little better
; 2011-01-24
; + Initial release, send keystrokes to a named window
;--------------------------------
; options:
; -t timeout
; -w windowname
;    naming according to these rules: http://www.autoitscript.com/autoit3/docs/intro/windowsadvanced.htm
; -d : Debug mode
; -m : Enable mouse-mode, cursor speed 0 = immediate
; -mm speed : Enable mouse-mode, moving cursor with speed (1..100)
; -f strokesfile ; Read KeyStrokes/MouseStrokes from this file. Any commandline provided strokes are handled first
; -c : Enable clipboard-mode, read KeyStrokes/MouseStrokes from the Windows clipboard
; -x executable_filepath : Enable mode to start that exe if WindowName not found (or not provided) and executable filename not found running
; -xp executable_parameters : Parameters to pass to executablefilepath specified using -x option, enclose in quotes when spaces are needed
; -xd delay : Number of milliseconds to wait after starting executable_filepath before execution continues
; -v : enable %environment.var% and @macro@ expansion on keystrokes
; Keystrokes: http://www.autoitscript.com/autoit3/docs/appendix/SendKeys.htm
; Mouse-mode uses ControlClick or MouseClick, depending on parameters, see:
;  http://www.autoitscript.com/autoit3/docs/functions/ControlClick.htm
;  http://www.autoitscript.com/autoit3/docs/functions/MouseClick.htm

#region Public vars
Global $dela = 100 ; msec delay between keystrokes sent
Global $win = "" ; Name of Window to activate
Global $dbg = 0 ; Debug mode
$dbgfile = "" ; Write logging to this file
$canmouse = 0 ; Enable mouse actions
$mspeed = 0 ; Mouse-speed
$fmode = 0 ; File-mode
$fname = "" ; File to read strokes from
$cmode = 0 ; Clipboard-mode
$cemode = 1 ; Clipboardmode with Enter
Dim $carr[1] = [0] ; Initialize clipboard stuff
$cline = 0
$xfile = "" ; Executablefilepath
$xpara = "" ; Exectutable parameters
$xdela = 0 ; Execute Delay in msec
$varexp = 0 ; Variable expansion disabled
$help = 0 ; Display help?
#endregion

#region Main
;-----------------------
; main()
;-----------------------
If $CmdLine[0] < 1 Then
	ShowHelp()
Else
#region Commandline parameters
	readIniFile()
	$p = 1
	$n = 1
	While $n <= $CmdLine[0]
		If ($p = $n) And (StringLeft($CmdLine[$n], 1) = "-") Then
			If (StringLower($CmdLine[$n]) = "-t") And ($n < $CmdLine[0]) Then
				$n += 1
				$dela = $CmdLine[$n]
				$p = $n + 1
				If $dbg Then writeLogLine("Keystroke send delay (-t): " & $dela)
			EndIf
			If (StringLower($CmdLine[$n]) = "-w") And ($n < $CmdLine[0]) Then
				$n += 1
				$win = $CmdLine[$n]
				$p = $n + 1
				If $dbg Then writeLogLine("Window name (-w): " & $win)
			EndIf
			If StringLower($CmdLine[$n]) = "-d" Then
				$dbg = 1
				$p = $n + 1
				$dbgfile = StringReplace(@ScriptName, ".au3", ".log")
				If $dbgfile = @ScriptName Then
					$dbgfile = StringReplace(@ScriptName, ".exe", ".log")
					If $dbgfile = @ScriptName Then $dbgfile = @ScriptName & ".log" ; Extra safety-measure
				EndIf
				If $dbg Then writeLogLine("Debug logging enabled")
			EndIf
			If StringLower($CmdLine[$n]) = "-m" Then
				$canmouse = 1
				$p = $n + 1
				If $dbg Then writeLogLine("Mousemode enabled")
			EndIf
			If (StringLower($CmdLine[$n]) = "-mm") And ($n < $CmdLine[0]) Then
				$canmouse = 1
				$n += 1
				$mspeed = $CmdLine[$n]
				If $mspeed < 0 Or $mspeed > 100 Then $mspeed = 0
				$p = $n + 1
				If $dbg Then writeLogLine("Mousemode enabled, speed: " & $mspeed)
			EndIf
			If (StringLower($CmdLine[$n]) = "-f") And ($n < $CmdLine[0]) Then
				$n += 1
				$fmode = 1
				$fname = $CmdLine[$n]
				$p = $n + 1
				If $dbg Then writeLogLine("Filemode, reading from file: " & $fname)
			EndIf
			If StringLower($CmdLine[$n]) = "-c" Then
				$cmode = 1
				$p = $n + 1
				If $dbg Then writeLogLine("Clipboardmode enabled")
			EndIf
			If StringLower($CmdLine[$n]) = "-cc" Then
				$cmode = 2
				$p = $n + 1
				If $dbg Then writeLogLine("Clipboard-command-mode #$ enabled")
			EndIf
			If StringLower($CmdLine[$n]) = "-cn" Then
				If Not $cmode Then $cmode = 1
				$cemode = 0
				$p = $n + 1
				If $dbg Then writeLogLine("Clipboardmode without Enter enabled")
			EndIf
			If (StringLower($CmdLine[$n]) = "-x") And ($n < $CmdLine[0]) Then
				$n += 1
				AutoItSetOption("ExpandEnvStrings", 1) ; Allow for environment variables to be expanded
				AutoItSetOption("ExpandVarStrings", 1) ; Replace @ and $ enclosed variables
				$xfile = $CmdLine[$n]
				AutoItSetOption("ExpandVarStrings", 0) ; Restore setting
				AutoItSetOption("ExpandEnvStrings", 0) ; Restore setting
				$p = $n + 1
				If $dbg Then writeLogLine("Executable Filepath specified: " & $xfile)
			EndIf
			If (StringLower($CmdLine[$n]) = "-xp") And ($n < $CmdLine[0]) Then
				$n += 1
				AutoItSetOption("ExpandEnvStrings", 1) ; Allow for environment variables to be expanded
				AutoItSetOption("ExpandVarStrings", 1) ; Replace @ and $ enclosed variables
				$xpara = $CmdLine[$n]
				AutoItSetOption("ExpandVarStrings", 0) ; Restore setting
				AutoItSetOption("ExpandEnvStrings", 0) ; Restore setting
				$p = $n + 1
				If $dbg Then writeLogLine("Executable Parameters specified: " & $xpara)
			EndIf
			If (StringLower($CmdLine[$n]) = "-xd") And ($n < $CmdLine[0]) Then
				$n += 1
				$xdela = $CmdLine[$n]
				$p = $n + 1
				If $dbg Then writeLogLine("Executable Delay specified: " & $xdela)
			EndIf
			If StringLower($CmdLine[$n]) = "-v" Then
				If Not $varexp Then $varexp = 1
				$p = $n + 1
				If $dbg Then writeLogLine("Environment variable expansion enabled")
			EndIf
			If $CmdLine[$n] = "-?" Then
				$p = $n + 1
				$help = 1
				If $dbg Then writeLogLine("Helpmode enabled")
			EndIf
		EndIf
		$n += 1
	WEnd
	If $win = "" And $p <= $CmdLine[0] Then
		$win = $CmdLine[$p]
		$p += 1
	EndIf
#endregion
	;MsgBox(0,"Debug","Help : " & $help & " cmd: " & $CmdLine[0])
	If ($win = "" And $xfile = "") Or $help > 0 Then
		ShowHelp()
	Else
		$w = activateWindowExe($win, $xfile, $xpara)

		; Still not found?
		If $w = 0 Then
			If $dbg Then writeLogLine("Window '" & $win & "' not found.")
			If $dbg Then MsgBox(32, "WinSendKeys Debug", "Window '" & $win & "' not found.")
		Else
			If $dbg Then writeLogLine("Window '" & $win & "' activated.")
			If $cmode Then ; Optionally handle Clipboard, parse contents
				$clp = ClipGet()
				$cerror = @error
				If $cerror > 0 Then
					If $dbg Then writeLogLine("Error: " & $cerror & " reading Clipboard, content: '" & $clp & "'.")
				Else
					$carr = StringSplit($clp, @CRLF, 1) ; Assume text with possible newlines
					If $dbg Then writeLogLine("Clipboard: parsed: '" & $clp & "' no. of lines: " & $carr[0])
				EndIf
			EndIf
			; Start processing data
			SendKeepActive($w)
#region Strokes from the commandline
			; First: Handle commandline strokes
			For $n = $p To $CmdLine[0]
				handleCommand($CmdLine[$n])
				If $n < $CmdLine[0] Then Sleep($dela) ; Don't wait after the last stroke
			Next
#endregion
#region Strokes File handling
			If $fmode Then ; Optionally handle strokefile
				If FileExists($fname) Then
					Local $fhandle = FileOpen($fname, 0), $winerror = 0, $hnd, $docmd, $skipuntilgoto = False, $gotolabel = "", $label, $lineread = False, $currentline
					Local $params = ""
					Dim $gosubstack[1][2] = [[0, ""]]
					If $fhandle = -1 Then
						If $dbg Then writeLogLine("Error: Cannot open file '" & $fname & "'")
						MsgBox(32, "WinSendKeys Debug", "Error: Cannot open file '" & $fname & "'")
					Else
						$err = 0 ; Initialize
						$currentline = 0
						While $err = 0
							If $lineread Then
								$lineread = False ; We read the line somewhere else already
							Else
								$cmd = FileReadLine($fhandle)
								$currentline += 1
							EndIf
							$err = @error ; get correct status
							If StringLeft($cmd, 1) <> ";" And Not StringIsSpace($cmd) Then ; Only non-comment and non-empty lines
								$hnd = False
								If Not $skipuntilgoto And StringLeft($cmd, 8) = "--window" Then ; Switch window: --window <windowname>
									$win = StringTrimLeft($cmd, 9)
									If $dbg Then writeLogLine("--window " & $win)
									$w = activateWindowExe($win)
									If $w <> 0 Then
										SendKeepActive($w)
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 9) = "--winwait" Then ; Wait for window and switch: --winwait <windowname> [maxwaitsec]
									Local $x, $stuff, $stuffadd, $maxtime, $waittime
									$win = StringTrimLeft($cmd, 10)
									$maxtime = 0
									If StringLeft($win, 1) = """" Then
										$stuffadd = """ "
										$stuff = StringSplit(StringMid($win, 2), $stuffadd, 1) ; split at space after quote after removing the first quote
									Else
										$stuffadd = " "
										$stuff = StringSplit($win, $stuffadd, 1) ; split at first space
									EndIf
									If $stuff[0] > 1 Then
										$win = $stuff[1]
										For $x = 2 To $stuff[0] - 1
											$win &= $stuffadd & $stuff[$x]
										Next
										$maxtime = $stuff[$stuff[0]]
										If $maxtime = 0 Then $maxtime = 0
									EndIf
									If StringLeft($win, 1) = """" Then $win = StringStripWS(StringMid($win, 2, StringLen($win) - 2), 3) ; Remove quotes
									If $dbg Then writeLogLine("--winwait " & $win & " maxwait: " & $maxtime)
									$w = 0
									$waittime = $maxtime * 10 ; Speed up checking for closed window
									While $w = 0 And $waittime >= 0
										$w = testWindowExe($win)
										If $w <> 0 Then
											SendKeepActive($w)
											If $waittime > 0 Then $waittime /= 10 ; Correction for reporting after speedup
											If $dbg Then writeLogLine("--winwait " & $win & " waited: " & $maxtime - $waittime)
										Else
											If $maxtime > 0 Then $waittime -= 1 ; Decrease only if the timeout is set
											If $waittime >= 0 Then
												Sleep(100) ; wait 1/10 second
											EndIf
										EndIf
									WEnd
									If $maxtime > 0 And $waittime < 0 Then
										$winerror = 1
										$w = -1 ; Avoid an error message on 0 handle
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 10) = "--winclose" Then ; Wait for window to close, then continue: --winclose <windowname> [maxwaitsec]
									Local $x, $stuff, $stuffadd, $maxtime, $waittime
									$win = StringTrimLeft($cmd, 11)
									$maxtime = 0
									If StringLeft($win, 1) = """" Then
										$stuffadd = """ "
										$stuff = StringSplit(StringMid($win, 2), $stuffadd, 1) ; split at space after quote after removing the first quote
									Else
										$stuffadd = " "
										$stuff = StringSplit($win, $stuffadd, 1) ; split at first space
									EndIf
									If $stuff[0] > 1 Then
										$win = $stuff[1]
										For $x = 2 To $stuff[0] - 1
											$win &= $stuffadd & $stuff[$x]
										Next
										$maxtime = $stuff[$stuff[0]]
										If $maxtime = 0 Then $maxtime = 0
									EndIf
									If StringLeft($win, 1) = """" Then $win = StringStripWS(StringMid($win, 2, StringLen($win) - 2), 3) ; Remove quotes
									If $dbg Then writeLogLine("--winclose " & $win & " maxwait: " & $maxtime)
									$w = -1
									$waittime = $maxtime * 10 ; Speed up checking for closed window
									While $w <> 0 And $waittime >= 0
										$w = testWindowExe($win)
										If $w <> 0 Then
											If $maxtime > 0 Then $waittime -= 1 ; Decrease only if the timeout is set
											If $waittime >= 0 Then
												Sleep(100) ; wait 1/10 second
											EndIf
										Else
											If $waittime > 0 Then $waittime /= 10 ; Correction for reporting after speedup
											If $dbg Then writeLogLine("--winclose " & $win & " waited: " & $maxtime - $waittime)
										EndIf
									WEnd
									If $maxtime > 0 And $waittime < 0 Then $winerror = 1
									$w = -1 ; Avoid an error message on 0 handle
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 7) = "--error" Then ; Error handler, to be used after --winwait or --winclose, triggers if the timeout is reached
									$docmd = StringTrimLeft($cmd, 8)
									If $dbg Then writeLogLine("--error " & $docmd & ", state = " & $winerror)
									If $winerror <> 0 Then
										If StringCompare($docmd, "quit") = 0 Then ; Quit on error
											$err = 1 ;
										EndIf
										If StringCompare(StringLeft($docmd, 4), "goto") = 0 Then
											$gotolabel = StringTrimLeft($docmd, 5)
											$skipuntilgoto = True
											$currentline = 1
											$cmd = FileReadLine($fhandle, $currentline) ; Read first line of script to rewind file
											$lineread = True ; Avoid skip of first line
										EndIf
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 6) = "--goto" Then ; goto <Label>
									$gotolabel = StringTrimLeft($cmd, 7)
									If $gotolabel <> "" Then
										$skipuntilgoto = True
										$currentline = 1
										$cmd = FileReadLine($fhandle, $currentline) ; Read first line of script to rewind file
										$lineread = True ; Avoid skip of first line
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 7) = "--gosub" Then ; gosub <Label> <extra text as parameter>
									$gotolabel = StringStripWS(StringTrimLeft($cmd, 8), 1)
									If $gotolabel <> "" Then
										If StringInStr($gotolabel, " ") > 0 Then
											$params = StringTrimLeft($gotolabel, StringInStr($gotolabel, " "))
											$gotolabel = StringStripWS(StringLeft($gotolabel, StringInStr($gotolabel, " ")), 3)
										Else
											$params = ""
										EndIf
										$gosubstack[0][0] += 1
										ReDim $gosubstack[$gosubstack[0][0] + 1][2]
										$gosubstack[$gosubstack[0][0]][0] = $currentline + 1 ; Return to the _next_ line in the script
										$gosubstack[$gosubstack[0][0]][1] = $params
										$skipuntilgoto = True
										$currentline = 1
										$cmd = FileReadLine($fhandle, $currentline) ; Read first line of script to rewind file
										$lineread = True ; Avoid skip of first line
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 8) = "--return" Then ; return (to where we gosubbed from)
									If $gosubstack[0][0] > 0 Then
										$currentline = $gosubstack[$gosubstack[0][0]][0]
										$gosubstack[0][0] -= 1
										ReDim $gosubstack[$gosubstack[0][0] + 1][2]
										$cmd = FileReadLine($fhandle, $currentline) ; Read correct line of script
										$lineread = True ; Avoid skip of this line
										If $gosubstack[0][0] > 0 Then
											$params = $gosubstack[$gosubstack[0][0]][1] ; restore last parameters
										Else
											$params = "" ; Clean up the last parameters
										EndIf
									EndIf
									$hnd = True
								EndIf
								If StringLeft($cmd, 3) = "--:" Then ; Label definition
									If $skipuntilgoto Then
										$label = StringTrimLeft($cmd, 3)
										If $dbg Then writeLogLine("<label> --:" & $label & ", goto = " & $gotolabel)
										If StringCompare($label, $gotolabel) = 0 Then
											$skipuntilgoto = False
											$gotolabel = ""
										EndIf
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 6) = "--exec" Then ; Switch / start exe: --exec exename or --exec "exe"_"parameters"
									AutoItSetOption("ExpandEnvStrings", 1) ; Allow for environment variables to be expanded
									AutoItSetOption("ExpandVarStrings", 1) ; Replace @ and $ enclosed variables
									$cmd = StringTrimLeft($cmd, 7)
									AutoItSetOption("ExpandVarStrings", 0) ; Restore setting
									AutoItSetOption("ExpandEnvStrings", 0) ; Restore setting
									If $dbg Then writeLogLine("--exec " & $cmd)
									If StringInStr($cmd, """_""") Then ; exe with parameters required quoted and separated by "_"
										Dim $xp[1]
										$xp = StringSplit($cmd, """_""", 1)
										$xfile = StringMid($xp[1], 2)
										$xpara = StringLeft($xp[2], StringLen($xp[2]) - 1)
									Else
										$xpara = ""
										$xfile = $cmd
									EndIf
									$w = activateWindowExe("", $xfile, $xpara)
									If $w <> 0 Then
										SendKeepActive($w)
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 7) = "--delay" Then ; Sleep for some milliseconds --delay <milliseconds>
									Local $del = Int(StringTrimLeft($cmd, 8))
									If $dbg Then writeLogLine("--delay " & $del & " applied")
									If $del > 0 Then Sleep($del)
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 6) = "--quit" Then ; exit the script immediately, no questions asked
									$err = 1
									$hnd = True
								EndIf
								If Not $skipuntilgoto And StringLeft($cmd, 5) = "--msg" Then ; msg [timeout,]message text
									AutoItSetOption("ExpandEnvStrings", 1) ; Allow for environment variables to be expanded
									AutoItSetOption("ExpandVarStrings", 1) ; Replace @ and $ enclosed variables
									Local $msg = StringTrimLeft($cmd, 6), $msgres
									AutoItSetOption("ExpandVarStrings", 0) ; Restore setting
									AutoItSetOption("ExpandEnvStrings", 0) ; Restore setting
									If $msg <> "" Then
										Local $timemsg = 0
										If StringInStr($msg, ",") > 0 Then
											Local $msgsplit = StringSplit($msg, ",")
											If Int($msgsplit[1]) > 0 Then
												$timemsg = Int($msgsplit[1])
												$msg = StringTrimLeft($msg, StringInStr($msg, ","))
											EndIf
										EndIf
										$msgres = MsgBox(0, "WinSendKeys", $msg, $timemsg)
										If $msgres = -1 Then $winerror = 3
									EndIf
									$hnd = True
								EndIf
								If Not $skipuntilgoto And $hnd Then
									If $w = 0 Then
										If $dbg Then writeLogLine("Window '" & $win & "' not found.")
										If $dbg Then MsgBox(32, "WinSendKeys Debug", "Window '" & $win & "' not found.")
										$err = 1 ; bail out !
									EndIf
								EndIf
								If Not $skipuntilgoto And Not $hnd Then ; Not handled so send the keystrokes
									handleCommand($cmd)
									If $err = 0 Then Sleep($dela) ; Don't wait after the last stroke
								EndIf
							EndIf
						WEnd
						FileClose($fhandle)
					EndIf
				Else
					If $dbg Then writeLogLine("Error: File '" & $fname & "' not found.")
					MsgBox(32, "WinSendKeys Debug", "Error: File '" & $fname & "' not found.")
				EndIf
			EndIf
#endregion
#region Clipboard handling
			If $cmode = 1 Then ; Optionally handle Clipboard
				If $dbg Then writeLogLine("Clipboard: send all content, no. of lines: " & $carr[0])
				For $i = 1 To $carr[0]
					If $carr[$i] <> "" Or $i < $carr[0] Then
						handleCommand($carr[$i])
						If $cemode Then handleCommand("{ENTER}")
						If $i < $carr[0] Then Sleep($dela) ; Don't wait after the last stroke
					EndIf
				Next
			EndIf
#endregion
		EndIf
	EndIf
EndIf
#endregion

;------------------------activateWindowExe()
; $win = WindowName
; $xfile = executablefilename
; $xpara = parameters for executable
Func activateWindowExe($pwin, $xfile = "", $xpara = "")
	Local $w, $n, $p, $xname, $xd
	Dim $xparts[1], $procs[1]
	$win = $pwin
	$w = 0
	$xname = ""
	If $xfile = "" And StringInStr($win, ".") > 0 Then
		$xfile = $win
		$win = ""
	EndIf
	; Split executablefilepath to destill the filename
	If $xfile <> "" Then
		$xd = ""
		$xparts = _PathSplit($xfile, $xd, $xd, $xd, $xd)
		$xname = $xparts[3] & $xparts[4]
		If $dbg Then writeLogLine("exename: " & $xname)
		If $win = "" Then
			$procs = ProcessList()
			$n = 1
			While $n <= $procs[0][0]
				If StringCompare($xname, $procs[$n][0]) = 0 Then
					$win = PidToWindowName($procs[$n][1], $w)
					$n = $procs[0][0]
				EndIf
				$n += 1
			WEnd
			If $win = "" Then $win = $xname
			$xname = ""
		EndIf
	EndIf
	If $dbg Then writeLogLine("Window: " & $win)
	AutoItSetOption("WinTitleMatchMode", -2) ; Not casesensitive
	; Try to find the named window
	If StringIsDigit($win) Then $win = HWnd($win) ; Convert to Windows Handle if numeric
	$w = WinActivate($win, "")
	If $w = 0 And $xname <> "" Then
		$win = $xname
		$xname = ""
		If StringIsDigit($win) Then $win = HWnd($win) ; Convert to Windows Handle if numeric
		$w = WinActivate($win, "")
	EndIf
	If $dbg Then writeLogLine("Windowhandle: " & $w)
	; Optionally start the named exe if window not found
	If $w = 0 And $xfile <> "" Then
		If $dbg Then writeLogLine("Running executable: " & $xfile & " " & $xpara)
		$p = Run($xfile & " " & $xpara, "")
		Sleep($dela) ; A little delay after loading
		If $xdela > 0 Then Sleep($xdela) ; Optional some more delay
		If $dbg Then writeLogLine("Running executable PID: " & $p)
		If $p <> 0 Then
			$win = PidToWindowName($p, $w)
		EndIf
	EndIf
	Return $w
EndFunc ;==>activateWindowExe

;------------------------testWindowExe()
; $pwin = WindowName
; $xfile = executablefilename, if $pwin contains a period and $xfile is empty then they are swapped, and an exe file is searched first
Func testWindowExe($pwin, $xfile = "")
	Local $w, $n, $p, $xname, $xd, $win
	Dim $xparts[1], $procs[1]
	$win = $pwin
	$w = 0
	$xname = ""
	If $xfile = "" And StringInStr($win, ".") > 0 Then
		$xfile = $win
		$win = ""
	EndIf
	; Split executable filepath to destill the filename
	If $xfile <> "" Then
		$xd = ""
		$xparts = _PathSplit($xfile, $xd, $xd, $xd, $xd)
		$xname = $xparts[3] & $xparts[4]
		If $dbg Then writeLogLine("test exename: " & $xname)
		If $win = "" Then
			$procs = ProcessList()
			$n = 1
			While $n <= $procs[0][0]
		;If $dbg Then writeLogLine("compare exename: " & $xname & " / "& $procs[$n][0])
				If StringCompare($xname, $procs[$n][0]) = 0 Then
					$win = PidToWindowName($procs[$n][1], $w)
					$n = $procs[0][0]
				EndIf
				$n += 1
			WEnd
			If $win = "" Then $win = $xname
			$xname = ""
		EndIf
	EndIf
	If $dbg Then writeLogLine("Window: " & $win)
	AutoItSetOption("WinTitleMatchMode", -2) ; Not casesensitive
	; Try to find the named window
	If StringIsDigit($win) Then $win = HWnd($win) ; Convert to Windows Handle if numeric
	$w = WinActivate($win, "")
	If $w = 0 And $xname <> "" Then
		$win = $xname
		$xname = ""
		If StringIsDigit($win) Then $win = HWnd($win) ; Convert to Windows Handle if numeric
		$w = WinActive($win, "") ; Check if the window is Active!
	EndIf
	If $dbg Then writeLogLine("Windowhandle: " & $w)
	Return $w
EndFunc ;==>testWindowExe

;-----------------------
; handleCommand()
; Parses a single KeyStroke or MouseStroke command and executes it when correct, also handles $cmode 2 (-cc option)
;-----------------------
Func handleCommand($cmd)
	Local $handled = 0
	Local $mousepar
	Local $res = 0
	If $canmouse And (StringLeft($cmd, 2) = "##" Or StringLeft($cmd, 2) = "#%") Then
		If $dbg Then writeLogLine("MouseMode: " & $cmd)
		$mousepar = StringSplit(StringMid($cmd, 3), ",")
		; ControlClick handling takes 3 to 7 parameters
		If StringLeft($cmd, 2) = "##" And $mousepar[0] > 2 Then
			AutoItSetOption("MouseCoordMode", 2) ; Control-relative mode
			If $mousepar[0] < 4 Then
				ReDim $mousepar[5]
				$mousepar[0] = 4
			EndIf
			If $mousepar[1] = "" Or $mousepar[1] = '""' Then $mousepar[1] = $win
			If StringIsDigit($mousepar[3]) Then $mousepar[3] = "[ID:" & $mousepar[3] & "]"
			If $mousepar[4] = "" Or $mousepar[4] = '""' Then $mousepar[4] = "primary"
			If $mousepar[0] > 4 And $mousepar[5] = 0 Then $mousepar[5] = 1
			If $dbg Then
				$msg = "ControlClick: " & $mousepar[0] & " : "
				For $i = 1 To $mousepar[0]
					$msg = $msg & $mousepar[$i]
					If $i < $mousepar[0] Then $msg = $msg & ","
				Next
				writeLogLine($msg)
			EndIf
			$res = -1
			$ctrlpos = ControlGetPos($mousepar[1], $mousepar[2], $mousepar[3])
			Switch $mousepar[0]
				Case 4
					If @error = 0 Then MouseMove($ctrlpos[2] / 2, $ctrlpos[3] / 2, $mspeed)
					$res = ControlClick($mousepar[1], $mousepar[2], $mousepar[3], $mousepar[4])
				Case 5
					If @error = 0 Then MouseMove($ctrlpos[2] / 2, $ctrlpos[3] / 2, $mspeed)
					$res = ControlClick($mousepar[1], $mousepar[2], $mousepar[3], $mousepar[4], $mousepar[5])
				Case 6
					If @error = 0 Then MouseMove($mousepar[6], $ctrlpos[3] / 2, $mspeed)
					$res = ControlClick($mousepar[1], $mousepar[2], $mousepar[3], $mousepar[4], $mousepar[5], $mousepar[6])
				Case 7
					MouseMove($mousepar[6], $mousepar[7], $mspeed)
					$res = ControlClick($mousepar[1], $mousepar[2], $mousepar[3], $mousepar[4], $mousepar[5], $mousepar[6], $mousepar[7])
			EndSwitch
			If $dbg Then writeLogLine("ControlClick done, result: " & $res)
			$handled = 1
		EndIf
		; MouseClick handling, takes 3 to 5 parameters
		If StringLeft($cmd, 2) = "#%" And $mousepar[0] > 2 Then
			AutoItSetOption("MouseCoordMode", 0) ; Window-relative mode
			If $mousepar[1] = "" Or $mousepar[1] = '""' Then $mousepar[1] = "primary"
			If $mousepar[0] >= 5 And $mousepar[5] = "" Then $mousepar[5] = $mspeed
			If $dbg Then
				$msg = "MouseClick: " & $mousepar[0] & " : "
				For $i = 1 To $mousepar[0]
					$msg = $msg & $mousepar[$i]
					If $i < $mousepar[0] Then $msg = $msg & ","
				Next
				writeLogLine($msg)
			EndIf
			$res = -1
			Switch $mousepar[0]
				Case 3
					$res = MouseClick($mousepar[1], $mousepar[2], $mousepar[3], 1, $mspeed)
				Case 4
					$res = MouseClick($mousepar[1], $mousepar[2], $mousepar[3], $mousepar[4], $mspeed)
				Case 5
					$res = MouseClick($mousepar[1], $mousepar[2], $mousepar[3], $mousepar[4], $mousepar[5])
			EndSwitch
			If $dbg Then writeLogLine("MouseClick done, result: " & $res)
			$handled = 1
		EndIf
	EndIf
	; Clipboard mode -cc handling
	If $cmode = 2 And StringLeft($cmd, 2) = "#$" And $cline <= $carr[0] And $carr[0] > 0 Then
		$clpc = StringMid($cmd, 3)
		If $dbg Then writeLogLine("Clipboard command: " & $clpc & " cline: " & $cline)
		If $clpc = "*" Then ; Send all
			For $cline = 1 To $carr[0]
				$cmd = $carr[$cline]
				If $cemode Then $cmd = $cmd & "{ENTER}"
				If $dbg Then writeLogLine("Send clip: " & $cmd)
				Send($cmd)
				If $cline < $carr[0] Then Sleep($dela)
			Next
		Else
			If $clpc = 0 Then ; Auto-increment, next line, stop at end
				$cline += 1
			Else
				If $clpc <= $carr[0] Then ; Select a clipboard line
					$cline = $clpc
				Else
					$cline = -1
				EndIf
			EndIf
			If $cline > 0 And $cline <= $carr[0] Then
				$cmd = $carr[$cline]
				If $cemode Then $cmd = $cmd & "{ENTER}"
				If $dbg Then writeLogLine("Send a clip: " & $cmd)
				Send($cmd)
			Else
				If $cline = -1 Then $cline = 0 ; Reset after error
			EndIf
		EndIf
		$handled = 1
	EndIf
	; If not handled yet, send as keystrokes
	If Not $handled Then
		If $varexp Then ; Explode variables
			AutoItSetOption("ExpandEnvStrings", 1) ; Allow for environment variables to be expanded
			AutoItSetOption("ExpandVarStrings", 1) ; Replace @ and $ enclosed variables
			Local $tmp = $cmd
			AutoItSetOption("ExpandVarStrings", 0) ; Restore setting
			AutoItSetOption("ExpandEnvStrings", 0) ; Restore setting
			$cmd = $tmp
		EndIf
		If $dbg Then writeLogLine("rSend: " & $cmd)
		Send($cmd)
	EndIf

EndFunc   ;==>handleCommand

;--------------------------
; PidToWindowName($pid, ByRef $winhandle)
; Find a WindowName and WindowHandle (hWND) by it's PID
;--------------------------
Func PidToWindowName($pid, ByRef $winhandle)
	Local $procs = WinList()
	Local $n = 1
	Local $winname = ""
	$winhandle = 0
	While $n <= $procs[0][0]
		If $procs[$n][0] <> "" And WinGetProcess($procs[$n][0]) = $pid Then
			$winname = $procs[$n][0]
			$winhandle = $procs[$n][1]
			If $dbg Then writeLogLine("Title for PID: " & WinGetProcess($procs[$n][0]) & " hWND: " & $winhandle & " / " & $winname)
			$n = $procs[0][0] ; Exit loop if found
		EndIf
		$n += 1
	WEnd
	Return $winname
EndFunc   ;==>PidToWindowName

;--------------------------
; showHelp()
; Display a messagebox with some help text
;--------------------------
Func ShowHelp()
	MsgBox(0, "WinSendKeys " & $appVersion & " : Send keystrokes and/or mouse-clicks to a window", _
			"WinSendKeys [-t delay] [-d] [-m|-mm speed] [-f strokefile] [-c] [-cc] [-cn]" & @CRLF _
			 & @TAB & "[-x executable_filepath] [-xp executable_parameters] [-xd delay] [-v]" & @CRLF _
			 & @TAB & "[-?] [-w] <WindowName> [<KeyStrokes/MouseStrokes>] [...]" & @CRLF _
			 & "Options:" & @CRLF _
			 & "-t delay = msec value, default 100" & @CRLF _
			 & "-d = Debug mode, writes extra information to WinSendKeys.log" & @CRLF _
			 & "-m = mouse-mode, speed = 0 = immediate" & @CRLF _
			 & "-mm  speed = mouse-mode, move mouse with speed 0..100" & @CRLF _
			 & "-f strokefile = read strokes from strokefile, commandline strokes go first!" & @CRLF _
			 & @TAB & "multi-window possible, see the readme" & @CRLF _
			 & "-c = ClipStrokes mode, send strokes line by line from clipboard + {ENTER}" & @CRLF _
			 & "-cc = ClipStroke 2 mode, commandline ClipStroke #$[*|<n>] + {ENTER}" & @CRLF _
			 & "-cn = Disable {ENTER} after -c or -cc ClipStrokes" & @CRLF _
			 & "-x executable_filepath = Run this if WindowName not found" & @CRLF _
			 & "-xp executable_parameters = Parameters to pass to executable_filepath" & @CRLF _
			 & "-xd delay = Wait for delay msec before passing strokes after running -x" & @CRLF _
			 & "-v = Enable %environment.var% and @macro@ expansion on keystrokes" & @CRLF _
			 & "-? = Display this help message" & @CRLF _
			 & "-w <WindowName> = name value as defined here:" & @CRLF _
			 & @TAB & "www.autoitscript.com/autoit3/docs/intro/windowsadvanced.htm" & @CRLF _
			 & "<KeyStrokes> = Keystroke values as defined here:" & @CRLF _
			 & @TAB & "www.autoitscript.com/autoit3/docs/appendix/SendKeys.htm" & @CRLF _
			 & "<MouseStrokes> = comma-separated list prefixed with:" & @CRLF _
			 & @TAB & "## for ControlClick params, doc:" & @CRLF _
			 & @TAB & "www.autoitscript.com/autoit3/docs/functions/ControlClick.htm" & @CRLF _
			 & @TAB & "#% for MouseClick params, doc:" & @CRLF _
			 & @TAB & "www.autoitscript.com/autoit3/docs/functions/MouseClick.htm" & @CRLF _
			)
EndFunc   ;==>ShowHelp

;--------------------------
; writeLogLine($message)
; Write $message to the logfile, prepended with date/time
;--------------------------
Func writeLogLine($message)
	; Write a line to the logfile, with a prefix of "yyyy-MM-dd hh:mm:ss.msec, ", as the generic _FileWriteLog function gave errors
	Local $openLogFile = FileOpen($dbgfile, 1)
	If $openLogFile > -1 Then
		FileWriteLine($openLogFile, @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & "." & StringFormat("%03d", @MSEC) & ", " & $message)
		FileClose($openLogFile)
	EndIf
EndFunc   ;==>writeLogLine

;--------------------------
; readIniFile()
; Get parameters from .ini file with the same name as this script/exe, only if the file exists!
; Sectionname: [Settings]
; Variables:
; delay : delay between keystrokes/mousestrokes sent to the application, default = 100
; mousestrokes : Enable mousestrokes by setting this to 1, default = 0 = off
; mousespeed : Speedfactor for mouse move, value between 0 (default) and 100, 0 = immediate, 1 = fast, 100 = slow
;--------------------------
Func readIniFile()
	Local $ini = StringReplace(@ScriptName, ".au3", ".ini")
	If $ini = @ScriptName Then
		$ini = StringReplace(@ScriptName, ".exe", ".ini")
		If $ini = @ScriptName Then $ini = "" ; Safety first
	EndIf
	If $ini <> "" And FileExists($ini) Then
		; $dela = 100 ; msec delay between keystrokes sent
		$dela = IniRead($ini, "Settings", "delay", $dela)
		If $dbg And $dela <> 100 Then writeLogLine("Keystroke send delay from ini: " & $dela & @CRLF)
		; $canmouse = 0 ; Enable mouse actions
		$canmouse = Int(IniRead($ini, "Settings", "mousestrokes", $canmouse))
		; $mspeed = 0 ; Mouse-speed
		$mspeed = IniRead($ini, "Settings", "mousespeed", $mspeed)
		If $mspeed < 0 Or $mspeed > 100 Then $mspeed = 0
		If $canmouse And $dbg Then writeLogLine("Mousemode enabled from ini, speed: " & $mspeed & @CRLF)
		; $xdela = 0 ; Execute Delay in msec
		$xdela = IniRead($ini, "Settings", "exedelay", $xdela)
		If $xdela > 0 And $dbg Then writeLogLine("Executable Delay from ini: " & $xdela)
		; $varexp = 0 ; Expand environment (%), macro (@) and local AutoIt ($) variables, off by default!
		$varexp = IniRead($ini, "Settings", "expandvariables", $varexp)
		If $varexp And $dbg Then writeLogLine("ExpandVariables enabled from ini")
	EndIf
EndFunc   ;==>readIniFile

; End of script
#include <File.au3>
