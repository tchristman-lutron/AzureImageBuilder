Write-Output 'EverGreen Install Started'
$BuildDir = 'c:\BuildDir'
if (-not(Test-Path $BuildDir)) {
    New-Item  -ItemType Directory $BuildDir
}
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force | Out-Null
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted  | Out-Null
Install-Module EverGreen
Write-Output 'EverGreen Installed'
