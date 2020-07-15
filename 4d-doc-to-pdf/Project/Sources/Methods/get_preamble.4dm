//%attributes = {"invisible":true,"preemptive":"capable"}
/*
get the preamble above the chapter list
the preamble is optional
search for div@class=title_paragraph
search for div / input > h4
this is the preamble
*/

C_TEXT:C284($1;$title_paragraph)
C_COLLECTION:C1488($2;$html)
C_TEXT:C284($0;$preamble)

$title_paragraph:=$1
$html:=$2

C_TEXT:C284($stringValue;$nodeHtml)
$input:=DOM Get first child XML element:C723($title_paragraph)
If (OK=1)
	DOM GET XML ELEMENT NAME:C730($input;$stringValue)
	If ($stringValue="input")
		$div:=DOM Get next sibling XML element:C724($input)
		DOM REMOVE XML ELEMENT:C869($input)
		DOM GET XML ELEMENT NAME:C730($div;$stringValue)
		If ($stringValue="table")
			
			  //div / input > table
			
/*
examples:
Previous-Documents.200-5049567.
*/
			
			$node:=$div
			
			deep_copy_node_html ($node;$html)
			
		Else 
			$h4:=DOM Get first child XML element:C723($div)
			If (OK=1)
				DOM GET XML ELEMENT NAME:C730($h4;$stringValue)
				If ($stringValue="h4")
					
					$preamble:=$h4
					
					insert_h4_separator ($html)
					
					  //skip this
					$node:=DOM Get next sibling XML element:C724($div)
					
					deep_copy_node_html ($node;$html)
					
				Else 
					TRACE:C157  //($stringValue="h4")
				End if 
			Else 
				  //no preamble
			End if 
		End if 
	Else 
		TRACE:C157  //($stringValue="input")
	End if 
Else 
	TRACE:C157  //DOM Get first child XML element
End if 

$0:=$preamble