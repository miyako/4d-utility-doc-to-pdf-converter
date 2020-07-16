//%attributes = {}
C_OBJECT:C1216($params)

$params:=New object:C1471

$params.CREATE_LOG:=True:C214
$params.LOG_FOLDER:=Folder:C1567(System folder:C487(Desktop:K41:16)+"_log";fk platform path:K87:2)
$params.LOG_START:=Formula:C1597(log_start )
$params.LOG_PUSH:=Formula:C1597(log_push )
$params.LOG_END:=Formula:C1597(log_end )

$params.LOG_START()

$log:=New object:C1471()

$params.LOG_PUSH("removed_iframe";$log)

$params.LOG_END()