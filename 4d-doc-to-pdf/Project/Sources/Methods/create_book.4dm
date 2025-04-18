//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $book)
C_TEXT:C284($2; $template)
C_OBJECT:C1216($3; $params)
C_TEXT:C284($0; $html)

$book:=$1
$template:=$2
$params:=$3

$lang:=$params.lang

C_OBJECT:C1216($bookFile)
$bookFile:=$book.file

C_COLLECTION:C1488($snippets)
$snippets:=New collection:C1472

If ($bookFile.exists)
	$options:=New object:C1471("xmlOut"; True:C214)
	C_BLOB:C604($data)
	$data:=$bookFile.getContent()
	$status:=Tidy($data; $options)
	If ($status.status<2)
		
		$html:=Replace string:C233($status.html; "&nbsp;"; "&#160;"; *)
		
		$dom:=DOM Parse XML variable:C720($html)
		
		cajole_nodes($dom; $bookFile; $params)
		
		parse_href($dom; $bookFile; $book.base; $params)
		
		remove_iframe($dom; $bookFile; $params)
		
		get_document_title($dom; $snippets)
		
		$title_paragraph:=get_title_paragraph($dom)
		If ($title_paragraph#"")
			get_preamble($title_paragraph; $snippets)
		Else 
			TRACE:C157  //title_paragraph not found!
		End if 
		
		create_chapters($dom; $book; $snippets; $params)
		
		DOM CLOSE XML:C722($dom)
	Else 
		
		$log:=New object:C1471
		$log.path:=$bookFile.path
		$log.status:=$status
		$params.LOG_PUSH("error_invalid_html"; $log)
		
		TRACE:C157  //Tidy fail
		
	End if 
End if 

PROCESS 4D TAGS:C816($template; $html; $snippets; $book)

$0:=$html