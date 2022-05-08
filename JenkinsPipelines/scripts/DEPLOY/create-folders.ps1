$ErrorActionPreference = 'Stop'

$WORKSPACE = $args[0]

if( -Not (Test-Path -Path "$WORKSPACE\build" )){
	mkdir $WORKSPACE\build -Force
	Write-Host "$WORKSPACE\build folder created."
}
