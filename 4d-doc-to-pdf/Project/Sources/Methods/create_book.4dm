//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1;$book)
C_TEXT:C284($2;$template)
C_TEXT:C284($3;$lang)
C_TEXT:C284($0;$html)

$book:=$1
$template:=$2
$lang:=$3

C_OBJECT:C1216($bookFile)
$bookFile:=$book.file

C_COLLECTION:C1488($snippets)
$snippets:=New collection:C1472

If ($bookFile.exists)
	$options:=New object:C1471("xmlOut";True:C214)
	$status:=Tidy ($bookFile.getContent();$options)
	If ($status.status<2)
		
		$html:=Replace string:C233($status.html;"&nbsp;";"&#160;";*)
		$dom:=DOM Parse XML variable:C720($html)
		
		remove_empty_div ($dom)
		parse_href ($dom;$bookFile;$book.base;$lang)
		remove_iframe ($dom)
		
		get_document_title ($dom;$snippets)
		
		$title_paragraph:=get_title_paragraph ($dom)
		If ($title_paragraph#"")
			get_preamble ($title_paragraph;$snippets)
		Else 
			TRACE:C157  //title_paragraph not found!
		End if 
		
		create_chapters ($dom;$book;$snippets;$lang)
		
		DOM CLOSE XML:C722($dom)
	Else 
		TRACE:C157  //Tidy fail
	End if 
End if 

PROCESS 4D TAGS:C816($template;$html;$snippets;$book)

$0:=$html