. "$($PSScriptRoot)\GetFileInformation.ps1"
. "$($PSScriptRoot)\UserExperience.ps1"

# main menu
$options = @("Get by Diameter", "Get by rim radius", "Get by rim radius & tyre depth", "Get by rim radius & tyre diameter")
$mainMenuSelection = ShowSelectionDialog -Prompt "Select an option" -Options $options -ShowExitOption $true

switch ($mainMenuSelection) {
    1 {
        # diameter calculation
        $diameter = EnterNumber -Prompt "Enter diameter (mm)" -blockZero $true
        $padding = EnterNumber -Prompt "Enter padding (mm)"
        GetByDiameter -diameter $diameter -paddingmm $padding | Select-Object -Property Size, Diameter | Write-Output
        exit
    }
    2 {
        # rim radius calculation
        $radius = EnterNumber -Prompt "Enter rim radius (0 for all)"
        GetByRadius $radius | Select-Object -Property Size, Diameter | Write-Output
        exit
    }
    3 {
        # tyre depth calculation
        $radius = EnterNumber -Prompt "Enter rim radius (0 for all)"
        $depth = EnterNumber -Prompt "Enter tyre depth (mm)" -blockZero $true
        $padding = EnterNumber -Prompt "Enter padding (mm)"
        GetByRadiusAndDepth -radius $radius -depth $depth -depthPadding $padding | Write-Output
    }
}
