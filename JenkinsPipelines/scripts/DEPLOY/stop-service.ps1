$ErrorActionPreference = 'Stop'

$SERVER  = $args[0].Split(",")
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3].Split(",")
$GROUP	 = $args[4]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach ($i in $SERVER){

	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP -ScriptBlock {
		$GROUP = $args[0]
		$APP = $args[1].Split(",")
		
		foreach($a in $APP){
		
		Write-Host "Seeking the service $a"

        $SERVICE = get-service | where-object {$_.Name -like "FB $GROUP*$a*"}
    
		If($SERVICE -eq $null){
			Write-Host "The service is not installed, following with the deploy..."
		}Else{
			While ($SERVICE.Status -ne 'Stopped'){
				Stop-Service $SERVICE
				Write-Host $SERVICE.Status
				Start-Sleep -seconds 10
				$SERVICE.Refresh()
				if ($SERVICE.Status -eq 'Stopped'){
					Write-Host "Service stopped successfully, starting uninstall and deploy..."

				} 
			}
			Write-Host $SERVICE
			sc.exe delete $SERVICE
		

			$MS = get-service | where-object {$_.Name -like "FB $GROUP*$a*"}
			Write-Host $MS
		 	if ($MS -ne $null -and $MS.Status -eq "Stopped") {
		 		Write-Host "The Service has not been uninstalled and is still stopped."  
		 	}
		 	 elseif($MS -ne $null -and $MS.Status -eq "Running"){
				Write-Host "The Service has not been uninstalled and is still running."  
		 	}
	
		}
		}
	}

}
