#IfWinActive ahk_class QPasteClass
d::Send, {Delete}
^d::
	Send, ^a
	Send, {Delete}
return
#IfWinActive