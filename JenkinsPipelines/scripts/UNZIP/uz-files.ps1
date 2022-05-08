$ErrorActionPreference = 'Stop'

$USER    = $args[0] 
$PASS    = $args[1]
$SERVER  = $args[2].Split(",")
$GROUP 	 = $args[3]
$APP     = $args[4]
$TO      = "C:\Fitbank\Deploy\Services\"

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach($i in $SERVER){
	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP, $TO -ScriptBlock {
		$GROUP 	 = $args[0]
		$APP     = $args[1]
		$TO      = $args[2]

		if(-Not (Test-Path -Path "C:\zips para extracao\$APP")){
			mkdir "C:\zips para extracao\$APP" -Force
		}

		Expand-Archive -Path "C:\zips para extracao\$APP.zip" -DestinationPath "C:\zips para extracao\$APP" -Force
		Copy-Item -Path "C:\zips para extracao\$APP\*" -Destination $TO\$GROUP\$APP  -Recurse -Force

		#Remove-Item "C:\zips para extracao\$APP" -Recurse -Force
	}
}