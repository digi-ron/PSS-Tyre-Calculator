Import-Module "$($PSScriptRoot)\GetFileInformation.psm1"

$radius = Read-Host -Prompt "Enter rim radius (0 for all)"
GetFileInformation -radius $radius