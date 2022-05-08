$ErrorActionPreference = 'Stop'

$MSBUILD   = $args[0]
$PROJECT   = $args[1]
$WORKSPACE = $args[2]


 
Invoke-Expression "C:\'Program Files (x86)'\'Microsoft Visual Studio'\\$MSBUILD '$WORKSPACE\\$PROJECT' '/T:Clean;Build;Package' '/p:Configuration=Release'  '/p:OutputPath=`"$WORKSPACE\build`"' '/p:PrecompileBeforePublish=true'"