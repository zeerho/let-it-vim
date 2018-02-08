;=============================================
; Include
;=============================================

; 开机启动
#Include *i %A_ScriptDir%\plugin\global\startup.ahk
; 字符串替换
#Include *i %A_ScriptDir%\plugin\global\substitute_string.ahk
; 快捷启动
#Include    %A_ScriptDir%\plugin\global\quick_run.ahk



;=============================================
; 获取窗口的 ahk_class
;=============================================

<Global_Get_Ahkclass>:
	;WinGetActiveTitle, title
	WinGetClass, outclassid, A ;%title%
	MsgBox %outclassid%
	clipboard = %outclassid%
return



;=============================================
; 模式切换
;=============================================

<Global_To_Normal>:
	mode := NORMAL
	ToolTip, 进入 Normal 模式, TOOLTIP_X, TOOLTIP_Y, 19
	SetTimer, <Cancel_Tooltip>, -2000
return

<Global_To_Insert>:
	mode := INSERT
	ToolTip, 进入 Insert 模式, TOOLTIP_X, TOOLTIP_Y, 19
	SetTimer, <Cancel_Tooltip>, -2000
return

<Global_To_Select>:
	mode := SELECT
	ToolTip, 进入 Select 模式, TOOLTIP_X, TOOLTIP_Y, 19
	SetTimer, <Cancel_Tooltip>, -2000
return




;=============================================
; 单键
;=============================================

<Null>:
return

<Up>:
	Send, {Up}
return

<Down>:
	Send, {Down}
return

<Left>:
	Send, {Left}
return

<Right>:
	Send, {Right}
return

<Home>:
	Send, {Home}
return

<End>:
	Send, {End}
return

<Delete>:
	Send, {Delete}
return

<Delete_All>:
	Send, ^a
	Send, {Delete}
return

<space>:
	Send, {space}
return



;=============================================
; 功能键
;=============================================

<Suspend>:
	Suspend
return

<Reload>:
	Reload
return

<Cancel_Tooltip>:
	ToolTip, , , , 19
return

<Up_With_Shift>:
	Send, +{Up}
return

<Down_With_Shift>:
	Send, +{Down}
return

<Left_With_Shift>:
	Send, +{Left}
return

<Right_With_Shift>:
	Send, +{Right}
return

<New_Line_Forward>:
	Gosub, <Global_To_Insert>
	Send, {End}{Enter}
return

<New_Line_Backward>:
	Gosub, <Global_To_Insert>
	Send, {Home}{Enter}{Up}
return

<Move_To_First_Line>:
	Send, ^{Home}
return

<Move_To_Last_Line>:
	Send, ^{End}
return

<Select_To_Begin>:
	Send, +{Home}
return

<Select_To_End>:
	KeyWait, +
	KeyWait, 4
	Send, +{End}
return

<Insert_To_Begin>:
	Gosub, <Global_To_Insert>
	Send, {Home}
return

<Insert_To_End>:
	Gosub, <Global_To_Insert>
	Send, {End}
return

<Select_A_Line>:
	Send, {Home}
	Send, +{End}
return

<Cut_A_Line>:
	Gosub, <Select_A_Line>
	Send, ^x
return

<Copy_A_Line>:
	Gosub, <Select_A_Line>
	Send, ^c
return

<Delete_A_Line>:
	Gosub, <Select_A_Line>
	Gosub, <Delete>
return

<Next_Tab>:
	Send, ^{Tab}
return

<Prev_Tab>:
	Send, ^+{Tab}
return

<Mouse_Move_Up>:
	MouseMove, 0, -15, 0, R
return

<Mouse_Move_Down>:
	MouseMove, 0, 15, 0, R
return

<Mouse_Move_Left>:
	MouseMove, -20, 0, 0, R
return

<Mouse_Move_Right>:
	MouseMove, 20, 0, 0, R
return



;=============================================
; 以单例方式打开软件
;=============================================

/**
 * 若未打开，则打开；若已打开，则激活窗口。
 */
GetProgramInstance(label)
{
	path := quickRunMap[label]
	If !RegExMatch(label, "i)<Run_(.*?)>", _class)
	{
		Msgbox, 打开程序失败，指定标签不符合命名规范！%label%
		return
	}
	DetectHiddenWindows, on
	IfWinExist, ahk_class %_class1%
	{
		WinGet, isActive, MinMax, ahk_class %_class1%
        if isActive = -1
            Winactivate, ahk_class %_class1%
        else
        {
            Ifwinnotactive, ahk_class %_class1%
                Winactivate, ahk_class %_class1%
            else
                Winminimize, ahk_class %_class1%
        }
	}
	else
	{
		Run %path%
	}
	DetectHiddenWindows, off
}




;=============================================
; 连续键
;=============================================

<SuccessiveKey>:
	SuccessiveKey()
return

SuccessiveKey()
{
	static lastKey
	local thisKey := A_ThisHotKey
	if double_count = 0
	{
		double_count += 1
		lastKey := thisKey
		SetTimer, <WaitNextKey>, -500
	}
	else if double_count = 1
	{
		lastKey .= thisKey
		if suc_keys[lastKey]
		{
			double_count := 0
			Gosub, % suc_keys[lastKey]
		}
	}
	else
		return
}

<WaitNextKey>:
	double_count := 0
return
