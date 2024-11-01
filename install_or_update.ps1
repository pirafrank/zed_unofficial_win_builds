### VARIABLES ###

# Define URL and the target directories
$repoUrlBasePath = "https://github.com/pirafrank/zed_unofficial_win_builds/releases/latest/download/"
$tempDir = "$env:TEMP\zed_temp"
$targetDir = "$env:LocalAppData\Programs\Zed"
$targetShortcutDir = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Zed"
$targetShortcutFile = "$targetShortcutDir\Zed.lnk"

### FUNCTIONS ###

# Define a function to download an artifact
function Get-Artifact {
  param (
    [string]$fileName,
    [string]$repoUrl
  )

  # Define the path for the downloaded file
  $tempFile = Join-Path -Path $tempDir -ChildPath $fileName

  # Download the latest artifact
  Invoke-WebRequest -Uri $repoUrl -OutFile $tempFile
}

function Create-Shortcut {
  # Test target dir
  if (-not (Test-Path -Path $targetShortcutDir) -or -not (Test-Path -Path $targetShortcutFile)) {
    New-Item -ItemType Directory -Path $targetShortcutDir -Force
  }

  # Creeate a shortcut to Zed
  $WshShell = New-Object -comObject WScript.Shell
  $Shortcut = $WshShell.CreateShortcut("$targetShortcutDir\Zed.lnk")
  $Shortcut.TargetPath = "$env:LocalAppData\Programs\Zed\zed.exe"
  $Shortcut.Save()
  Write-Output "Shortcut created."
}

### SCRIPT ###

# Check if zed.exe process is running, if yes, prompt the user about it and exit
if (Get-Process -Name zed -ErrorAction SilentlyContinue) {
  Write-Error "Zed is running. Please close it before updating."
  Exit
}

# Create dirs if they don't exist
if (-not (Test-Path -Path $tempDir)) {
  New-Item -ItemType Directory -Path $tempDir
}
if (-not (Test-Path -Path $targetDir)) {
  New-Item -ItemType Directory -Path $targetDir
}

# Download the latest artifact and its checksum
$repoUrl = $repoUrlBasePath + "zed.zip"
Get-Artifact -fileName "zed.zip" -repoUrl $repoUrl

$repoUrl = $repoUrlBasePath + "zed.zip.sha256"
Get-Artifact -fileName "zed.zip.sha256" -repoUrl $repoUrl

# Verify the downloaded file against the SHA256 checksum
$downloadedFile = Join-Path -Path $tempDir -ChildPath "zed.zip"
$checksumFile = Join-Path -Path $tempDir -ChildPath "zed.zip.sha256"

# Read the expected checksum
$expectedChecksum = (Get-Content -Path $checksumFile).Split(" ")[0]

# Calculate the actual checksum of the downloaded file
$actualChecksum = Get-FileHash -Path $downloadedFile -Algorithm SHA256 | Select-Object -ExpandProperty Hash

# Case-insensitive checksums compare
if ($expectedChecksum.ToUpper() -eq $actualChecksum.ToUpper()) {
  Write-Output "Checksum verification successful."
} else {
  Write-Error "Checksum verification failed."
  Exit
}

# Check if the download was successful
$tempFile = Join-Path -Path $tempDir -ChildPath "zed.zip"
$targetFile = Join-Path -Path $targetDir -ChildPath "zed.exe"
if (Test-Path -Path $tempFile) {
  # Extract the downloaded zip file
  Expand-Archive -Path $tempFile -DestinationPath $targetDir -Force
  if (Test-Path -Path $targetFile) {
    Write-Output "Extracted to install directory successfully."
    Create-Shortcut
    Write-Output "Installation complete."
  } else {
    Write-Error "Extraction failed."
  }
}
else {
  Write-Error "Download failed. Installation aborted."
}
