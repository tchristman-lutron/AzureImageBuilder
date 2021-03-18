Write-Output 'Start 7-Zip Install'
$BuildDir = 'c:\BuildDir'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
$allVersions = Get-7zip
$mostRecent = $allVersions | Sort-Object -Descending -Property 'Version' | Select-Object -First 1 | Select-Object -ExpandProperty 'Version'
$allOnVersion = $allVersions | Where-Object { $_.version -eq $mostRecent }
$myVersion = $allOnVersion | Where-Object { $_.Architecture -eq 'x64' -and $_.URI -like "*.msi" }
$fileName = Split-Path $myVersion.uri -Leaf
$outFile = Join-Path $BuildDir $fileName
if (-not(Test-Path $outFile)) {
    Invoke-WebRequest $myVersion.uri -OutFile $outFile
}
Start-Process -FilePath msiexec.exe -Argument "/i $outFile /qn" -Wait
Remove-Item $outFile
Write-Output '7-Zip Installed'
