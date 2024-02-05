//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($1; $params)
C_COLLECTION:C1488($0; $books)

$params:=$1
$books:=New collection:C1472

C_OBJECT:C1216($sourceIndexFolder)
$sourceIndexFolder:=$params.sourceIndexFolder

C_TEXT:C284($lang)
$lang:=$params.lang

C_TEXT:C284($stringValue)
If ($sourceIndexFolder.exists)
	C_OBJECT:C1216($sourceIndexFile)
	$sourceIndexFile:=$sourceIndexFolder.file(New collection:C1472("index"; $lang; "html").join("."; ck ignore null or empty:K85:5))
	If ($sourceIndexFile.exists)
		$options:=New object:C1471("xmlOut"; True:C214)
		C_BLOB:C604($data)
		$data:=$sourceIndexFile.getContent()
		$status:=Tidy($data; $options)
		If ($status.status<2)
			$html:=Replace string:C233($status.html; "&nbsp;"; "&#160;"; *)
			$dom:=DOM Parse XML variable:C720($html)
			cajole_nodes($dom; $sourceIndexFile; $params)  //empty div creates indent
			If (False:C215)
				$tdc_roundbox:=DOM Find XML element:C864($dom; "html/body/table/tr[2]/td[2]/div")
				$home_boxes:=DOM Find XML element:C864($tdc_roundbox; "div/div/div[6]")
				DOM GET XML ATTRIBUTE BY NAME:C728($home_boxes; "id"; $stringValue)
			Else 
				$home_boxes:=DOM Find XML element by ID:C1010($dom; "home_boxes")
			End if 
			$home_box:=DOM Find XML element:C864($home_boxes; "div")
			C_LONGINT:C283($i)
			$i:=1
			Repeat 
				$h3:=DOM Find XML element:C864($home_box; "div/div["+String:C10($i)+"]/div/h3")
				If (OK=1)
					$i:=$i+1
					$book:=New object:C1471
					DOM GET XML ATTRIBUTE BY NAME:C728($h3; "id"; $stringValue)
					$book.id:=$stringValue
					$a:=DOM Find XML element:C864($h3; "h3/a")
					DOM GET XML ATTRIBUTE BY NAME:C728($a; "href"; $stringValue)
					$book.href:=$stringValue
					$book.file:=$sourceIndexFolder.file($stringValue)
					$book.base:=$sourceIndexFolder
					DOM GET XML ATTRIBUTE BY NAME:C728($a; "title"; $stringValue)
					$book.title:=$stringValue
					DOM GET XML ELEMENT VALUE:C731($a; $stringValue)
					$book.name:=Replace string:C233($stringValue; "\n"; " "; *)  //element value may contain \n
					$books.push($book)
				End if 
			Until (OK=0)
			DOM CLOSE XML:C722($dom)
		Else 
			
			$log:=New object:C1471
			$log.path:=$sourceIndexFile.path
			$log.status:=$status
			$params.LOG_PUSH("error_invalid_html"; $log)
			
			TRACE:C157  //Tidy fail
			
		End if 
	End if 
End if 

$0:=$books