//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$params)
C_TEXT:C284($0;$template)

C_TEXT:C284($lang)

$params:=$1

If ($params.lang#Null:C1517)
	$lang:=$params.lang
End if 

C_OBJECT:C1216($templateFile)
C_TEXT:C284($template)
$templateFile:=File:C1566("/RESOURCES/template."+$lang+".html")
If (Not:C34($templateFile.exists))
	$templateFile:=File:C1566("/RESOURCES/template.en.html")
End if 

ASSERT:C1129($templateFile.exists)

$template:=$templateFile.getText("utf-8";Document with LF:K24:22)

$0:=$template