//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($params)

$params:=This:C1470

ASSERT:C1129(Value type:C1509($params.LOG_FILES)=Is object:K8:27)

C_OBJECT:C1216($LOG_FILES)
$LOG_FILES:=$params.LOG_FILES

C_TEXT:C284($logFileName)
C_OBJECT:C1216($logFile)

For each ($logFileName;$LOG_FILES)
	
	$logFile:=$LOG_FILES[$logFileName]
	
	If (False:C215)
		C_TIME:C306($ref)
		$ref:=Append document:C265($logFile.platformPath)
		USE CHARACTER SET:C205("utf-8";0)
		  //do stuff here
		USE CHARACTER SET:C205(*)
		CLOSE DOCUMENT:C267($ref)
	End if 
	
End for each 