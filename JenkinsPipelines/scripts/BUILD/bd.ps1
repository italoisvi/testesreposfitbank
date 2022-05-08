$ErrorActionPreference = 'Stop'

$MSBUILD   = $args[0]
$PROJECT   = $args[1]
$WORKSPACE = $args[2]

if($PROJECT -ceq "FB.CnabIO.Api.Rest"){
    $SOLUTION = "fbcnabio_solution"
} else {
    $SOLUTION = "fb_solution"
}

Invoke-Expression "C:\\'Program Files (x86)'\\'Microsoft Visual Studio'\\$MSBUILD '$WORKSPACE\\$SOLUTION\\$PROJECT\\$PROJECT.csproj' '/T:Clean;Build;Package' '/p:Configuration=Release'  '/p:OutputPath=`"$WORKSPACE\build`"' '/p:PrecompileBeforePublish=true'"