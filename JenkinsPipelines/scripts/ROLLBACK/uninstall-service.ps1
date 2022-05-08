$ErrorActionPreference = 'Stop'

$SERVER  = $args[0].Split(",")
$USER    = $args[1]
$PASS    = $args[2]
$APP     = $args[3]
$GROUP	 = $args[4]

$SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

Foreach ($i in $SERVER){

	Invoke-Command -ComputerName $i -Credential $cred -ArgumentList $GROUP, $APP -ScriptBlock {
		$GROUP = $args[0]
		$APP = $args[1]

        $SERVICE = get-service | where-object {$_.Name -like "FB $GROUP*$APP*"}
    
		If($SERVICE -eq $null){
			Write-Host "O serviço não está instalado, seguindo com o rollback..."
		}Else{
			While ($SERVICE.Status -ne 'Stopped'){
				Stop-Service $SERVICE
				Write-Host $SERVICE.Status
				Start-Sleep -seconds 10
				$SERVICE.Refresh()
				if ($SERVICE.Status -eq 'Stopped'){
					Write-Host "O serviço foi parado com êxito, iniciando desinstalação e deploy ..."
				} 
			}
			sc.exe delete $SERVICE
		}
	}
}