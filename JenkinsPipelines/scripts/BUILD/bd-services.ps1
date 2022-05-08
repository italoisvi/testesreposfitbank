$ErrorActionPreference = 'Stop'

$MSBUILD   = $args[0]
$PROJECT   = $args[1]
$WORKSPACE = $args[2]

Invoke-Expression "C:\\'Program Files (x86)'\\'Microsoft Visual Studio'\\$MSBUILD '$WORKSPACE\\$PROJECT' '/p:Configuration=Release'"