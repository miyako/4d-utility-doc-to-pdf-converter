//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($params)

$params:=This:C1470

If (Bool:C1537($params.CREATE_LOG))
	
	If ($params.LOG_FOLDER=Null:C1517) | (Value type:C1509($params.LOG_FOLDER)#Is object:K8:27)
		$params.LOG_FOLDER:=Folder:C1567(fk logs folder:K87:17)
	End if 
	
	C_OBJECT:C1216($LOG_FOLDER)
	$LOG_FOLDER:=$params.LOG_FOLDER
	$LOG_FOLDER.create()
	
	C_COLLECTION:C1488($logFileNames)
	$logFileExtension:="txt"
	
	$logFileNames:=New collection:C1472(\
		"warning_link_to_home";\
		"warning_link_to_o_command";\
		"warning_empty_path_component";\
		"warning_link_to_wrong_version";\
		"warning_empty_anchor";\
		"warning_empty_div";\
		"warning_iframe";\
		"warning_invalid_html_tag";\
		"error_invalid_html")
	
	$params.LOG_FILES:=New object:C1471
	
	C_OBJECT:C1216($logFile)
	C_TEXT:C284($logFileName)
	For each ($logFileName;$logFileNames)
		$logFile:=$LOG_FOLDER.file(New collection:C1472($logFileName;$logFileExtension).join(".";ck ignore null or empty:K85:5))
		$params.LOG_FILES[$logFileName]:=$logFile
	End for each 
	
End if 