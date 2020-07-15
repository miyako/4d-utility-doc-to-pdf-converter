//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$targetFile)
C_TEXT:C284($0;$link)

$targetFile:=$1

$link:=$targetFile.name+"@"+Generate digest:C1147($targetFile.path;SHA1 digest:K66:2)

$0:=$link