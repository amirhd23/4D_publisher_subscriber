//%attributes = {}
var workerAttributes : Object
var $stop : Boolean
$stop:=False:C215
While (Not:C34($stop))
	var $message : Object
	var $subscribers : Object
	var $subscriber : Object
	For each ($message;ds:C1482.Messages.all())
		$subscribers:=ds:C1482.Subscribers.query("topic = :1";$message.topic)
		For each ($subscriber;$subscribers)
			$subscriber.subscriberObject.onMessage($message.message)
		End for each 
		$message.drop()
	End for each 
	
	If (OB Is defined:C1231(Storage:C1525;"workerAttributes"))
		If (OB Is defined:C1231(Storage:C1525.workerAttributes;"killWorker"))
			If (Storage:C1525.workerAttributes.killWorker=True:C214)
				$stop:=True:C214
				KILL WORKER:C1390
			End if 
		End if 
	End if 
	
End while 