//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$lang)
C_TEXT:C284($0;$template)

$lang:=$1

C_OBJECT:C1216($templateFile)
C_TEXT:C284($template)
$templateFile:=File:C1566("/RESOURCES/template."+$lang+".html")
If ($templateFile.exists)
	$template:=$templateFile.getText("utf-8";Document with LF:K24:22)
End if 

$0:=$template