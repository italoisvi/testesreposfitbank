$ErrorActionPreference = 'Stop'

$SERVER  = $args[0].Split(",")
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3]
$GROUP	 = $args[4]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach ($i in $SERVER){

	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP -ScriptBlock {
		$GROUP = $args[0]
		$APP = $args[1]

        InstallUtil -i /priority=RECUPERADO "C:\Fitbank\Deploy\Services\$GROUP\$APP\FB.Microservices.$GROUP.$APP.Win.exe"
		
		$SERVICE = get-service | where-object {$_.Name -like "FB $GROUP*$APP*"}
		
		start-service $SERVICE
	}
}