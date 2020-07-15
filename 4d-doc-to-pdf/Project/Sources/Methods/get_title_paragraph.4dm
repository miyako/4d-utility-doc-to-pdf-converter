//%attributes = {"invisible":true,"preemptive":"capable"}
/*
find div@class=title_paragraph
*/

C_TEXT:C284($1;$dom)
C_TEXT:C284($0;$title_paragraph)

$dom:=$1

ARRAY TEXT:C222($doms;0)
ARRAY LONGINT:C221($types;0)
DOM GET XML CHILD NODES:C1081($dom;$types;$doms)

C_TEXT:C284($name;$value)
For ($i;1;Size of array:C274($types))
	$type:=$types{$i}
	If ($type=XML ELEMENT:K45:20)
		$dom:=$doms{$i}
		DOM GET XML ELEMENT NAME:C730($dom;$name)
		If ($name="div")
			For ($ii;1;DOM Count XML attributes:C727($dom))
				DOM GET XML ATTRIBUTE BY INDEX:C729($dom;$ii;$name;$value)
				If ($name="class")
					If ($value="title_paragraph")
						$title_paragraph:=$dom
						$ii:=MAXLONG:K35:2-1
					End if 
				End if 
			End for 
		End if 
		If ($title_paragraph="")
			$title_paragraph:=get_title_paragraph ($dom)
		Else 
			$i:=MAXLONG:K35:2-1  //break
		End if 
	End if 
End for 

$0:=$title_paragraph