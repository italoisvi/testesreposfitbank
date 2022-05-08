$ErrorActionPreference = 'Stop'

$PATH = $args[0]

if(-Not (Test-Path -Path C:\\'Program Files (x86)'\\NuGet\\nuget.exe)){
	nuget restore "$PATH"
} else {
	C:\\'Program Files (x86)'\\NuGet\\nuget.exe restore "$PATH"
}