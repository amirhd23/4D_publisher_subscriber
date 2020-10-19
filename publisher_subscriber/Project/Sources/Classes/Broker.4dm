Class constructor
	This:C1470.workerProcessName:="worker_process"
	This:C1470.workerProcessMethodName:="runBrokerLoop"
	var workerAttributes : Object
	workerAttributes:=New shared object:C1526
	Use (Storage:C1525)
		Storage:C1525.workerAttributes:=workerAttributes
	End use 
	
Function start
	CALL WORKER:C1389(This:C1470.workerProcessName;This:C1470.workerProcessMethodName)
	
Function stop
	Use (Storage:C1525)
		Use (Storage:C1525.workerAttributes)
			Storage:C1525.workerAttributes.killWorker:=True:C214
		End use 
	End use 
	
Function onMessage
	var $1,$message : cs:C1710.Message
	$message:=$1
	ASSERT:C1129($message#Null:C1517)
	ASSERT:C1129(OB Instance of:C1731($message;cs:C1710.Message))
	var $newMessage : Object
	$newMessage:=ds:C1482.Messages.new()
	$newMessage.topic:=$message.topic
	$newMessage.message:=$message.message
	$newMessage.save()
	
	
Function subscribeToTopic
	var $1,$subscriber : cs:C1710.Subscriber
	var $2,$topic : Text
	$subscriber:=$1
	$topic:=$2
	ASSERT:C1129(($topic#Null:C1517) & ($topic#""))
	ASSERT:C1129(OB Instance of:C1731($subscriber;cs:C1710.Subscriber))
	var $subscriberRecord : Object
	$subscriberRecord:=ds:C1482.Subscribers.query("topic = :1 and subscriberObject.name = :2";$topic;$subscriber.name)
	
	Case of 
		: ($subscriberRecord.length=0)
			var $newSubscriber : Object
			$newSubscriber:=ds:C1482.Subscribers.new()
			$newSubscriber.topic:=$topic
			//$newSubscriber.subscriberName:=$subscriber.name
			$newSubscriber.subscriberObject:=$subscriber
			$newSubscriber.save()
		: ($subscriberRecord.length>1)
			ASSERT:C1129(False:C215;"Error: more than one subscriber found with name "+String:C10($subscriber.name)+", for topic "+$topic)
	End case 
	
	
Function getSubscribersToTopic
	var $1,$topic : Text
	$topic:=$1
	$0:=ds:C1482.Subscribers.query("topic = :1";$topic)
	
	
	
	