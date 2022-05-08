$ErrorActionPreference = 'Stop'

$USER    = $args[0] 
$PASS    = $args[1]
$SERVER  = $args[2]
$APP     = $args[3]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Invoke-Command -ComputerName $SERVER -Credential $cred -ArgumentList $APP -ScriptBlock {
	$APP     = $args[0]

	Restart-WebItem "IIS:\\Sites\\$APP"
}
