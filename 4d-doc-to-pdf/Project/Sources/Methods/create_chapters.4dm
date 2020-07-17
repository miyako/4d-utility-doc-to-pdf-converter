//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$dom)
C_OBJECT:C1216($2;$book)
C_COLLECTION:C1488($3;$html)
C_OBJECT:C1216($4;$params)

$dom:=$1
$book:=$2
$html:=$3
$params:=$4

C_TEXT:C284($lang)
$lang:=$params.lang

$Chapter_list:=DOM Find XML element by ID:C1010($dom;"Chapter_list")

C_TEXT:C284($stringValue)
C_TEXT:C284($nodeHtml)

$chapterFiles:=New collection:C1472

If (OK=1)
	ARRAY TEXT:C222($paragraphs;0)
	$p:=DOM Find XML element:C864($Chapter_list;"div/p";$paragraphs)
	
	If (Size of array:C274($paragraphs)#0)
		$html.push("<p><br /></p>")
		$html.push("<div id=\"Chapter_list\">")
	End if 
	
	For ($i;1;Size of array:C274($paragraphs))
		
		$p:=$paragraphs{$i}
		$a:=DOM Find XML element:C864($p;"p/a")
		
		If (OK=1)
			
			DOM GET XML ELEMENT VALUE:C731($a;$stringValue)
			$title:=Replace string:C233($stringValue;"\n";" ";*)
			
			DOM GET XML ATTRIBUTE BY NAME:C728($a;"href";$stringValue)
			
			If ($stringValue#"")
				$anchor:=$stringValue
				DOM GET XML ATTRIBUTE BY NAME:C728($a;"xml:href";$stringValue)
				$href:=$stringValue
			Else 
				$anchor:="#"
				$href:=""
			End if 
			
			Case of 
				: ($href="")
					  //link to other document; skip it
				: ($href="@Alphabetical-list-of-commands@")
					  //skip  abc list
				Else 
					C_OBJECT:C1216($chapterFile)
					$chapterFile:=File:C1566($href)
					If ($chapterFile.exists)
						$chapterFiles.push($chapterFile)
					Else 
						TRACE:C157  //chapter file does not exist!
					End if 
					
					insert_chapter_link ($p;$anchor;$title;$html)
					
			End case 
			
		Else 
			TRACE:C157
		End if 
	End for 
	
	$html.push("</div>")
	
	  //now, add pages
	
	For each ($chapterFile;$chapterFiles)
		$options:=New object:C1471("xmlOut";True:C214)
		$status:=Tidy ($chapterFile.getContent();$options)
		If ($status.status<2)
			
/*
use this case block to trace specific source files
*/
			
			Case of 
				: ($chapterFile.name="Introduction.200-4611725.@")
				: ($chapterFile.name="4D-SVG-Constants.202-4611728.@")
				: ($chapterFile.name="Changes-and-updates.200-5049566.@")
				: ($chapterFile.name="Previous-Documents.200-5049567.@")
					
			End case 
			
			$page:=Replace string:C233($status.html;"&nbsp;";"&#160;";*)
			$pageDom:=DOM Parse XML variable:C720($page)
			
			cajole_nodes ($pageDom;$chapterFile;$params)
			parse_href ($pageDom;$chapterFile;$book.base;$params)
			remove_iframe ($pageDom;$chapterFile;$params)
			
			$TitleTitle:=DOM Find XML element by ID:C1010($pageDom;"TitleTitle")
			If (OK=1)
				DOM GET XML ELEMENT NAME:C730($TitleTitle;$stringValue)
				Case of 
					: ($stringValue="span")  //chapter cover with secions
						
						  //h2 > span@id=TitleTitle
						
/*
examples:
command syntax
*/
						
						$div:=DOM Get parent XML element:C923($TitleTitle)
						If (OK=1)
							
							DOM GET XML ELEMENT NAME:C730($div;$stringValue)
							
							If ($stringValue="h2")
								
								insert_h2 ($TitleTitle;$chapterFile;$html)
								
								$title_paragraph:=get_title_paragraph ($pageDom)
								
								If ($title_paragraph#"")
									get_preamble ($title_paragraph;$html)
								End if 
								
								insert_h4_separator ($html)
								
								get_title_list ($pageDom;$book;$html;$params)
								
							Else 
								TRACE:C157  //unknown document structure
							End if 
						Else 
							TRACE:C157  //unknown document structure
						End if 
						
					: ($stringValue="h3")  //chapter cover with no sections
						
						  //div > h3@id=TitleTitle
						
/*
examples:
4D-Widget-components.300-4690710.
*/
						
						insert_h2 ($TitleTitle;$chapterFile;$html)
						
						$title_paragraph:=get_title_paragraph ($pageDom)
						
						If ($title_paragraph#"")
							get_preamble ($title_paragraph;$html)
						End if 
						
						insert_h4_separator ($html)
						
						$node:=DOM Get parent XML element:C923($TitleTitle)
						
						  //skip these
						$node:=DOM Get next sibling XML element:C724($node)  //p
						$node:=DOM Get next sibling XML element:C724($node)  //div
						
						$node:=DOM Get first child XML element:C723($node)  //input
						$node:=DOM Get next sibling XML element:C724($node)  //div
						$node:=DOM Get next sibling XML element:C724($node)
						
						deep_copy_node_html ($node;$html)
						
					Else 
						TRACE:C157  //unknown document structure
				End case 
				
			Else 
				
				$ChapterTitle:=DOM Find XML element by ID:C1010($pageDom;"ChapterTitle")
				
				If (OK=1)
					DOM GET XML ELEMENT NAME:C730($ChapterTitle;$stringValue)
					Case of 
						: ($stringValue="h2")
							
							  //div > h2@id=ChapterTitle
							
/*
examples:
4D-SVG-Constants.202-4611728.
What-s-new.901-4611717.
*/
							
							insert_h2 ($ChapterTitle;$chapterFile;$html)
							
							insert_h4_separator ($html)
							
							get_title_list ($pageDom;$book;$html;$params)
							
						Else 
							TRACE:C157  //unknown document structure
					End case 
				Else 
					
					$newListTitle:=DOM Find XML element by ID:C1010($pageDom;"newListTitle")
					
					If (OK=1)
						DOM GET XML ELEMENT NAME:C730($newListTitle;$stringValue)
						Case of 
							: ($stringValue="h1")
								
								  //div > h1@id=newListTitle
								
/*
examples:
What-s-new.901-4611717.
								
*/
								
								insert_h2 ($newListTitle;$chapterFile;$html)
								
								insert_h4_separator ($html)
								
								get_title_list ($pageDom;$book;$html;$params)
								
							Else 
								TRACE:C157  //unknown document structure
						End case 
					Else 
						TRACE:C157  //unknown document structure
					End if 
				End if 
			End if 
			DOM CLOSE XML:C722($pageDom)
		Else 
			
			$log:=New object:C1471
			$log.path:=$chapterFile.path
			$log.status:=$status
			$params.LOG_PUSH("error_invalid_html";$log)
			
			TRACE:C157  //Tidy fail
			
		End if 
	End for each 
Else 
	TRACE:C157  //Chapter_list does not exist!
End if 
