//%attributes = {}
//creates a log record with info level
C_TEXT:C284($1;$text)
$text:=$1
ASSERT:C1129(Count parameters:C259=1)
ASSERT:C1129(($text#Null:C1517) & ($text#""))
C_OBJECT:C1216($log)
$log:=ds:C1482.Log.new()
$log.text:=$text
$log.level:="info"
$log.time:=Current time:C178
$log.date:=Current date:C33
$log.save()