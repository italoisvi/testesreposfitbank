$ErrorActionPreference = 'Stop'

$USER    = $args[0] 
$PASS    = $args[1]
$SERVER  = $args[2].Split(",")
$GROUP 	 = $args[3]
$APP     = $args[4]
$SERVICE = $args[5].Split(".")

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach ($i in $SERVER){

	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP, $SERVICE[2] -ScriptBlock {

	 	$GROUP 	= $args[0]
		$APP	= $args[1]
        $SERVICE = $args[2]
		
	 	Foreach ($a in $APP){
        echo $GROUP
		Echo $APP
	 	InstallUtil -i /priority=HML "C:\Fitbank\Deploy\Services\$GROUP\$a\FB.Microservices.$GROUP.$a.Win.exe" -force
		
		$SERVICE1 = get-service | where-object {$_.Name -like "FB $GROUP*$SERVICE*"}
		echo $SERVICE1
		start-service $SERVICE1


	 	}
		
	 }
	echo $SERVICE1
	
}
