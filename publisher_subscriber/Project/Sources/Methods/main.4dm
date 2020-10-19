//%attributes = {}
clearAllRecords
logInfo("Starting Message Broker Service")
var $broker : cs:C1710.Broker
$broker:=cs:C1710.Broker.new()
$broker.start()

var $sub_1,$sub_2,$sub_3 : cs:C1710.Subscriber
var $pub_1,$pub_2 : cs:C1710.Publisher

$sub_1:=cs:C1710.Subscriber.new("sub_1";$broker)
$sub_2:=cs:C1710.Subscriber.new("sub_2";$broker)
$sub_3:=cs:C1710.Subscriber.new("sub_3";$broker)

$pub_1:=cs:C1710.Publisher.new("pub_1";$broker)
$pub_2:=cs:C1710.Publisher.new("pub_2";$broker)

$sub_1.subscribe("Sports")
$sub_1.subscribe("Politics")
$sub_2.subscribe("Sports")
$sub_2.subscribe("Politics")
$sub_3.subscribe("Entertainment")

$pub_1.publish(cs:C1710.Message.new("Politics";"Message 1"))
$pub_1.publish(cs:C1710.Message.new("Sports";"Message 2"))
$pub_2.publish(cs:C1710.Message.new("Politics";"Message 3"))
$pub_2.publish(cs:C1710.Message.new("Politics";"Message 4"))
$pub_2.publish(cs:C1710.Message.new("Entertainment";"Message 5"))

//sub_1 : m1, m2, m3, m4
//sub_2 : m1, m2, m3, m4
//sub_3 : m5

var $startTime : Time
$startTime:=Current time:C178
While (Time:C179(Timestamp:C1445)-$startTime<Time:C179("00:00:3"))
	
End while 
$broker.stop()


