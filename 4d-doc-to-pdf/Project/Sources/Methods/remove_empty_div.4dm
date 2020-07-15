//%attributes = {"invisible":true,"preemptive":"capable"}
/*
when the html contains a void div
e.g.
<div />
wkhtmltopdf could end up in an unended indentation
thie purpose of this function is to remove such divs
literally removing could alter the document structure,
so a namespaced child element is added instead

ehen the html contains a void a
e.g.
<a></a>
the result PDF contains an incorrect hyperlink
*/

C_TEXT:C284($1;$dom)

$dom:=$1

ARRAY TEXT:C222($doms;0)
ARRAY LONGINT:C221($types;0)

DOM GET XML CHILD NODES:C1081($dom;$types;$doms)

C_TEXT:C284($name;$value)

For ($i;1;Size of array:C274($types))
	$type:=$types{$i}
	If ($type=XML ELEMENT:K45:20)
		$dom:=$doms{$i}
		$deleted:=False:C215
		DOM GET XML ELEMENT NAME:C730($dom;$name)
		If ($name="div")
			DOM GET XML ELEMENT VALUE:C731($dom;$value)
			If (Length:C16($value)=0)
				$p:=DOM Create XML element:C865($dom;"xml:p")
				DOM SET XML ELEMENT VALUE:C868($p;Char:C90(0x00A0))
				$deleted:=True:C214
			End if 
		End if 
		
		If ($name="a")
			DOM GET XML ELEMENT VALUE:C731($dom;$value)
			If (Length:C16($value)=0)
				$p:=DOM Create XML element:C865($dom;"xml:a")
				DOM SET XML ELEMENT VALUE:C868($p;Char:C90(0x00A0))
				
				C_OBJECT:C1216($log)
				C_COLLECTION:C1488($col)
				
				$log:=Folder:C1567(fk logs folder:K87:17).file("bad_link_empty_anchor.txt")
				$col:=JSON Parse:C1218($log.getText();Is collection:K8:32)
				$col.push(New object:C1471("file";$file.name;"href";$value))
				$log.setText(JSON Stringify:C1217($col))
				
			End if 
		End if 
		
		If (Not:C34($deleted))
			remove_empty_div ($dom)
		End if 
	End if 
End for 