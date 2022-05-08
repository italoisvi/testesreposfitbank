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

Invoke-Command -ComputerName $SERVER -Credential $cred -ArgumentList $APP, $TO, $FROM, $GROUP -ScriptBlock {
	$APP     = $args[0]
	$TO      = $args[1]
	$FROM    = $args[2]
	$GROUP	 = $args[3]

	Copy-Item -Path $FROM\$GROUP\$APP$(get-date -Format ddMMyyyy)\* -Destination $TO\$GROUP\$APP -Force -Recurse
}