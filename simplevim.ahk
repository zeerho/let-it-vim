; 可以使用正则表达式对标题进行匹配
;SetTitleMatchMode Regex
; 触发 hot string 的结束字符
#Hotstring EndChars `n`t
; 发送模式
SendMode Input
; 提示信息的坐标系
CoordMode, Tooltip, Screen



;=============================================
; 入口 Main()
;=============================================

;---- 全局变量
Global NORMAL := 1 ; 普通模式枚举
Global INSERT := 2 ; 插入模式枚举
Global SELECT := 3 ; 选择模式枚举
Global mode := NORMAL ; 当前模式，初始为普通模式
Global double_count := 0 ; 连续键计数
Global suc_keys := InitSucKeys() ; 保存连续键映射
Global TOOLTIP_X := A_ScreenWidth/2-50 ; ToolTip 的横坐标
Global TOOLTIP_Y := A_ScreenHeight/2   ; ToolTip 的纵坐标
GroupAdd, GROUP_EXCLUDE_WINDOWS, ahk_class Vim
GroupAdd, GROUP_EXCLUDE_WINDOWS, ahk_class PX_WINDOW_CLASS



;=============================================
; Global Keys
;=============================================

;------------------------------
; 作用于 simplevim 本身的快捷键
;------------------------------
>+s::Suspend
>+r::Reload

;------------------------------
; 获取窗口的 ahk_class
;------------------------------
!m::Gosub, <Global_Get_Ahkclass>

;------------------------------
; 普通模式 NORMAL
;------------------------------
#If mode = NORMAL && !WinActive("ahk_group GROUP_EXCLUDE_WINDOWS")
;---- 模式切换
$i::Gosub, <Global_To_Insert>
$v::Gosub, <Global_To_Select>
^[::Gosub, <Global_To_Normal>

;---- 方向键
$j::Gosub, <Down>
$k::Gosub, <Up>
$h::Gosub, <Left>
$l::Gosub, <Right>

;---- 鼠标移动
space & k::MouseMove, 0, -15, 0, R
space & j::MouseMove, 0, 15, 0, R
space & h::MouseMove, -20, 0, 0, R
space & l::MouseMove, 20, 0, 0, R
$space::space

;---- 标签页
g & n::Gosub, <Next_Tab>
g & p::Gosub, <Prev_Tab>
$g::g

;---- 文本操作
; g + ? 连续键
g::SuccessiveKey()

+g::Gosub, <Move_To_Last_Line>
o::Gosub, <New_Line_Forward>
+o::GoSub, <New_Line_Backward>
+i::Gosub, <Insert_To_Begin>
+a::Gosub, <Insert_To_End>
x::Gosub, <Delete>
^::
0::
	Gosub, <Home>
return
$::Gosub, <End>
+v::Gosub, <Select_A_Line>
; y + ? 连续键
y::SuccessiveKey()
; d + ? 连续键
d::SuccessiveKey()
#If

;------------------------------
; 选择模式 SELECT
;------------------------------
#If mode = SELECT && !WinActive("ahk_group GROUP_EXCLUDE_WINDOWS")
;---- 模式切换
^[::Gosub, <Global_To_Normal>
$Esc::Gosub, <Global_To_Normal>

;---- 文本操作
$::Gosub, <Select_To_End> ; 选中当前光标至行尾
; 在 Vim 中 ^ 和 0 是有区别的，但此处尚不知如何实现
^::
0::
	Gosub, <Select_To_Begin> ; 选中当前光标至行首
return
$j::Gosub, <Down_With_Shift>
$k::Gosub, <Up_With_Shift>
$h::Gosub, <Left_With_Shift>
$l::Gosub, <Right_With_Shift>
#If

;------------------------------
; 插入模式 INSERT
;------------------------------
#If mode = INSERT && !WinActive("ahk_group GROUP_EXCLUDE_WINDOWS")
;---- 模式切换
^[::Gosub, <Global_To_Normal>
$Esc::Gosub, <Global_To_Normal>
#If



;=============================================
; Total Commander
;=============================================

#e::GetProgramInstance("TTOTAL_CMD", "D:\ProgramPortable\TotalCMD\Totalcmd64.exe")



;=============================================
; 标签切换和选择项移动
;=============================================
;#IfWinActive ahk_class MozillaWindowClass|Chrome_WidgetWin_1
;^q::SendInput {blind}+{Tab}
;^e::SendInput {blind}{Tab}
;#IfWinActive

;=============================================
; Ditto
;=============================================
#ifWinActive ahk_class QPasteClass
d::SendInput {Delete}
^d::
SendInput ^a
SendInput {Delete}
return
#IfWinActive

;=============================================
; PL/SQL
;=============================================
#IfWinActive ahk_class TPLSQLDevForm
;选中单行并执行
^w::
SendInput {Home}
SendInput +{End}{F8}
return
;执行
^e::SendInput {F8}
#IfWinActive



;=============================================
; Include
;=============================================
; 开机启动
#Include *i %A_ScriptDir%\startup.ahk
; 字符串替换
#Include *i %A_ScriptDir%\substitute_string.ahk
; 快捷启动
#Include *i %A_ScriptDir%\quick_run.ahk
; 功能脚本
#Include %A_ScriptDir%\script.ahk
