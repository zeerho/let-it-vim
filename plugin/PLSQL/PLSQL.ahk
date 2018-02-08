#IfWinActive ahk_class TPLSQLDevForm
;选中单行并执行
^w::
SendInput {Home}
SendInput +{End}{F8}
return
;执行
^e::SendInput {F8}
#IfWinActive
