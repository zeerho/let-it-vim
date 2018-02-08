;=============================================
; 快捷启动
;=============================================

:*://vi::
;GetProgramInstance("Vim", "D:\ProgramPortable\Vim\vim74\gvim.exe")
return

:*://qq::
Run E:\Program Files\Tencent\QQLite\Bin\QQScLauncher.exe
return

:*://np::
Run C:\Program Files (x86)\npp.7.3.3.bin\notepad++.exe
return

:*://yy::
Run E:\Program Files\duowan\yy\YY.exe
return

:*://ch::
Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
return

<Run_dopus.lister>:
	GetProgramInstance(A_ThisLabel)
return

<Run_TTOTAL_CMD>:
	GetProgramInstance(A_ThisLabel)
return