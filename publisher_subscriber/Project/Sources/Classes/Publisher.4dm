Class constructor
	var $name,$1 : Text
	var $broker,$2 : cs:C1710.Broker
	ASSERT:C1129(Count parameters:C259=2)
	$name:=$1
	$broker:=$2
	ASSERT:C1129(($name#Null:C1517) & ($name#""))
	ASSERT:C1129($broker#Null:C1517)
	ASSERT:C1129(OB Instance of:C1731($broker;cs:C1710.Broker))
	This:C1470.name:=$name
	This:C1470.broker:=$broker
	
	
Function publish
	var $message,$1 : cs:C1710.Message
	ASSERT:C1129(Count parameters:C259=1)
	$message:=$1
	This:C1470.broker.onMessage($message)