$ErrorActionPreference = 'Stop'

$SERVER  = $args[0]
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3]
$TO      = $args[4]
$FROM    = $args[5]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Invoke-Command -ComputerName $SERVER -Credential $cred -ArgumentList $APP, $TO, $FROM -ScriptBlock {
	$APP     = $args[0]
	$TO      = $args[1]
	$FROM    = $args[2]

	mkdir $TO\$APP$(get-date -Format ddMMyyyy) -Force
	Remove-Item $TO\$APP$(get-date -Format ddMMyyyy)\* -Force -Recurse
	Copy-Item -Path $FROM\$APP\* -Destination $TO\$APP$(get-date -Format ddMMyyyy) -Force -Recurse
}