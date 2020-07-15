//%attributes = {"invisible":true,"preemptive":"capable"}
/*
deep copy all sibling node html
*/

C_TEXT:C284($1;$dom)
C_COLLECTION:C1488($2;$html)

$dom:=$1
$html:=$2

C_TEXT:C284($nodeHtml)

While (OK=1)
	DOM EXPORT TO VAR:C863($dom;$nodeHtml)
	$html.push($nodeHtml)
	$dom:=DOM Get next sibling XML element:C724($dom)
End while 
