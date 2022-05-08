$ErrorActionPreference = 'Stop'

$USER    = $args[0] 
$PASS    = $args[1]
$SERVER  = $args[2].Split(",")
$GROUP 	 = $args[3]
$APP     = $args[4]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach ($i in $SERVER){

	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP -ScriptBlock {

	 	$GROUP 	= $args[0]
		$APP	= $args[1].Split(",")
		
	 	Foreach ($a in $APP){
     
	 	InstallUtil -i /priority=SANDBOX "C:\Fitbank\Deploy\Services\$GROUP\$a\FB.Microservices.$GROUP.$a.Win.exe" -force
		
		$SERVICE = get-service | where-object {$_.Name -like "FB $GROUP*$a*"}
		echo $SERVICE



	 	}
		
	 }

	
}
