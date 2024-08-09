function ShowSelectionDialog {
    param (
        [Parameter(Mandatory=$true)][string]$prompt,
        [Parameter(Mandatory=$true)][string[]]$options,
        [bool]$showExitOption = $true
    )

    $selection = -1
    while ($selection -le 0) {
        for($i = 0; $i -lt $options.Length; $i++) {
            Write-Host "[$($i + 1)] $($options[$i])"
        }
        if($showExitOption) {
            Write-Host "[0] Exit"
        }
        $temp = Read-Host -Prompt $prompt
        try {
            $temp = [int]$temp
            if ($temp -gt $options.Length -or $temp -lt 0) {
                throw "Invalid selection!"
            }
            if($temp -eq 0) {
                if($showExitOption) {
                    exit
                } else {
                    throw "0 selected with exit option diabled!"
                }
            }
            $selection = $temp
        } catch {
            Write-Error "ERROR: $($_.Exception.Message)"
        }
    }
    return $selection
}

function EnterNumber {
    param (
        [Parameter(Mandatory=$true)][string]$prompt,
        [int]$maxNum = -1,
        [bool]$blockZero = $false
    )
    $number = -1
    while ($number -lt 0) {
        $temp = Read-Host -Prompt $prompt
        try {
            $temp = [int]$temp
            if ($temp -lt 0 -or ($maxNum -ge 0 -and $temp -gt $maxNum)) {
                throw "Invalid number - Out of range!"
            }
            if ($temp -eq 0 -and $blockZero) {
                throw "Invalid number - Zero is not allowed!"
            }
            $number = $temp
        } catch {
            Write-Error "ERROR: $($_.Exception.Message)"
        }
    }
    return $number
}