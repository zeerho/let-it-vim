#IfWinActive ahk_class D3 Main Window Class

switch := 1 ;1=开，0=关

F1::SetTimer, pressBtns, 300
F2::SetTimer, pressBtns, off
$1:: 
if (switch == 1) {
    switch := 0
    SetTimer, autoTurnOn, -3000 ;3秒跑马结束自动打开开关
} else {
	switch := 1
}
SendInput 1
return

pressBtns:
if (switch == 1) {
	SendInput 2
	SendInput 3
	SendInput 4
	MouseClick, right
	MouseClick, left
}
return

autoTurnOn:
switch := 1
return

#IfWinActive
