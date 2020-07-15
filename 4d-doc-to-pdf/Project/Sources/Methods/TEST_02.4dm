//%attributes = {}
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"body.xml"

$file:=File:C1566($path;fk platform path:K87:2)

$dom:=DOM Parse XML source:C719($file.platformPath)

parse_href ($dom;$file)

DOM CLOSE XML:C722($dom)