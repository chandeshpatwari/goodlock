# Check if the 'apps.json' file exists
if (!(Test-Path "$PSScriptRoot\apps.json")) {
    Write-Host "The 'apps.json' file is missing. Exiting."
    Pause
    return
}

# Read data from 'apps.json' and convert it to a PowerShell object
$data = Get-Content "$PSScriptRoot\apps.json" | ConvertFrom-Json

# Define constants for URLs
$galaxyStore = 'https://galaxy.store/'
$apkmirrorBase = 'https://www.apkmirror.com/?post_type=app_release&searchtype=apk&s='
$android13Only = '&minapi-min=33&minapi-max=33'

# Define the HTML design
$htmlDesign = @'
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        background-color: black;
        color: white;
        font-family: JetBrains Mono; /* Change the font to Arial or any other preferred font */
    }
    a {
        color: #00BFFF;
        text-decoration: none;
    }
    a:hover {
        color: #1E90FF;
        text-decoration: underline;
    }
</style>
<title>Samsung Addons</title>
</head>
<body>
<h1>Samsung Addons</h1>
'@

# Generate content for all sections
$htmlContent = ''

$sections = $data.PSObject.Properties.Name

foreach ($section in $sections) {
    $htmlContent += @"
<h2>$section</h2>
<ul>
"@

    foreach ($item in $data.$section) {
        $htmlContent += @"
    <li> <a href='$galaxyStore$($item.StoreID)'>$($item.Name)</a> <a href='market://details?id=$($item.PackageName)'>[Store]</a> <a href='$apkmirrorBase$($item.PackageName)' target='_blank'>[ApkMirror]</a> <a href='$apkmirrorBase$($item.PackageName)$android13Only' target='_blank'>[A13]</a>: $($item.Description)</li>
"@
    }

    $htmlContent += '</ul>'
}

$htmlContent += @'
</body>
</html>
'@

# Combine the HTML design and content
$fullHTML = $htmlDesign + $htmlContent

# Save the HTML content to the specified directory and file
$fullHTML | Out-File "$PSScriptRoot\..\docs\index.html"
Write-Host 'HTML page generated and saved.'
