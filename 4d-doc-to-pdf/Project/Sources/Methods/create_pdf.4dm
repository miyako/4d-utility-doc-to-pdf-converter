//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$target)
C_TEXT:C284($0;$pdfPath)

$target:=$1

C_OBJECT:C1216($htmlFile;$pdfFile)

$htmlFile:=$target.html
$pdfFile:=$target.pdf

C_OBJECT:C1216($options)
$options:=New object:C1471
$options.grayscale:=False:C215
$options.dpi:=96
$options.logLevel:="none"
$options.externalLinks:=True:C214
$options.collate:=False:C215
$options.copies:=1
$options.imageDpi:=300
$options.imageQuality:=100
$options.lowquality:=True:C214
$options.orientation:="Portrait"
$options.marginBottom:="0mm"
$options.marginLeft:="0mm"
$options.marginRight:="0mm"
$options.marginTop:="0mm"
$options.pageSize:="A4"
$options.title:=$target.name
$options.pdfCompression:=False:C215
$options.outline:=True:C214
$options.outlineDepth:=8
$options.background:=True:C214
$options.loadErrorHandling:="skip"  //abort,ignore
$options.loadMediaErrorHandling:="skip"  //abort,ignore
$options.localFileAccess:=True:C214
$options.minimumFontSize:=9

$options.in:=$htmlFile.platformPath
$options.out:=$pdfFile.platformPath

$pdf:=wkhtmltopdf ($options;"";"utf-8")

If ($pdfFile.size#0)
	$pdfPath:=$pdfFile.platformPath
End if 

$0:=$pdfPath