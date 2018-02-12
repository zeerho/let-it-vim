;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 脚本自身快捷键
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
>^p::Suspend
>^r::Reload

#IfWinActive ahk_class D3 Main Window Class
~RButton::
SendInput 2
SendInput 4
return
~LButton & ~RButton::
SendInput 2
SendInput 4
return
shift & ~RButton::
SendInput 2
SendInput 4
return
#IfWinActive

