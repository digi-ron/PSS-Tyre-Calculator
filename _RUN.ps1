. "$($PSScriptRoot)\GetFileInformation.ps1"
. "$($PSScriptRoot)\UserExperience.ps1"

# main menu
$options = @("List all by Diameter", "Get by Diameter", "Get by rim radius", "Get by rim radius & tyre depth", "Get by rim radius & tyre diameter")
$mainMenuSelection = ShowSelectionDialog -Prompt "Select an option" -Options $options -ShowExitOption $true

switch ($mainMenuSelection) {
    1 {
        GetFileInformation | Select-Object -Property Size, Diameter | Write-Output
    }
    2 {
        # diameter calculation
        $diameter = EnterNumber -Prompt "Enter diameter (mm)" -blockZero $true
        $padding = EnterNumber -Prompt "Enter padding (mm)"
        GetByDiameter -diameter $diameter -paddingmm $padding | Select-Object -Property Size, Diameter | Write-Output
    }
    3 {
        # rim radius calculation
        $radius = EnterNumber -Prompt "Enter rim radius"
        GetByRadius $radius | Select-Object -Property Size, Diameter | Write-Output
    }
    4 {
        # tyre depth calculation
        $radius = EnterNumber -Prompt "Enter rim radius"
        $depth = EnterNumber -Prompt "Enter tyre depth (mm)" -blockZero $true
        $padding = EnterNumber -Prompt "Enter padding (mm)"
        GetByRadiusAndDepth -radius $radius -depth $depth -depthPadding $padding | Select-Object -Property Size, Diameter | Write-Output
    }
    5 {
        # tyre diameter calculation (with rim size)
        $radius = EnterNumber -Prompt "Enter rim radius"
        $diameter = EnterNumber -Prompt "Enter diameter (mm)" -blockZero $true
        $padding = EnterNumber -Prompt "Enter padding (mm)"
        GetByRadiusAndDiameter -radius $radius -diameter $diameter -paddingmm $padding | Select-Object -Property Size, Diameter | Write-Output
    }
}
