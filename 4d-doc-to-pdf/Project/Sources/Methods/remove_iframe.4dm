//%attributes = {"invisible":true,"preemptive":"capable"}
/*
for the design reference, which includes a video
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
		$deleted:=False:C215
		DOM GET XML ELEMENT NAME:C730($dom;$name)
		If ($name="iframe")
			
			DOM EXPORT TO VAR:C863($dom;$nodeHtml)
			
			$parent:=DOM Get parent XML element:C923($dom)
			DOM REMOVE XML ELEMENT:C869($dom)
			$p:=DOM Create XML element:C865($parent;"xml:p")
			DOM SET XML ELEMENT VALUE:C868($p;Char:C90(0x00A0))
			
			$log:=New object:C1471
			$log.path:=$file.path
			$log.node:=$nodeHtml
			$params.LOG_PUSH("warning_iframe";$log)
			
			$deleted:=True:C214
		End if 
		
		If (Not:C34($deleted))
			remove_iframe ($dom;$file;$params)
		End if 
		
	End if 
End for 