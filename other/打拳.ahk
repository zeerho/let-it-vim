#IfWinActive ahk_class D3 Main Window Class

switch := 1 ;1=开，0=关

F1::SetTimer, pressBtns, 300
F2::SetTimer, pressBtns, off

pressBtns:
if (switch == 1) {
	SendInput 2
	;SendInput 3
	SendInput 4
	;MouseClick, right
	MouseClick, left
}
return

#IfWinActive

