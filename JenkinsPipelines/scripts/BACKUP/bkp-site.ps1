$ErrorActionPreference = 'Stop'

$SERVER  = $args[0]
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Invoke-Command -ComputerName $SERVER -Credential $cred -ArgumentList $APP -ScriptBlock {
	$APP     = $args[0]
	
	mkdir C:\BackupDeploy\Sites\$APP$(get-date -Format ddMMyyyy) -Force
	Remove-Item C:\BackupDeploy\Sites\$APP$(get-date -Format ddMMyyyy)\* -Force -Recurse
	Copy-Item -Path C:\FitBank\Deploy\Sites\$APP\* -Destination C:\BackupDeploy\Sites\$APP$(get-date -Format ddMMyyyy) -Force -Recurse
}