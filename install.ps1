Write-Host "Starting lazy-nyaa installation for Windows..." -ForegroundColor Cyan

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ZipUrl = "https://github.com/Asad-Naseer/lazy-nyaa/releases/download/V1.1/lazy-nyaa-windows-x64.zip"
$ZipName = "lazy-nyaa-windows-x64.zip"
$ZipPath = Join-Path $DesktopPath $ZipName
$ExtractFolderName = "lazy-nyaa-windows-x64"
$ExtractedFolderPath = Join-Path $DesktopPath $ExtractFolderName
$ExePath = Join-Path $ExtractedFolderPath "lazy-nyaa.exe"

# 1. Download
Write-Host "--> Downloading $ZipName to Desktop..."
Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath
Write-Host "    Download complete." -ForegroundColor Green

# 2. Extract
Write-Host "--> Extracting $ZipName..."
# We extract to Desktop. Since the zip contains the 'lazy-nyaa-windows-x64' folder, it will unpack perfectly into it.
Expand-Archive -Path $ZipPath -DestinationPath $DesktopPath -Force
Write-Host "    Extraction complete." -ForegroundColor Green

# 3. Setup Bin and PATH
Write-Host "--> Creating $HOME\bin directory..."
New-Item -ItemType Directory -Force -Path "$HOME\bin" | Out-Null

Write-Host "--> Copying lazy-nyaa.exe to $HOME\bin..."
Copy-Item -Path $ExePath -Destination "$HOME\bin\" -Force

Write-Host "--> Adding $HOME\bin to your User PATH..."
$CurrentPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
if ($CurrentPath -notmatch "$HOME\\bin") {
    [System.Environment]::SetEnvironmentVariable("PATH", $CurrentPath + ";$HOME\bin", "User")
    Write-Host "    PATH updated successfully." -ForegroundColor Green
} else {
    Write-Host "    $HOME\bin is already in your PATH." -ForegroundColor Yellow
}

# 4. Clean up
Write-Host "--> Cleaning up Desktop files..."
Remove-Item -Path $ZipPath -Force
Remove-Item -Path $ExtractedFolderPath -Recurse -Force
Write-Host "    Cleanup complete." -ForegroundColor Green

Write-Host "`nInstallation Finished! lazy-nyaa is now installed." -ForegroundColor Cyan
Write-Host "NOTE: You must restart your current PowerShell window for the PATH changes to take effect." -ForegroundColor Yellow
