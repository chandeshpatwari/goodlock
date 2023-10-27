if (!(Test-Path "$PSScriptRoot\apps.json")) {
    Pause
    return
} else {
    $data = Get-Content "$PSScriptRoot\apps.json" | ConvertFrom-Json

    $galaxystore = 'https://galaxy.store/'
    $apkmirrorbase = 'https://www.apkmirror.com/?post_type=app_release&searchtype=apk&s='
    $android13only = '&minapi-min=33&minapi-max=33'

    # Create an HTML content string
    $htmlContent = @'
<!DOCTYPE html>
<html>
<head>
<title>Samsung Addons</title>
</head>
<body>
<h1>Samsung Addons</h1>
'@

    # Generate content for all sections
    $sections = @('Good Lock', 'Good Guardians', 'Z and S Series Exclusive')
    foreach ($section in $sections) {
        $htmlContent += @"
<h2>$section</h2>
<ul>
"@

        $sectionData = $data.($section -replace ' ', '')

        foreach ($item in $sectionData) {
            $htmlContent += @"
    <li> <a href='$galaxystore$($item.StoreID)'>$($item.Name)</a> <a href='market://details?id=$($item.PackageName)'>[AppStore]</a> <a href='$apkmirrorbase$($item.PackageName)'>[ApkMirror]</a> <a href='$apkmirrorbase$($item.PackageName)$android13only'>[ApkMirror Android 13]</a>: $($item.Description)</li>
"@
        }

        $htmlContent += '</ul>'
    }

    $htmlContent += @'
</body>
</html>
'@

    # Write the HTML content to a file
    $htmlContent | Out-File "$PSScriptRoot\..\docs\index.html"
}
