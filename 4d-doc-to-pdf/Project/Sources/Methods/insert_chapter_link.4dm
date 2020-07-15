//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$p;$2;$anchor;$3;$title)
C_COLLECTION:C1488($4;$html)

$p:=$1
$anchor:=$2
$title:=$3
$html:=$4

C_TEXT:C284($nodeHtml)

$p:=DOM Create XML element:C865($p;"p")
$a:=DOM Create XML element:C865($p;"a";"href";$anchor)
DOM SET XML ELEMENT VALUE:C868($a;$title)
DOM EXPORT TO VAR:C863($p;$nodeHtml)
DOM REMOVE XML ELEMENT:C869($p)

$html.push($nodeHtml)