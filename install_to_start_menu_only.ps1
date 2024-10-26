### VARIABLES ###

$targetShortcutDir = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Zed"
$targetShortcutFile = "$targetShortcutDir\Zed.lnk"

### SCRIPT ###

# Test target dir
if (-not (Test-Path -Path $targetShortcutDir) -or -not (Test-Path -Path $targetShortcutFile)) {
  New-Item -ItemType Directory -Path $targetShortcutDir -Force
}

# Creeate a shortcut to Zed
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$targetShortcutDir\Zed.lnk")
$Shortcut.TargetPath = "$env:LocalAppData\Programs\Zed\zed.exe"
$Shortcut.Save()
