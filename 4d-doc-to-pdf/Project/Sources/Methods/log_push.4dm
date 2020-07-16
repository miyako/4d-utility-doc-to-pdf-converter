//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($1;$logFileName)
C_OBJECT:C1216($2;$log)

$params:=This:C1470

ASSERT:C1129(Value type:C1509($params.LOG_FILES)=Is object:K8:27)

C_OBJECT:C1216($LOG_FILES)
$LOG_FILES:=$params.LOG_FILES

$logFileName:=$1
$log:=$2

C_OBJECT:C1216($logFile)
$logFile:=$LOG_FILES[$logFileName]

ASSERT:C1129($logFile#Null:C1517)
If (Not:C34($logFile.exists))
	$logFile.setText()
End if 

C_TIME:C306($ref)
$ref:=Append document:C265($logFile.platformPath)

USE CHARACTER SET:C205("utf-8";0)
SEND PACKET:C103($ref;JSON Stringify:C1217($log;*))
USE CHARACTER SET:C205(*)

CLOSE DOCUMENT:C267($ref)