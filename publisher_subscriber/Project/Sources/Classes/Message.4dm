Class constructor
	var $1,$topic,$2,$text : Text
	$topic:=$1
	$text:=$2
	ASSERT:C1129(($topic#Null:C1517) & ($topic#""))
	ASSERT:C1129(($text#Null:C1517) & ($text#""))
	This:C1470.topic:=$topic
	This:C1470.text:=$text
	