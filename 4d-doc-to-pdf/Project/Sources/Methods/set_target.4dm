//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$targetFolder)
C_TEXT:C284($2;$html;$3;$name)
C_OBJECT:C1216($0;$target)

$targetFolder:=$1
$html:=$2
$name:=$3
$target:=New object:C1471

$targetFolder.create()

C_OBJECT:C1216($folder)
$folder:=$targetFolder.folder($name)
$folder.create()

C_OBJECT:C1216($htmlFile)
$htmlFile:=$folder.file($name+".html")
$htmlFile.setText($html;"utf-8";Document with LF:K24:22)

C_OBJECT:C1216($pdfFile)
$pdfFile:=$folder.file($name+".pdf")
$pdfFile.delete()

$target.html:=$htmlFile
$target.pdf:=$pdfFile
$target.name:=$name

$0:=$target