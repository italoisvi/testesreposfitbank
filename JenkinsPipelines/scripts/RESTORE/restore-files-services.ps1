$ErrorActionPreference = 'Stop'

$USER    = $args[0]
$PASS    = $args[1]
$SERVER  = $args[2].Split(",")
$APP     = $args[3]
$FROM    = $args[4]
$TO      = $args[5]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword
Foreach ($i in $SERVER){
Invoke-Command -ComputerName $i  -Credential  $cred -ArgumentList $APP, $FROM, $TO -ScriptBlock {
	$APP     = $args[0].Split(",")
	$FROM    = $args[1]
	$TO      = $args[2]
	Foreach ($r in $APP){
	Copy-Item -Path $FROM\$r$(get-date -Format ddMMyyyy)\* -Destination $TO\$r\ -Force -Recurse
}
	}
		} # Comentário
