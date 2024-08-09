function GetFileInformation {
    $parsedFile = Get-Content -Path .\sizes.json | ConvertFrom-Json
    $informationGathered = @()

    $radii = ($parsedFile | Get-Member -MemberType NoteProperty).Name
    foreach ($r in $radii) {
        $r = [double]$r
        $sections = ($parsedFile."$($r)" | Get-Member -MemberType NoteProperty).Name
        foreach ($s in $sections) {
            $s = [double]$s
            for($i = 0; $i -lt $parsedFile."$($r)"."$($s)".Count; $i++) {
                $a = [double]($parsedFile."$($r)"."$($s)"[$i])
                $readableSize = "$($s)/$($a)R$($r)"
                #working
                $calculatedDiameter = [int][math]::Ceiling(($s * ($a / 100) * 2) + (25.4 * $r))

                $informationGathered += [PSCustomObject]@{
                    Width = $s
                    AspectRatio = $a
                    RimSize = $r
                    Size = $readableSize
                    Diameter = $calculatedDiameter
                }
            }
        }
    }
    $output = $informationGathered | Sort-Object -Property Diameter
    return $output
}

function GetByRadius([Parameter(Mandatory=$true)][int]$radius) {
    $output = GetFileInformation | Where-Object { $_.RimSize -eq $radius }
    return $output
}

function GetByDiameter {
    param (
        [Parameter(Mandatory=$true)][int]$diameter,
        [int]$paddingmm = 0
    )
    $output = GetFileInformation | Where-Object { $_.Diameter -le ($diameter + $paddingmm) -and $_.Diameter -ge ($diameter - $paddingmm) }
    return $output
}

function GetByRadiusAndDepth {
    param (
        [Parameter(Mandatory=$true)][int]$radius,
        [Parameter(Mandatory=$true)][int]$depth,
        [int]$depthPadding = 0
    )
    $output = GetFileInformation | Where-Object { $_.RimSize -eq $radius -and $_.Width -le ($depth + $depthPadding) -and $_.Width -ge ($depth - $depthPadding) }
    return $output
}

function GetByRadiusAndDiameter {
    param (
        [Parameter(Mandatory=$true)][int]$radius,
        [Parameter(Mandatory=$true)][int]$diameter,
        [int]$paddingmm = 0
    )
    $output = GetFileInformation | Where-Object { $_.RimSize -eq $radius -and $_.Diameter -le ($diameter + $paddingmm) -and $_.Diameter -ge ($diameter - $paddingmm) }
    return $output
}