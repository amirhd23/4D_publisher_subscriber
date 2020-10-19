Class constructor
	var $1,$topic,$2,$message : Text
	$topic:=$1
	$message:=$2
	ASSERT:C1129(($topic#Null:C1517) & ($topic#""))
	ASSERT:C1129(($message#Null:C1517) & ($message#""))
	This:C1470.topic:=$topic
	This:C1470.message:=$message
	