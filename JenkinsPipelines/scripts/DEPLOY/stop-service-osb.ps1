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

        $SERVICE = get-service | where-object {$_.Name -like "Osb.Core.Workers $GROUP*$APP*"}
    
		If($SERVICE -eq $null){
			Write-Host "O serviço não está instalado, seguindo com o deploy..."
		}Else{
			While ($SERVICE.Status -ne 'Stopped'){
				Stop-Service $SERVICE
				Write-Host $SERVICE.Status
				Start-Sleep -seconds 10
				$SERVICE.Refresh()
				if ($SERVICE.Status -eq 'Stopped'){
					Write-Host "O servico foi parado com exito, iniciando desinstalacao e deploy ..."
				} 
			}
			sc.exe delete $SERVICE
			
			$SERVICE = get-service | where-object {$_.Name -like "Osb.Core.Workers $GROUP*$APP*"}
			if ($SERVICE -ne $null) {
				Write-Error -Message "O Serviço não foi desinstalado."  -ErrorAction Stop
			}
			 elseif($SERVICE -ne $null -and $SERVICE.Status -eq "Running"){
				Write-Error -Message "O Servico nao foi desinstalado e continua em execucao."  -ErrorAction Stop
			}
		}
	}
}

