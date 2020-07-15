//%attributes = {}
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"div.html"

$file:=File:C1566($path;fk platform path:K87:2)

$dom:=DOM Parse XML source:C719($file.platformPath)

remove_empty_div ($dom)

$html:=""

DOM EXPORT TO VAR:C863($dom;$html)

SET TEXT TO PASTEBOARD:C523($html)

DOM CLOSE XML:C722($dom)
