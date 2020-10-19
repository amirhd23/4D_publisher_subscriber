Class constructor
	C_LONGINT:C283($1)  //initial capacity [optional]
	This:C1470.bucketCollection:=New collection:C1472
	
	If (Undefined:C82($1))
		This:C1470.numberOfBuckets:=10
	Else 
		This:C1470.numberOfBuckets:=$1
	End if 
	
	This:C1470.numberOfElements:=0
	C_LONGINT:C283($i)
	For ($i;1;This:C1470.numberOfBuckets)
		This:C1470.bucketCollection.push(Null:C1517)
	End for 
	
	
Function size
	C_LONGINT:C283($0)
	$0:=This:C1470.numberOfElements
	
Function isEmpty
	C_BOOLEAN:C305($0)
	If (This:C1470.size()=0)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
	
Function put
	C_VARIANT:C1683($1;$key)
	C_VARIANT:C1683($2;$value)
	C_BOOLEAN:C305($3;$ignoreResizing)
	$key:=$1
	$value:=$2
	$ignoreResizing:=$3
	
	If (This:C1470.isKeyValid($key))
		C_LONGINT:C283($bucketIndex)
		$bucketIndex:=This:C1470.getBucketIndex($key)
		C_VARIANT:C1683($head)
		$head:=This:C1470.bucketCollection[$bucketIndex]
		C_OBJECT:C1216($utilities)
		C_BOOLEAN:C305($keyFound)
		$utilities:=cs:C1710.Utilities.new()
		  // Check if key is already present 
		While (($head#Null:C1517) & ($keyFound=False:C215))
			If ($utilities.equals($head.key;$key))
				$keyFound:=True:C214
				$head.value:=$value
			Else 
				$head:=$head.nextNode
			End if 
		End while 
		
		If ($keyFound=False:C215)
			  // Insert key in chain 
			This:C1470.insertNewNode($key;$value;$bucketIndex)
			If ($ignoreResizing=False:C215)
				This:C1470.increaseBucketSize()
			End if 
			
		End if 
		
	End if 
	
	
	
Function remove
	C_VARIANT:C1683($key;$1)
	C_VARIANT:C1683($0)  //value of removed node
	$key:=$1
	If (This:C1470.isKeyValid($key))
		C_LONGINT:C283($bucketIndex)
		$bucketIndex:=This:C1470.getBucketIndex($key)
		C_VARIANT:C1683($head;$previous)
		C_BOOLEAN:C305($keyFound)
		C_OBJECT:C1216($utilities)
		$utilities:=cs:C1710.Utilities.new()
		$head:=This:C1470.bucketCollection[$bucketIndex]
		While (($head#Null:C1517) & ($keyFound=False:C215))
			If ($utilities.equals($head.key;$key))
				$keyFound:=True:C214
			Else 
				$previous:=$head
				$head:=$head.nextNode
			End if 
		End while 
		
		If ($keyFound=False:C215)
			$0:=Null:C1517
		Else 
			This:C1470.numberOfElements:=This:C1470.numberOfElements-1
			If ($previous#Null:C1517)
				$previous.nextNode:=$head.nextNode
			Else 
				This:C1470.bucketCollection[$bucketIndex]:=$head.nextNode
			End if 
			$0:=$head.value
			
		End if 
		
	End if 
	
Function get
	C_VARIANT:C1683($1;$key)
	C_VARIANT:C1683($0;$value)
	$key:=$1
	
	If (This:C1470.isKeyValid($key))
		C_LONGINT:C283($bucketIndex)
		$bucketIndex:=This:C1470.getBucketIndex($key)
		C_VARIANT:C1683($head)
		C_OBJECT:C1216($utils)
		C_BOOLEAN:C305($keyFound)
		$utils:=cs:C1710.Utilities.new()
		$head:=This:C1470.bucketCollection[$bucketIndex]
		While (($head#Null:C1517) & ($keyFound=False:C215))
			If ($utils.equals($head.key;$key))
				$keyFound:=True:C214
				$value:=$head.value
			Else 
				$head:=$head.nextNode
			End if 
		End while 
		If ($keyFound=False:C215)
			$value:=Null:C1517
		End if 
		$0:=$value
	End if 
	
	
	  //private method
Function insertNewNode
	C_VARIANT:C1683($1;$key)
	C_VARIANT:C1683($2;$value)
	C_LONGINT:C283($3;$bucketIndex)
	$key:=$1
	$value:=$2
	$bucketIndex:=$3
	This:C1470.numberOfElements:=This:C1470.numberOfElements+1
	C_VARIANT:C1683($newNode)
	$newNode:=cs:C1710.HashNode.new($key;$value)
	$newNode.nextNode:=This:C1470.bucketCollection[$bucketIndex]  //previous head
	This:C1470.bucketCollection[$bucketIndex]:=$newNode
	
	
	  //resize bucket collection if load factor goes above 0.7
	  //private method
Function increaseBucketSize
	
	If ((This:C1470.size())/This:C1470.numberOfBuckets>=0.7)
		C_COLLECTION:C1488($temp)
		$temp:=This:C1470.bucketCollection
		This:C1470.bucketCollection:=New collection:C1472
		This:C1470.numberOfBuckets:=2*This:C1470.numberOfBuckets
		C_LONGINT:C283($i)
		For ($i;1;This:C1470.numberOfBuckets)
			This:C1470.bucketCollection.push(Null:C1517)
		End for 
		
		C_OBJECT:C1216($head)
		For each ($head;$temp)
			While ($head#Null:C1517)
				This:C1470.put($head.key;$head.value;True:C214)
				$head:=$head.nextNode
			End while 
		End for each 
		
	End if 
	
	
	  //private method
Function getBucketIndex
	C_VARIANT:C1683($1)  //key
	C_LONGINT:C283($hashCode;$bucketIndex;$0)
	$hashCode:=This:C1470.getObjectHash($1)
	$bucketIndex:=Mod:C98($hashCode;This:C1470.numberOfBuckets)
	$0:=$bucketIndex
	
	  //private method
Function getObjectHash
	C_VARIANT:C1683($1;$key)
	C_LONGINT:C283($0;$hashCode)
	$key:=$1
	If ($key=Null:C1517)
		$hashCode:=0
	Else 
		C_OBJECT:C1216($hashCalculator)
		$hashCalculator:=cs:C1710.HashCalculator.new()
		
		Case of 
			: (Value type:C1509($key)=Is text:K8:3)
				$hashCode:=$hashCalculator.getStringHash($key)
				
			: (Value type:C1509($key)=Is object:K8:27)
				$hashCode:=$hashCalculator.getObjectHash($key)
		End case 
	End if 
	$0:=$hashCode
	
	  //private method
Function isKeyValid
	C_VARIANT:C1683($key;$1)
	C_BOOLEAN:C305($0)
	$key:=$1
	If (($key=Null:C1517) | ((Value type:C1509($key)#Is object:K8:27) & (Value type:C1509($key)#Is text:K8:3)))
		ASSERT:C1129(False:C215;"Error: Only keys of type object and strings are supported")
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 