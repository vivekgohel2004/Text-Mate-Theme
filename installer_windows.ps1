#!/usr/bin/env pwsh
# Requires PowerShell 7+!
# TODO: Find out why the theme does not install. 
# TODO: Improve the way the script checks if sublime text is installed  
$GREEN = "`e[32m"
$YELLOW = "`e[33m"
$MAGENTA = "`e[35m"
$RESET = "`e[0m"
$INSTALL_PATH = "%AppData%\Sublime Text\Packages\User\"
$THEME_URL = "https://raw.githubusercontent.com/vivekgohel2004/Text-Mate-Theme/main/Text-Mate.sublime-color-scheme"
$THEME_FILE = "Text-Mate.sublime-color-scheme"

function Show-Animation {
    param (
        [int]$Dots = 5,
        [int]$Delay = 400
    )

    for ($i = 1; $i -le $Dots; $i++) {
        Write-Host -NoNewline "."
        Start-Sleep -Milliseconds $Delay 
    }
}

Write-Host "$MAGENTA"
Write-Host "========================================"
Write-Host "      ████████ Text-Mate Theme ████████      "
Write-Host "========================================"
Write-Host "$RESET"

if (Test-Path -Path $INSTALL_PATH) {
    Write-Warning "Path exists! No need to install Sublime Text"
}
else {
    Write-Warning "Installing Sublime Text "
    Show-Animation
    winget install --id=SublimeHQ.SublimeText.4  -e
    if ($?) {
        # If command ran successfully 
        Write-Host "$GREEN"
        Write-Host "Sublime Text installed!"
        Write-Host $RESET
        Write-Warning "Please press Enter after going into Tools > Install Package Control"
        Read-Host
    }
}      


Write-Host -NoNewline "$YELLOW[~] Downloading theme"
Show-Animation

if (Test-Path ".\Text-Mate.sublime-color-scheme") {
    Copy-Item -Path  ".\Text-Mate.sublime-color-scheme" -Destination $INSTALL_PATH 
}
else {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/vivekgohel2004/Text-Mate-Theme/main/Text-Mate.sublime-color-scheme" -OutFile "Text-Mate.sublime-color-scheme"
    Copy-Item -Path  ".\Text-Mate.sublime-color-scheme" -Destination $INSTALL_PATH 
}

Write-Host "$RESET"
Write-Host "$GREEN"
Write-Host "========================================"
Write-Host " ✅ Installation Complete! "
Write-Host " 🎉 File installed at: $INSTALL_PATH"
Write-Host " ✨ Open Sublime Text → Preferences → Select Color Scheme → Text-Mate"
Write-Host "========================================"
Write-Host "$RESET"

