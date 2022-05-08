
                    $USER = $args[0]
                    $PASS = $args[1]
                    $SERVER = $args[2]
                    $PASSWORD = $PASS | ConvertTo-SecureString -AsPlainText -Force
                    $CRED = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $PASSWORD
                    $SERVICESHORTNAME = $args[3]

                    Invoke-Command -ComputerName $SERVER -Credential $CRED -ArgumentList $SERVICESHORTNAME -ScriptBlock {
                       $SERVICESHORTNAME = $args[0]
                        if($SERVICESHORTNAME -eq "Osb.Core.Workers.BoletoPayment.Cancel.Starter.csproj"){
                            $SERVICO = 'Cancel'
                        }
                        

                        if(-Not (Test-Path -Path "C:\zips para extracao\$SERVICO")){
                            mkdir "C:\zips para extracao\$SERVICO" -Force
                            mkdir "C:\FitBank\Deploy\Sites\$SERVICO" -Force
                        }

                        Expand-Archive -Path "C:\zips para extracao\OSBWorkers.zip" -DestinationPath "C:\zips para extracao\$SERVICO" -Force
                        Copy-Item -Path "C:\zips para extracao\$SERVICO\*" -Destination C:\FitBank\Deploy\Sites\$SERVICO  -Recurse -Force

                        Remove-Item "C:\zips para extracao\$SERVICO" -Recurse -Force
                    }