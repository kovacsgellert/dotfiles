 # Add Hungarian language with 101-key keyboard layout
$LangList = Get-WinUserLanguageList
$hu = New-WinUserLanguageList hu-HU
$hu[0].InputMethodTips.Add("040e:0000040e") # 040e:0000040e is Hungarian 101-key
$LangList.Add($hu[0])
Set-WinUserLanguageList $LangList -Force