$ErrorActionPreference = 'Stop'

$USER    = $args[0] 
$PASS    = $args[1]
$SERVER  = $args[2].Split(",")
$APP     = $args[3]
$ZIP	 = $args[4]


$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach($i in $SERVER){
	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $APP, $ZIP -ScriptBlock {
		$APP     = $args[0]
		$ZIP	 = $args[1]

		Expand-Archive -Path "C:\zips para extracao\$ZIP.zip" -DestinationPath "C:\FitBank\Deploy\Sites\$APP" -Force
		#Rename-Item -Path "C:\FitBank\Deploy\Sites\$APP\obj\Release\AspnetCompileMerge\Source\bin\roslyn\Microsoft.CodeAnalysis.CSharp2.dll" -NewName "Microsoft.CodeAnalysis.CSharp.dll" -Force

	}
}