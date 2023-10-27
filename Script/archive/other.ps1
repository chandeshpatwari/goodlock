# Convert From Json To Csv
$data = Get-Content ..\apps.json | ConvertFrom-Json
$data.GoodLockModules | ConvertTo-Csv > .\csv\GoodLockModules.csv
$data.GoodGuardians | ConvertTo-Csv > .\csv\GoodGuardians.csv
$data.ZSOnly | ConvertTo-Csv > .\csv\ZSOnly.csv

# Convert From Csv To Json
$data = [PSCustomObject]@{}
$data | Add-Member -MemberType NoteProperty -Name 'GoodLockModules' -Value (Get-Content .\csv\GoodLockModules.csv | ConvertFrom-Csv)
$data | Add-Member -MemberType NoteProperty -Name 'GoodGuardians' -Value (Get-Content .\csv\GoodGuardians.csv | ConvertFrom-Csv)
$data | Add-Member -MemberType NoteProperty -Name 'ZSOnly' -Value (Get-Content .\csv\ZSOnly.csv | ConvertFrom-Csv)
$data | ConvertTo-Json -Depth 50 > test.json