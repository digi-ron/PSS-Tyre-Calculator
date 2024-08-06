$parsedFile = Get-Content -Path .\sizes.json | ConvertFrom-Json
$radius = Read-Host -Prompt "Enter rim radius (0 for all)"
$informationGathered = @()

$radii = ($parsedFile | Get-Member -MemberType NoteProperty).Name

foreach ($r in $radii) {
    if ($radius -eq "0" -or $r -eq $radius) {
        $aspects = ($parsedFile."$($r)" | Get-Member -MemberType NoteProperty).Name
        foreach ($a in $aspects) {
            for($i = 0; $i -lt $parsedFile."$($r)"."$($a)".Count; $i++) {
                Write-Output "$($a)/$($parsedFile."$($r)"."$($a)"[$i])R$($r)"
            }
        }
    }
}