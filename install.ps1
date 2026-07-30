Write-Host "Starting lazy-nyaa installation for Windows..." -ForegroundColor Cyan

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$TempWorkspace = Join-Path $DesktopPath "lazy-nyaa-temp-installer"
$ZipUrl = "https://github.com/Asad-Naseer/lazy-nyaa/releases/download/V1.1/lazy-nyaa-windows-x64.zip"
$ZipName = "lazy-nyaa-windows-x64.zip"
$ZipPath = Join-Path $TempWorkspace $ZipName

# Create temp workspace on desktop
New-Item -ItemType Directory -Force -Path $TempWorkspace | Out-Null

# 1. Download
Write-Host "--> Downloading $ZipName..."
Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath
Write-Host "    Download complete." -ForegroundColor Green

# 2. Extract
Write-Host "--> Extracting $ZipName..."
Expand-Archive -Path $ZipPath -DestinationPath $TempWorkspace -Force
Write-Host "    Extraction complete." -ForegroundColor Green

# 3. Setup Bin and PATH
Write-Host "--> Creating $HOME\bin directory..."
New-Item -ItemType Directory -Force -Path "$HOME\bin" | Out-Null

Write-Host "--> Locating lazy-nyaa.exe and copying to $HOME\bin..."
# Find the exe no matter if it extracted with a wrapper folder or not
$ExeFile = Get-ChildItem -Path $TempWorkspace -Recurse -Filter "lazy-nyaa.exe" | Select-Object -First 1

if ($null -eq $ExeFile) {
    Write-Host "Error: Could not find lazy-nyaa.exe in the downloaded archive." -ForegroundColor Red
    Remove-Item -Path $TempWorkspace -Recurse -Force
    exit
}

Copy-Item -Path $ExeFile.FullName -Destination "$HOME\bin\" -Force

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
Remove-Item -Path $TempWorkspace -Recurse -Force
Write-Host "    Cleanup complete." -ForegroundColor Green

Write-Host "`nInstallation Finished! lazy-nyaa is now installed." -ForegroundColor Cyan
Write-Host "NOTE: You must restart your current PowerShell window for the PATH changes to take effect." -ForegroundColor Yellow