Class constructor
	
	
Function equals
	C_VARIANT:C1683($item1;$1)
	C_VARIANT:C1683($item2;$2)
	C_BOOLEAN:C305($0)
	$item1:=$1
	$item2:=$2
	
	If (($item1=Null:C1517) | ($item2=Null:C1517) | (Value type:C1509($item1)#Value type:C1509($item2)))
		$0:=False:C215
	Else 
		Case of 
			: ((Value type:C1509($item1)=Is text:K8:3) | (Value type:C1509($item1)=Is string var:K8:2) | (Value type:C1509($item1)=Is longint:K8:6) | (Value type:C1509($item1)=Is integer:K8:5) | (Value type:C1509($item1)=Is real:K8:4) | (Value type:C1509($item1)=Is boolean:K8:9) | (Value type:C1509($item1)=Is date:K8:7))
				If ($item1=$item2)
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
				
			: (Value type:C1509($item1)=Is pointer:K8:14)
				If (This:C1470.equals($item1->;$item2->)=True:C214)
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
				
			: (Value type:C1509($item1)=Is collection:K8:32)
				If ($item1.length#$item2.length)
					$0:=False:C215
				Else 
					$0:=True:C214
					C_LONGINT:C283($i)
					For ($i;0;$item1.length-1)
						If (This:C1470.equals($item1[$i];$item2[$i])=False:C215)
							$0:=False:C215
							$i:=$item1.length+1
						End if 
					End for 
				End if 
				
			: ((Value type:C1509($item1)=Boolean array:K8:21) | (Value type:C1509($item1)=Text array:K8:16) | (Value type:C1509($item1)=Integer array:K8:18) | (Value type:C1509($item1)=Date array:K8:20) | (Value type:C1509($item1)=LongInt array:K8:19) | (Value type:C1509($item1)=Object array:K8:28) | (Value type:C1509($item1)=Pointer array:K8:23) | (Value type:C1509($item1)=Real array:K8:17) | (Value type:C1509($item1)=String array:K8:15) | (Value type:C1509($item1)=Time array:K8:29))
				  //If (Size of array($item1)#Size of array($item2))
				  //$0:=False
				  //Else 
				  //C_LONGINT($i)
				  //$0:=True
				  //For ($i;1;Size of array($item1))
				  //If (This.equals($item1{$i};$item2{$i})=False)
				  //$0:=False
				  //$i:=Size of array($item1)+1
				  //End if 
				  //End for 
				  //End if 
				
				ASSERT:C1129(False:C215;"Error: Equality check does not support arrays.")
				
			: (Value type:C1509($item1)=Is object:K8:27)
				ARRAY TEXT:C222($propNamesItem1;0)
				ARRAY LONGINT:C221($propTypesItem1;0)
				OB GET PROPERTY NAMES:C1232($item1;$propNamesItem1;$propTypesItem1)
				
				ARRAY TEXT:C222($propNamesItem2;0)
				ARRAY LONGINT:C221($propTypesItem2;0)
				OB GET PROPERTY NAMES:C1232($item2;$propNamesItem2;$propTypesItem2)
				SORT ARRAY:C229($propNamesItem1)
				SORT ARRAY:C229($propNamesItem2)
				If (This:C1470.equals($propNamesItem1;$propNamesItem2)=True:C214)  //compare property names
					  //compare property values
					C_LONGINT:C283($i)
					$0:=True:C214
					For ($i;1;Size of array:C274($propNamesItem1))
						If (This:C1470.equals(OB Get:C1224($item1;$propNamesItem1{$i});OB Get:C1224($item2;$propNamesItem1{$i}))=False:C215)
							$0:=False:C215
							$i:=Size of array:C274($propNamesItem1)+1
						End if 
					End for 
				Else 
					$0:=False:C215
				End if 
				
			Else 
				ASSERT:C1129(False:C215;"Error: Received unsupported type for equality check: Types received: item 1 =>"+String:C10(Value type:C1509($item1))+",  item 2 =>"+String:C10(Value type:C1509($item2)))
		End case 
	End if 
	
Function getStringChars
	C_TEXT:C284($string;$1)
	C_COLLECTION:C1488($charsCollection;$0)
	$string:=$1
	
	C_LONGINT:C283($i)
	$charsCollection:=New collection:C1472
	
	For ($i;1;Length:C16($string))
		$charsCollection.push(Substring:C12($string;$i;1))
	End for 
	
	$0:=$charsCollection
	
	
	
	
	
	
	
	