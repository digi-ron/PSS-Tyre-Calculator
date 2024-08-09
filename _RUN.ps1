. "$($PSScriptRoot)\GetFileInformation.ps1"
. "$($PSScriptRoot)\UserExperience.ps1"

# main menu
$options = @("Get by Diameter", "Get by rim radius")
$mainMenuSelection = ShowSelectionDialog -Prompt "Select an option" -Options $options -ShowExitOption $true

switch ($mainMenuSelection) {
    1 {
        $diameter = Read-Host -Prompt "Enter diameter (mm)"
        $padding = Read-Host -Prompt "Enter padding (mm)"
        GetByDiameter -diameter $diameter -paddingmm $padding | Write-Output
        exit
    }
}
