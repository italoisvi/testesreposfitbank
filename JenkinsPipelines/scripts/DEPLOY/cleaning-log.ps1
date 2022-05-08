$ErrorActionPreference = 'Stop'


$SERVER  = $args[0]
$LOG     = "C$\Program Files (x86)\Jenkins\workspace\" ## HML 
#$LOG     = "C$\Fitbank\Deploy\Logs\Webhook\" ## SANDBOX
$i       = ""
$FOLDER  = Get-ChildItem -Path "\\$SERVER\\$LOG\\*"

############################################################################
#Entrar na Pasta

cd "\\$SERVER\$LOG"

#Loop para entrar em cada pasta, mostra-la e apagar apenas os logs .xml,
#voltando a pasta anterior para que o próximo loop faça o mesmo trabalho.

foreach($i in $FOLDER){
    cd $i
    echo $i
    if(-Not (Test-Path -Path "Pipeline Limpa Logs")){
        Remove-Item * -Recurse -Force
    }   


    cd ..
}
