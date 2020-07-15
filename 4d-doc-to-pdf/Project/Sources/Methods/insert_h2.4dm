//%attributes = {"invisible":true,"preemptive":"capable"}
/*
the chapter title is <h2>
*/

C_TEXT:C284($1;$TitleTitle)
C_OBJECT:C1216($2;$chapterFile)
C_COLLECTION:C1488($3;$html)

$TitleTitle:=$1
$chapterFile:=$2
$html:=$3

C_TEXT:C284($stringValue)
C_TEXT:C284($nodeHtml)

DOM GET XML ELEMENT NAME:C730($TitleTitle;$stringValue)

$node:=""

Case of 
	: ($stringValue="span")
		$div:=DOM Get parent XML element:C923($TitleTitle)
		If (OK=1)
			DOM GET XML ELEMENT NAME:C730($div;$stringValue)
			If ($stringValue="h2")
				$node:=DOM Get parent XML element:C923($div)
				If (OK=0)
					$node:=""
				End if 
			End if 
		End if 
		
	: ($stringValue="h3")
		
		  //do we really need to check for div like this?
		
		If (False:C215)
			$node:=DOM Get parent XML element:C923($TitleTitle)
			If (OK=0)
				$node:=""
			End if 
		End if 
		
		$node:=$TitleTitle
		
	: ($stringValue="h2")
		$node:=$TitleTitle
	: ($stringValue="h1")
		$node:=$TitleTitle
	Else 
		TRACE:C157  //unknown document structure
End case 

If ($node#"")
	
	DOM GET XML ELEMENT VALUE:C731($TitleTitle;$stringValue)
	$title:=Replace string:C233($stringValue;"\n";" ";*)
	
	$h2:=DOM Create XML element:C865($node;"h2";"style";"page-break-before:always")
	$name:=anchor_name_for_file ($chapterFile)
	
	$a:=DOM Create XML element:C865($h2;"a";"name";$name)
	DOM SET XML ELEMENT VALUE:C868($a;$title)
	DOM EXPORT TO VAR:C863($h2;$nodeHtml)
	DOM REMOVE XML ELEMENT:C869($h2)
	
	$html.push($nodeHtml)
	
End if 