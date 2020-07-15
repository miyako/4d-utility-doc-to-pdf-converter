//%attributes = {"invisible":true,"preemptive":"capable"}
/*
the book title is <h1>
*/

C_TEXT:C284($1;$dom)
C_COLLECTION:C1488($2;$html)

$dom:=$1
$html:=$2

C_TEXT:C284($stringValue)
C_TEXT:C284($nodeHtml)

$TitleTitle:=DOM Find XML element by ID:C1010($dom;"TitleTitle")

C_TEXT:C284($stringValue)

If (OK=1)
	DOM GET XML ELEMENT VALUE:C731($TitleTitle;$stringValue)
	$title:=Replace string:C233($stringValue;"\n";" ";*)
	$h1:=DOM Get parent XML element:C923($TitleTitle)
	If (OK=1)
		DOM GET XML ELEMENT NAME:C730($h1;$stringValue)
		If ($stringValue="h1")
			$div:=DOM Get parent XML element:C923($h1)
			DOM REMOVE XML ELEMENT:C869($h1)
			$h1:=DOM Create XML element:C865($div;"h1")
			$span:=DOM Create XML element:C865($h1;"span")
			DOM SET XML ELEMENT VALUE:C868($span;$title)
			DOM EXPORT TO VAR:C863($div;$nodeHtml)
			DOM REMOVE XML ELEMENT:C869($h1)
			$html.push($nodeHtml)
		Else 
			TRACE:C157  //($stringValue="h1")
		End if 
	Else 
		TRACE:C157  //DOM Get parent XML element
	End if 
Else 
	TRACE:C157  //DOM Find XML element by ID($dom;"TitleTitle")
End if 