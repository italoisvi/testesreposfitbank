$ErrorActionPreference = 'Stop'
$PATH = $args[0]
dotnet restore "$PATH"