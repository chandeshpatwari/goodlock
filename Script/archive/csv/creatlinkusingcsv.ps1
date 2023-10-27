$data = [PSCustomObject]@{}
$data | Add-Member -MemberType NoteProperty -Name 'GoodLockModules' -Value (Get-Content .\GoodLockModules.csv | ConvertFrom-Csv)
$data | Add-Member -MemberType NoteProperty -Name 'GoodGuardians' -Value (Get-Content .\GoodGuardians.csv | ConvertFrom-Csv)
$data | Add-Member -MemberType NoteProperty -Name 'ZSOnly' -Value (Get-Content .\ZSOnly.csv | ConvertFrom-Csv)

$galaxystore = 'https://galaxy.store/'
$apkmirrorbase = 'https://www.apkmirror.com/?post_type=app_release&searchtype=apk&s='
$android13only = '&minapi-min=33&minapi-max=33'

$galaxystore = 'https://galaxy.store/'
$apkmirrorbase = 'https://www.apkmirror.com/?post_type=app_release&searchtype=apk&s='

Write-Output '# Samsung Addons' | Out-File $PSScriptRoot\samsung-goodlock.md

Write-Output '## Good Lock' | Out-File $PSScriptRoot\samsung-goodlock.md -Append
$data.GoodLockModules | ForEach-Object { 
    '- [' + $_.Name + '](' + $galaxystore + $_.StoreID + ') [`[AppStore]`](market://details?id=' + $_.PackageName + ')  [`[ApkMirror]`](' + $apkmirrorbase + $_.PackageName + ') [`[ApkMirror Android 13]`](' + $apkmirrorbase + $_.PackageName + $android13only + ')' + ': ' + $_.Description
} | Out-File $PSScriptRoot\samsung-goodlock.md -Append

Write-Output '## Good Guardians' | Out-File $PSScriptRoot\samsung-goodlock.md -Append
$data.GoodGuardians | ForEach-Object { 
    '- [' + $_.Name + '](' + $galaxystore + $_.StoreID + ') [`[AppStore]`](market://details?id=' + $_.PackageName + ')  [`[ApkMirror]`](' + $apkmirrorbase + $_.PackageName + ') [`[ApkMirror Android 13]`](' + $apkmirrorbase + $_.PackageName + $android13only + ')' + ': ' + $_.Description
} | Out-File $PSScriptRoot\samsung-goodlock.md -Append

Write-Output '## Z and S Series Exclusive' | Out-File $PSScriptRoot\samsung-goodlock.md -Append
$data.ZSOnly | ForEach-Object { 
    '- [' + $_.Name + '](' + $galaxystore + $_.StoreID + ') [`[AppStore]`](market://details?id=' + $_.PackageName + ')  [`[ApkMirror]`](' + $apkmirrorbase + $_.PackageName + ') [`[ApkMirror Android 13]`](' + $apkmirrorbase + $_.PackageName + $android13only + ')' + ': ' + $_.Description
} | Out-File $PSScriptRoot\samsung-goodlock.md -Append
