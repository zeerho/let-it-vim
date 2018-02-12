;=============================================
; 初始化函数
;=============================================

global quickRunMap ; 快速启动列表，key={label}，value={path}
global activeProfile ; 当前激活的环境配置

/**
 * 主入口
 */
Main()
{
	; 读取配置文件
	if (!FileExist("config.ini"))
	{
		Msgbox, 未找到配置文件 config.ini
		return
	}
	ini := class_EasyIni("config.ini")

	; 读取当前所在的环境
	EnvGet, activeProfile, AHK_PROFILE
	if (!activeProfile)
	{
		Msgbox, 未读到环境变量 AHK_PROFILE，将不加载所有环境敏感的配置
	}

	InitQuickRun(ini)
	InitCommons(ini)
}

/**
 * 初始化快速启动的程序
 */
InitQuickRun(ini)
{
	quickRunMap := []
	; 程序的 快捷键、label 和路径
	for key, value in ini.quickRun
	{
		; 格式为 标签|路径
		if !RegExMatch(value, "(.*?)\|(.*)", var)
		{
			continue
		}
		label := var1
		path := var2
		if (!label || !path)
		{
			continue
		}
		; 比如 (profile:home)im_a_key
		if key := FiltByProfile(key)
		{
			HotKey, %key%, %label%
			quickRunMap[label] := path
		}
	}
}

/**
 * 初始化一般性配置
 */
InitCommons(ini)
{
	; 全局按键
	MapHotKeys(ini, "global")

	; 排除的窗口
	for _class in ini.exclude
	{
		GroupAdd, GROUP_EXCLUDE_WINDOWS, ahk_class %_class%
	}

	; 加载插件 TODO
	;InitPlugins(ini)

	; 普通模式
	HotKey, If, IsInMode(NORMAL)
	MapHotKeys(ini, "normal")

	; 插入模式
	HotKey, If, IsInMode(INSERT)
	MapHotKeys(ini, "insert")

	; 选择模式
	HotKey, If, IsInMode(SELECT)
	MapHotKeys(ini, "select")
}

/**
 * 加载插件
 * TODO
 */
InitPlugins(ini)
{
	filePath := A_ScriptDir "\plugin\plugins_include.ahk"
	filePlugInclude := FileOpen(filePath, "rw")
	if !filePlugInclude || !IsObject(filePlugInclude)
	{
		MsgBox, 加载 %filePath% 出错！将自动退出 LetItVim!
	}
	Loop
	{
		cLine := filePlugInclude.ReadLine()
		if !cLine
			break
		;fileName := getFileName(cLine)
	}
	for key, val in ini.plugins
	{

	}
}

/**
 * 映射热键
 */
MapHotKeys(ini, sectionName)
{
	section := ini[sectionName]
	if !section
	{
		Msgbox, ini 文件中无对应的 section：%sectionName%
		return
	}
	for key, val in section
	{
		if key := FiltByProfile(key)
		{
			HotKey, %key%, %val%, On
		}
	}
}

/**
 * 根据当前环境过滤配置
 *
 * @return 若该条配置指定了 profile，且与当前环境变量中的 AHK_PROFILE 不符，则返回 false；
 *         否则，返回 var 中去除 (profile:blabla) 后的部分
 */
FiltByProfile(var)
{
	if RegExMatch(var, "i)\(profile:(.*?)\)(.*)", p) && activeProfile != p1
	{
		return false
	}
	return p2 ? p2 : var
}

/**
 * 当前是否为指定模式且当前窗口不在排除列表中
 */
IsInMode(targetMode)
{
	return mode = targetMode && !WinActive("ahk_group GROUP_EXCLUDE_WINDOWS")
}

/**
 * @see AutoHotKey.ahm -> HotKey -> If, Expression
 */
#If IsInMode(NORMAL)
#If IsInMode(INSERT)
#If IsInMode(SELECT)
#If

/**
 * 连续键
 */
InitSucKeys()
{
	local k := []
	k["gg"] := "<Move_To_First_Line>"
	k["gn"] := "<NEXT_TAB>"
	k["gp"] := "<PREV_TAB>"
	;k["c$"] := "<Cut_To_End>"
	;k["c^"] := "<Cut_To_Begin>"
	;k["c0"] := "<Cut_To_Begin>"
	k["cc"] := "<Cut_A_Line>"
	k["dd"] := "<Cut_A_Line_And_Delete_EOL>"
	k["yy"] := "<Yank_A_Line>"
	return k
}
