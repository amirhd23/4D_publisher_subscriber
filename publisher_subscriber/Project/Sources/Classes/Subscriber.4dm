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
	
Function subscribe
	var $1,$topic : Text
	$topic:=$1
	This:C1470.broker.subscribeToTopic(This:C1470;$topic)
	
Function onMessage
	var $1,$message : Text
	$message:=$1
	logInfo("Subscriber named "+This:C1470.name+", received this message: "+$message)
	