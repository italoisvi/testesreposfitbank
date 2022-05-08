$ErrorActionPreference = 'Stop'

$SERVICE        = $args[0].Split(",")
$WORKSPACE      = $args[1]
$GROUP          = $args[2]


foreach($i in $SERVICE){
	$SERVICEPATH    = "$WORKSPACE\fbcnabio_solution\FB.Microservices.$GROUP.$i.Win\bin\Release"
	Compress-Archive -Path $SERVICEPATH\* -DestinationPath $WORKSPACE\$i.zip -Force
}