//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$dom)
C_OBJECT:C1216($2;$chapterFile)
C_COLLECTION:C1488($3;$html)

$dom:=$1
$chapterFile:=$2
$html:=$3

C_TEXT:C284($stringValue)
C_TEXT:C284($nodeHtml)

$TitleTitle:=DOM Find XML element by ID:C1010($dom;"TitleTitle")

If (OK=1)
	DOM GET XML ELEMENT NAME:C730($TitleTitle;$stringValue)
	
	Case of 
		: ($stringValue="h3")
			DOM GET XML ELEMENT VALUE:C731($TitleTitle;$stringValue)
			$title:=Replace string:C233($stringValue;"\n";" ";*)
			$div:=DOM Get parent XML element:C923($TitleTitle)
			If (OK=1)
				DOM REMOVE XML ELEMENT:C869($TitleTitle)
				$h3:=DOM Create XML element:C865($div;"h3";"style";"page-break-before:always")
				
				$name:=anchor_name_for_file ($chapterFile)
				
				$a:=DOM Create XML element:C865($h3;"a";"name";$name)
				DOM SET XML ELEMENT VALUE:C868($a;$title)
				DOM EXPORT TO VAR:C863($h3;$nodeHtml)
				DOM REMOVE XML ELEMENT:C869($h3)
				$html.push($nodeHtml)
				
				  //skip these
				$node:=DOM Get next sibling XML element:C724($div)
				$node:=DOM Get next sibling XML element:C724($node)
				
				deep_copy_node_html ($node;$html)
				
			Else 
				TRACE:C157  //DOM Get parent XML element
			End if 
		: ($stringValue="span")
			DOM GET XML ELEMENT VALUE:C731($TitleTitle;$stringValue)
			$title:=Replace string:C233($stringValue;"\n";" ";*)
			$div:=DOM Get parent XML element:C923($TitleTitle)  //h2
			If (OK=1)
				DOM REMOVE XML ELEMENT:C869($TitleTitle)
				$h3:=DOM Create XML element:C865($div;"h3";"style";"page-break-before:always")
				
				$name:=anchor_name_for_file ($chapterFile)
				
				$a:=DOM Create XML element:C865($h3;"a";"name";$name)
				DOM SET XML ELEMENT VALUE:C868($a;$title)
				DOM EXPORT TO VAR:C863($h3;$nodeHtml)
				DOM REMOVE XML ELEMENT:C869($h3)
				$html.push($nodeHtml)
				
				$div:=DOM Get parent XML element:C923($div)  //div
				
				  //skip these
				$node:=DOM Get next sibling XML element:C724($div)  //p
				$node:=DOM Get next sibling XML element:C724($node)  //div
				$node:=DOM Get first child XML element:C723($node)  //input
				$node:=DOM Get next sibling XML element:C724($node)  //div
				$node:=DOM Get next sibling XML element:C724($node)  //div
				
				deep_copy_node_html ($node;$html)
				
			Else 
				TRACE:C157  //DOM Get parent XML element
			End if 
		Else 
			TRACE:C157  //unkown document structure
	End case 
Else 
	TRACE:C157  //DOM Find XML element by ID($dom;"TitleTitle")
End if 