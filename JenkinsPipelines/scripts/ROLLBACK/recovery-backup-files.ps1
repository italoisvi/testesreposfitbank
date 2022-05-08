$ErrorActionPreference = 'Stop'

    $SERVER     = $args[0]
    $USER       = $args[1]
    $PASS       = $args[2]
    $SERVERNAME = $args[3].Split(",")
    $APP        = $args[4]
    $TO         = $args[5]
    $FROM       = "\\$SERVER\c$\Fitbank\Deploy\Sites\$APP\"

    $SecurePassword = $PASS | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $USER, $SecurePassword

    Invoke-Command -ComputerName $SERVERNAME -Credential $cred -ArgumentList $APP, $TO, $FROM -ScriptBlock {
        $APP     = $args[0]
        $TO      = $args[1]
        $FROM    = $args[2]
        Copy-Item -Path \\FBWINHML2\c$\BackupDeploy\Sites\$TO\* -Destination $FROM -Force -Recurse -verbose
    }