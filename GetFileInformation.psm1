function GetFileInformation([Parameter(Mandatory=$true)][string]$radius) {
    $parsedFile = Get-Content -Path .\sizes.json | ConvertFrom-Json
    $informationGathered = @()

    $radii = ($parsedFile | Get-Member -MemberType NoteProperty).Name
    foreach ($r in $radii) {
        $r = [double]$r
        if ($radius -eq "0" -or $r -eq $radius) {
            $sections = ($parsedFile."$($r)" | Get-Member -MemberType NoteProperty).Name
            foreach ($s in $sections) {
                $s = [double]$s
                for($i = 0; $i -lt $parsedFile."$($r)"."$($s)".Count; $i++) {
                    $a = [double]($parsedFile."$($r)"."$($s)"[$i])
                    $readableSize = "$($s)/$($a)R$($r)"
                    #working
                    $calculatedDiameter = [int][math]::Ceiling(($s * ($a / 100) * 2) + (25.4 * $r))

                    $informationGathered += [PSCustomObject]@{
                        Size = $readableSize
                        Diameter = $calculatedDiameter
                    }
                }
            }
        }
    }

    $output = $informationGathered | Sort-Object -Property Diameter | Format-Table -AutoSize
    return $output
}