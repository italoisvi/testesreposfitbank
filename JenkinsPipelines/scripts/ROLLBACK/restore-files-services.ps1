$ErrorActionPreference = 'Stop'

$SERVER  = $args[0].Split(",")
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3]
$GROUP	 = $args[4]
$FROM    = "C:\BackupDeploy\Services\Fitbank"
$TO    	 = "C:\Fitbank\Deploy\Services"

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach ($i in $SERVER){
	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $APP, $FROM, $TO, $GROUP -ScriptBlock {
	$APP     = $args[0]
	$FROM    = $args[1]
	$TO      = $args[2]
	$GROUP	 = $args[3]

	Copy-Item -Path $FROM\$GROUP\$APP$(get-date -Format ddMMyyyy)\* -Destination $TO\$GROUP\$APP\ -Force -Recurse
		
	InstallUtil -i /priority=PROD "C:\Fitbank\Deploy\Services\$GROUP\$APP\FB.Microservices.$GROUP.$APP.Win.exe"
		
	$SERVICE = get-service | where-object { $_.Name -like "FB $GROUP*$APP*" }
	#Start-Service $SERVICE
	Write-Output $SERVICE
	exit
	}
}