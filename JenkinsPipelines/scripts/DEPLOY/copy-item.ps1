$ErrorActionPreference = 'Stop'

$SERVICE   = $args[0].Split(",")
$WORKSPACE = $args[1]
$SERVER    = $args[2].Split(",")


foreach($i in $SERVER){
	foreach($r in $SERVICE){
		Copy-Item -Path $WORKSPACE\$r.zip -Destination \\$i\c$\"zips para extracao" -Force
	}
}