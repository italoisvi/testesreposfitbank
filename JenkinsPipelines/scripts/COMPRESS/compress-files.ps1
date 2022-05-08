$ErrorActionPreference = 'Stop'

$PROJECT   = $args[0]
$WORKSPACE = $args[1]

Remove-Item -Path $WORKSPACE\build\_PublishedWebsites\$PROJECT\*.config -Force
Compress-Archive -Path $WORKSPACE\fb_solution\$PROJECT\* -DestinationPath $WORKSPACE\$PROJECT.zip -Force
