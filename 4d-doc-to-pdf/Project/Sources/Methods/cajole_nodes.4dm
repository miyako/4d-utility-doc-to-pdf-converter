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
C_OBJECT:C1216($2;$file;$3;$params)

$dom:=$1
$file:=$2
$params:=$3

ARRAY TEXT:C222($doms;0)
ARRAY LONGINT:C221($types;0)

DOM GET XML CHILD NODES:C1081($dom;$types;$doms)

C_TEXT:C284($nodeHtml)

C_TEXT:C284($name;$value)

For ($i;1;Size of array:C274($types))
	$type:=$types{$i}
	If ($type=XML ELEMENT:K45:20)
		$dom:=$doms{$i}
		DOM GET XML ELEMENT NAME:C730($dom;$name)
		If ($name="div")
			DOM GET XML ELEMENT VALUE:C731($dom;$value)
			If (Length:C16($value)=0)
				
				DOM EXPORT TO VAR:C863($dom;$nodeHtml)
				$p:=DOM Create XML element:C865($dom;"xml:p")
				DOM SET XML ELEMENT VALUE:C868($p;Char:C90(0x00A0))
				
				$log:=New object:C1471
				$log.path:=$file.path
				$log.node:=$nodeHtml
				$params.LOG_PUSH("warning_empty_div";$log)
				
			End if 
		End if 
		
		If ($name="a")
			DOM GET XML ELEMENT VALUE:C731($dom;$value)
			If (Length:C16($value)=0)
				
				DOM EXPORT TO VAR:C863($dom;$nodeHtml)
				
				$p:=DOM Create XML element:C865($dom;"xml:a")
				DOM SET XML ELEMENT VALUE:C868($p;Char:C90(0x00A0))
				
				$log:=New object:C1471
				$log.path:=$file.path
				$log.node:=$nodeHtml
				$params.LOG_PUSH("warning_empty_anchor";$log)
				
			End if 
		End if 
		
		cajole_nodes ($dom;$file;$params)
		
	End if 
End for 