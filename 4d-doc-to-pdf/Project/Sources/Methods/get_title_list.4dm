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

C_TEXT:C284($stringValue)
C_TEXT:C284($nodeHtml)

$Title_list:=DOM Find XML element by ID:C1010($dom;"Title_list")

$chapterFiles:=New collection:C1472

If (OK=1)
	
	$html.push("<p><br /></p>")
	$html.push("<div id=\"Chapter_list\">")
	
	ARRAY TEXT:C222($chapterParagraphs;0)
	$div:=DOM Find XML element:C864($Title_list;"div/div";$chapterParagraphs)
	If (OK=1)
		
		  //div / div / p /a
		
/*
most pages take this form
*/
		
		For ($i;1;Size of array:C274($chapterParagraphs))
			$p:=$chapterParagraphs{$i}
			$a:=DOM Find XML element:C864($p;"div/p/a")
			If (OK=1)
				$span:=DOM Get first child XML element:C723($a)
				If (OK=1)
					DOM GET XML ELEMENT VALUE:C731($span;$stringValue)
					$title:=Replace string:C233($stringValue;"\n";" ";*)
				Else 
					  //no span; see anchor directly
					DOM GET XML ELEMENT VALUE:C731($a;$stringValue)
					$title:=Replace string:C233($stringValue;"\n";" ";*)
				End if 
				DOM GET XML ATTRIBUTE BY NAME:C728($a;"xml:href";$stringValue)
				$href:=$stringValue
				DOM GET XML ATTRIBUTE BY NAME:C728($a;"href";$stringValue)
				$anchor:=$stringValue
				
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
						
						$p:=DOM Create XML element:C865($p;"p")
						$a:=DOM Create XML element:C865($p;"a";"href";$anchor)
						DOM SET XML ELEMENT VALUE:C868($a;$title)
						DOM EXPORT TO VAR:C863($p;$nodeHtml)
						DOM REMOVE XML ELEMENT:C869($p)
						
						$html.push($nodeHtml)
				End case 
				
			End if 
		End for 
		
	End if 
	
	ARRAY TEXT:C222($chapterParagraphs;0)
	$div:=DOM Find XML element:C864($Title_list;"div/p";$chapterParagraphs)
	If (OK=1)
		
		  //div / p /a
		
/*
examples:
Introduction.200-4611725.
*/
		
		For ($i;1;Size of array:C274($chapterParagraphs))
			$p:=$chapterParagraphs{$i}
			$a:=DOM Find XML element:C864($p;"p/a")
			If (OK=1)
				$span:=DOM Get first child XML element:C723($a)
				If (OK=1)
					DOM GET XML ELEMENT VALUE:C731($span;$stringValue)
					$title:=Replace string:C233($stringValue;"\n";" ";*)
				Else 
					  //no span; see anchor directly
					DOM GET XML ELEMENT VALUE:C731($a;$stringValue)
					$title:=Replace string:C233($stringValue;"\n";" ";*)
				End if 
				
				DOM GET XML ATTRIBUTE BY NAME:C728($a;"href";$stringValue)
				$anchor:=$stringValue
				
				If ($anchor#"")
					
					DOM GET XML ATTRIBUTE BY NAME:C728($a;"xml:href";$stringValue)
					$href:=$stringValue
					
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
							
							$p:=DOM Create XML element:C865($p;"p")
							$a:=DOM Create XML element:C865($p;"a";"href";$anchor)
							DOM SET XML ELEMENT VALUE:C868($a;$title)
							DOM EXPORT TO VAR:C863($p;$nodeHtml)
							DOM REMOVE XML ELEMENT:C869($p)
							
							$html.push($nodeHtml)
							
					End case 
					
				Else 
					  //Alphabetical-list-of-commands
				End if 
			End if 
		End for 
		
	End if 
	
	$html.push("</div>")
	
	  //now, add pages
	
	For each ($chapterFile;$chapterFiles)
		$options:=New object:C1471("xmlOut";True:C214)
		
		$_html:=$chapterFile.getText("utf-8")
		
		$originalLength:=Length:C16($_html)
		
		$_html:=Replace string:C233($_html;"<mon12b>";"")
		$_html:=Replace string:C233($_html;"</mon12b>";"")
		$_html:=Replace string:C233($_html;"<gen9>";"")
		$_html:=Replace string:C233($_html;"</gen9>";"")
		$_html:=Replace string:C233($_html;"<mon9>";"")
		$_html:=Replace string:C233($_html;"</mon9>";"")
		$_html:=Replace string:C233($_html;"<pal12b>";"")
		$_html:=Replace string:C233($_html;"</pal12b>";"")
		
		If (Length:C16($_html)#$originalLength)
			
			$log:=New object:C1471
			$log.path:=$chapterFile.path
			$log.status:=$status
			$params.LOG_PUSH("warning_invalid_html_tag";$log)
			
		End if 
		
		C_BLOB:C604($content)
		CONVERT FROM TEXT:C1011($_html;"utf-8";$content)
		
		$status:=Tidy ($content;$options)
		
		If ($status.status<2)
			
			$page:=Replace string:C233($status.html;"&nbsp;";"&#160;";*)
			$pageDom:=DOM Parse XML variable:C720($page)
			
			cajole_nodes ($pageDom;$chapterFile;$params)
			parse_href ($pageDom;$chapterFile;$book.base;$params)
			remove_iframe ($pageDom;$chapterFile;$params)
			
			create_chapter_page ($pageDom;$chapterFile;$html)
			
		Else 
			
			$log:=New object:C1471
			$log.path:=$chapterFile.path
			$log.status:=$status
			$params.LOG_PUSH("error_invalid_html";$log)
			
			TRACE:C157  //Tidy fail
			
		End if 
	End for each 
	
Else 
	get_title_list_for_constants ($dom;$book;$html;$params)
End if 