$ErrorActionPreference = 'Stop'

$USER    = $args[0] 
$PASS    = $args[1]
$SERVER  = $args[2].Split(",")
$GROUP 	 = $args[3]
$APP     = $args[4]
$TO      = "C:\Fitbank\Deploy\Services\OSB"

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach($i in $SERVER){
	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP, $TO -ScriptBlock {
		$GROUP 	 = $args[0]
		$APP     = $args[1]
		$TO      = $args[2]
		Foreach ($r in $APP) {
		if(-Not (Test-Path -Path "C:\zips para extracao\$r")){
			mkdir "C:\zips para extracao\$r" -Force
		}

		Expand-Archive -Path "C:\zips para extracao\$r.zip" -DestinationPath "C:\zips para extracao\$r" -Force
		Copy-Item -Path "C:\zips para extracao\$r\*" -Destination $TO\$GROUP\$r  -Recurse -Force

		#Remove-Item "C:\zips para extracao\$APP" -Recurse -Force
	}
	}
}