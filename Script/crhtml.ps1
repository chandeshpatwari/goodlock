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
<title>Samsung OneUI Addons</title>
</head>
<body>
<h1>Samsung OneUI Addons</h1>
'@

# Generate content for all sections
$htmlContent = "`n"
$htmlContent += '<a href="market://details?id=yuh.yuh.finelock">Fine Lock: Launcher</a>'
$htmlContent += "`n"
foreach ($section in $data.PSObject.Properties.Name) {
    $htmlContent += @"
<h2>$section</h2>
<ul>
"@
    $htmlContent += $data.$section | ForEach-Object {
        "<li> <a href='$galaxyStore$($_.StoreID)'>$($_.Name)</a> <a href='market://details?id=$($_.PackageName)'>[Store]</a> <a href='$apkmirrorBase$($_.PackageName)' target='_blank'>[ApkMirror]</a> <a href='$apkmirrorBase$($_.PackageName)$android13Only' target='_blank'>[A13]</a>: $($_.Description)</li>"
    }
    $htmlContent += "</ul>`n"
}

$htmlContent += @'
</body>
</html>
'@

# Combine the HTML design and content
$fullHTML = $htmlDesign + $htmlContent

# Save the HTML content to the specified directory and file
$fullHTML | Out-File "$PSScriptRoot\..\docs\index.html"
Write-Host 'HTML page generated and saved.' -ForegroundColor Green