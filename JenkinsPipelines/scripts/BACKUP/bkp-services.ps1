$ErrorActionPreference = 'Stop'

$SERVER  = $args[0].Split(",")
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3].Split(",")
$GROUP	 = $args[4]
$TO      = "C:\BackupDeploy\Services\Fitbank"
$FROM    = "C:\Fitbank\Deploy\Services"

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach($i in $SERVER){
	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $APP, $TO, $FROM, $GROUP -ScriptBlock {
		$APP     = $args[0].Split(",")
		$TO      = $args[1]
		$FROM    = $args[2]
		$GROUP	 = $args[3]
	# FOREACH GERLAN
		foreach($a in $APP){

			if( -Not (Test-Path -Path $TO\$GROUP\$a$(Get-Date -Format " yyyy.MM.dd  HH-mm"))){
				mkdir $TO\$GROUP\$a$(Get-Date -Format " yyyy.MM.dd  HH-mm") -Force
			}
		
			#Remove-Item $TO\$GROUP\$APP$(Get-Date -Format " yyyy.MM.dd  HH-mm")\* -Force -Recurse
			Copy-Item -Path $FROM\$GROUP\$a\* -Destination $TO\$GROUP\$a$(Get-Date -Format " yyyy.MM.dd  HH-mm") -Force -Recurse
			exit
		}
	}
}