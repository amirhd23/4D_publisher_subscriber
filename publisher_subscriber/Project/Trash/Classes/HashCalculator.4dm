Class constructor
	
Function getRealHash
	C_REAL:C285($1;$realNumber)
	C_LONGINT:C283($0;$hashCode)
	$realNumber:=$1
	
	$hashCode:=0
	While (($realNumber%10)#0)
		$hashCode:=$realNumber%10
		$realNumber:=$realNumber*10
	End while 
	
	$0:=$hashCode
	
Function getStringHash
	C_TEXT:C284($1;$string)
	C_LONGINT:C283($0;$hashCode)
	$string:=$1
	
	C_OBJECT:C1216($util)
	C_COLLECTION:C1488($chars)
	$util:=cs:C1710.Utilities.new()
	$chars:=$util.getStringChars($string)
	
	$hashCode:=0
	
	C_TEXT:C284($char)
	For each ($char;$chars)
		$hashCode:=($hashCode+((Character code:C91($char)-Character code:C91("a"))+1)*3)
	End for each 
	
	If ($hashCode<=0)
		$0:=$hashCode*(-1)
	Else 
		$0:=$hashCode
	End if 
	
	
	  //https://cp-algorithms.com/string/string-hashing.html
	  //C_TEXT($1;$string)
	  //C_LONGINT($0;$hashCode)
	  //$string:=$1
	
	  //C_LONGINT($p;$m;$p_power)
	  //C_OBJECT($util)
	  //C_COLLECTION($chars)
	  //$util:=cs.Utilities.new()
	  //$chars:=$util.getStringChars($string)
	
	  //$p:=31
	  //$m:=10^9+9
	  //$hashCode:=0
	  //$p_power:=1
	
	  //C_TEXT($char)
	  //For each ($char;$chars)
	  //$hashCode:=($hashCode+((Character code($char)-Character code("a"))+1)*$p_power)%$m
	  //$p_power:=($p_power*$p)%$m
	  //End for each 
	
	  //If ($hashCode<=0)
	  //$0:=$hashCode*(-1)
	  //Else 
	  //$0:=$hashCode
	  //End if 
	
	
	
	
Function getObjectHash
	C_OBJECT:C1216($1;$obj)
	C_LONGINT:C283($hashCode)
	$obj:=$1
	ARRAY TEXT:C222($propertyNames;0)
	ARRAY LONGINT:C221($propertyTypes;0)
	OB GET PROPERTY NAMES:C1232($1;$propertyNames;$propertyTypes)
	C_LONGINT:C283($i)
	$hashCode:=43
	For ($i;1;Size of array:C274($propertyNames))
		C_LONGINT:C283($propType)
		C_VARIANT:C1683($propValue)
		$propType:=$propertyTypes{$i}
		$propValue:=OB Get:C1224($1;$propertyNames{$i})
		Case of 
			: ($propType=1)  //real
				$hashCode:=37*$hashCode+This:C1470.getRealHash($propValue)
				
			: ($propType=2)  //string
				$hashCode:=37*$hashCode+This:C1470.getStringHash($propValue)
				
			: ($propType=6)  //boolean
				If ($propValue=True:C214)
					$hashCode:=37*$hashCode
				Else 
					$hashCode:=37*$hashCode+1
				End if 
				
			: ($propType=38)  //object
				$hashCode:=37*$hashCode+This:C1470.getObjectHash($propValue)
				
			: ($propType=39)  //object array
				C_LONGINT:C283($j)
				For ($j;1;Size of array:C274($propValue))
					$hashCode:=37*$hashCode+This:C1470.getObjectHash($propValue{$j})
				End for 
				
			: ($propType=42)  //collection
				C_VARIANT:C1683($item)
				For each ($item;$propValue)
					$hashCode:=37*$hashCode+This:C1470.getObjectHash($item)
				End for each 
				
			: ($propType=255)  //null
				$hashCode:=37*$hashCode+0
				
			Else 
				ASSERT:C1129(False:C215;"Error: unsupported property type "+String:C10($propType)+" in the properties of the key object.")
				
		End case 
	End for 
	