$ErrorActionPreference = 'Stop'

$USER    = $args[0]
$PASS    = $args[1]
$SERVER  = $args[2]
$APP     = $args[3]
$FROM    = $args[4]
$TO      = $args[5]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Invoke-Command -ComputerName $SERVER -Credential $cred -ArgumentList $APP, $FROM, $TO -ScriptBlock {
	$APP     = $args[0]
	$FROM    = $args[1]
	$TO      = $args[2]

	Copy-Item -Path $FROM\$APP$(get-date -Format ddMMyyyy)\* -Destination $TO\$APP\ -Force -Recurse
}
