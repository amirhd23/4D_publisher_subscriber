//source https://github.com/madhur2511/Publisher-Subscriber-Implementation/blob/master/Sphere-Pub:Sub-Main.py
Class constructor
	This:C1470.messageQueue:=New collection:C1472
	This:C1470.topicSubscriptionMapping:=cs:C1710.HashMap.new()
	
Function runLoop
	var $message : cs:C1710.Message
	var $subscribers : Collection
	var $subscriber : cs:C1710.Subscriber
	For each ($message;This:C1470.messageQueue)
		$subscribers:=This:C1470.getSubscribersToTopic($message.topic)
		For each ($subscriber;$subscribers)
			$subscriber.onMessage($message.text)
		End for each 
	End for each 
	
Function onMessage
	var $1,$message : cs:C1710.Message
	$message:=$1
	ASSERT:C1129($message#Null:C1517)
	ASSERT:C1129(OB Instance of:C1731($message;cs:C1710.Message))
	This:C1470.messageQueue.push($message)
	
	
Function subscribeToTopic
	var $1,$subscriber : cs:C1710.Subscriber
	var $2,$topic : Text
	$subscriber:=$1
	$topic:=$2
	ASSERT:C1129(($topic#Null:C1517) & ($topic#""))
	ASSERT:C1129(OB Instance of:C1731($subscriber;cs:C1710.Subscriber))
	var $subscriberCollection : Collection
	$subscriberCollection:=This:C1470.topicSubscriptionMapping.get($topic)
	If ($subscriberCollection=Null:C1517)
		$subscriberCollection:=New collection:C1472
		$subscriberCollection.push($subscriber)
		This:C1470.topicSubscriptionMapping.put($topic;$subscriberCollection)
	Else 
		$subscriberCollection.push($subscriber)
	End if 
	
	
Function getSubscribersToTopic
	var $1,$topic : Text
	$topic:=$1
	$0:=This:C1470.topicSubscriptionMapping.get($topic)
	
	
	
	