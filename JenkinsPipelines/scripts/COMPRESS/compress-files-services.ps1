# $ErrorActionPreference = 'Stop'

# $SERVICE        = $args[0].Split(",")
# $WORKSPACE      = $args[1]
# $GROUP          = $args[2]
# $SERVICEPATH    = "$WORKSPACE\fb_solution\FB.Microservices.$GROUP.$SERVICE.Win\bin\Release"

# Compress-Archive -Path $SERVICEPATH\* -DestinationPath $WORKSPACE\$SERVICE.zip -Force

$ErrorActionPreference = 'Stop'

$SERVICE        = $args[0].Split(",")
$WORKSPACE      = $args[1]
$GROUP          = $args[2]

#Atualizado
foreach($i in $SERVICE){
	$SERVICEPATH    = "$WORKSPACE\fb_solution\FB.Microservices.$GROUP.$i.Win\bin\Release"
	Remove-Item -Path $SERVICEPATH\*.config
	Remove-Item -Path $SERVICEPATH\*.pdb

	Compress-Archive -Path $SERVICEPATH\* -DestinationPath $WORKSPACE\$i.zip -Force
}