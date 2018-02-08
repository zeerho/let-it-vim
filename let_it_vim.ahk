; 可以使用正则表达式对标题进行匹配
;SetTitleMatchMode Regex
; 触发 hot string 的结束字符
#Hotstring EndChars `n`t
; 发送模式
SendMode Input
; 提示信息的坐标系
CoordMode, Tooltip, Screen
; 禁止在系统变量中匹配变量
#NoEnv
; 文件编码
FileEncoding, utf-8



;=============================================
; 入口 Main()
;=============================================

;---- 全局变量
global NORMAL := 1 ; 普通模式枚举
global INSERT := 2 ; 插入模式枚举
global SELECT := 3 ; 选择模式枚举
global mode := NORMAL ; 当前模式，初始为普通模式
global double_count := 0 ; 连续键计数
global suc_keys := InitSucKeys() ; 保存连续键映射
global TOOLTIP_X := A_ScreenWidth/2-50 ; ToolTip 的横坐标
global TOOLTIP_Y := A_ScreenHeight/2   ; ToolTip 的纵坐标

Main()



;=============================================
; Include
;=============================================

; core
#Include %A_ScriptDir%\core\main.ahk
; lib
#Include %A_ScriptDir%\lib\class_EasyIni.ahk
; plugin
#Include %A_ScriptDir%\plugin\plugins_include.ahk
