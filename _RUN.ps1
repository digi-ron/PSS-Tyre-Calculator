. "$($PSScriptRoot)\GetFileInformation.ps1"
. "$($PSScriptRoot)\UserExperience.ps1"

# main menu
$options = @("Get by Diameter", "Get by rim radius")
$mainMenuSelection = ShowSelectionDialog -Prompt "Select an option" -Options $options -ShowExitOption $true

switch ($mainMenuSelection) {
    1 {
        # diameter calculation
        $diameter = EnterNumber -Prompt "Enter diameter (mm)" -blockZero $true
        $padding = EnterNumber -Prompt "Enter padding (mm)"
        GetByDiameter -diameter $diameter -paddingmm $padding | Write-Output
        exit
    }
    2 {
        # rim radius calculation
        $radius = EnterNumber -Prompt "Enter rim radius (0 for all)"
        GetByRadius $radius | Write-Output
        exit
    }
}
