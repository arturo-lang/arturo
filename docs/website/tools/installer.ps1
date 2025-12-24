######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2025 Yanis Zafirópulos
#
# @file: installer.ps1
######################################################

$ErrorActionPreference = "Stop"

################################################
# CONSTANTS
################################################

$BASE_URL = "http://188.245.97.105"
$INSTALL_DIR = "$env:USERPROFILE\.arturo"
$BIN_DIR = "$INSTALL_DIR\bin"
$TMP_DIR = ""

$VERSION_TYPE = "latest"
$BUILD_VARIANT = "full"

# Parse arguments
foreach ($arg in $args) {
    if ($arg -eq "--mini" -or $arg -eq "-m") {
        $BUILD_VARIANT = "mini"
    }
}

################################################
# COLORS
################################################

function Write-Color {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color -NoNewline
}

function Write-ColorLine {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

function Write-Error-Custom {
    param([string]$Message)
    Write-ColorLine " X $Message" "Red"
    exit 1
}

function Write-Info {
    param([string]$Message)
    Write-ColorLine "      $Message" "DarkGray"
}

function Write-Info-NoNewline {
    param([string]$Message)
    Write-Color "      $Message" "DarkGray"
}

function Write-Section {
    param([string]$Message)
    Write-Host " "
    Write-Color " * " "Magenta"
    Write-ColorLine $Message "White"
}

################################################
# UTILITIES
################################################

function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

function Get-WebContent {
    param(
        [string]$Url,
        [string]$OutFile
    )
    
    try {
        if ($OutFile) {
            Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
        } else {
            # Use Invoke-RestMethod for plain text to avoid encoding issues
            $content = Invoke-RestMethod -Uri $Url
            return $content.Trim()
        }
    } catch {
        throw "Download failed: $_"
    }
}

function Show-Header {
    Write-ColorLine "              _                    " "Green"
    Write-ColorLine "             | |                   " "Green"
    Write-ColorLine "    __ _ _ __| |_ _   _ _ __ ___   " "Green"
    Write-ColorLine "   / _`` | '__| __| | | | '__/ _ \  " "Green"
    Write-ColorLine "  | (_| | |  | |_| |_| | | | (_) | " "Green"
    Write-ColorLine "   \__,_|_|   \__|\__,_|_|  \___/  " "Green"
    Write-ColorLine "   (c)2019-2025 Yanis Zafiropulos" "Green"
    Write-ColorLine " " "Cyan"
    Write-ColorLine "=======================================================" "Cyan"
    Write-ColorLine " > Installer" "Cyan"
    Write-ColorLine "=======================================================" "Cyan"
}

function Show-Footer {
    Write-ColorLine " " "Cyan"
    Write-ColorLine "=======================================================" "Cyan"
    Write-ColorLine " > Quick setup" "Cyan"
    Write-ColorLine "=======================================================" "Cyan"
    Write-ColorLine " " "White"
    Write-ColorLine "   Arturo has been successfully installed!" "White"
    Write-ColorLine "  " "White"
    Write-ColorLine "   To be able to run it from anywhere," "White"
    Write-ColorLine "   update your `$PATH:" "White"
    Write-ColorLine "       `$env:PATH = `"`$env:USERPROFILE\.arturo\bin;`$env:PATH`"" "DarkGray"
    Write-ColorLine "  " "White"
    Write-ColorLine "   Add it to your PowerShell profile" "White"
    Write-ColorLine "   to set it automatically on every session." "White"
    Write-ColorLine "  " "White"
    
    if ($script:MISSING_PACKAGES) {
        Write-ColorLine "   Missing dependencies:" "White"
        Write-ColorLine "       $script:MISSING_PACKAGES" "DarkGray"
        Write-ColorLine "  " "White"
    }
    
    Write-ColorLine "   Rock on!" "White"
    Write-ColorLine " " "White"
}

################################################
# DETECTION
################################################

function Detect-System {
    # Determine OS and Architecture
    $script:OS = "windows"
    
    if ([Environment]::Is64BitOperatingSystem) {
        $script:ARCH = "amd64"
    } else {
        Write-Error-Custom "32-bit Windows is not supported"
    }
    
    # Determine shell
    $script:SHELL_RC = "`$PROFILE (PowerShell profile)"
    
    # Check for download capability (PowerShell has Invoke-WebRequest built-in)
    $script:DOWNLOAD_TOOL = "Invoke-WebRequest"
    
    Write-Info "os: $script:OS"
    Write-Info "arch: $script:ARCH"
    Write-Info "shell: PowerShell"
    Write-Info "downloader: $script:DOWNLOAD_TOOL"
}

################################################
# DEPENDENCIES
################################################

function Check-Dependencies {
    if ($BUILD_VARIANT -ne "full") {
        return
    }
    
    # Windows binaries are typically self-contained
    # No external dependencies needed for the full build
    $script:MISSING_PACKAGES = ""
}

################################################
# DOWNLOAD & INSTALL
################################################

function Get-Version {
    $path = if ($VERSION_TYPE -eq "latest") { "latest/" } else { "" }
    $version_url = "$BASE_URL/${path}files/VERSION"
    
    try {
        $script:VERSION = (Get-WebContent -Url $version_url).Trim()
        Write-Info "version: $script:VERSION"
    } catch {
        Write-Error-Custom "Could not fetch version information"
    }
}

function Download-Arturo {
    $ARTIFACT_NAME = "arturo-$script:VERSION-$script:OS-$script:ARCH"
    if ($BUILD_VARIANT -ne "full") {
        $ARTIFACT_NAME = "$ARTIFACT_NAME-$BUILD_VARIANT"
    }
    
    # Create temporary directory
    $script:TMP_DIR = Join-Path $env:TEMP "arturo-install-$(Get-Random)"
    New-Item -ItemType Directory -Path $script:TMP_DIR -Force | Out-Null
    
    $path = if ($VERSION_TYPE -eq "latest") { "latest/" } else { "" }
    $url = "$BASE_URL/${path}files/${ARTIFACT_NAME}.zip"
    
    Write-Info-NoNewline "archive: ${path}files/${ARTIFACT_NAME}.zip"
    Write-Host " "
    
    $zipPath = Join-Path $script:TMP_DIR "arturo.zip"
    
    try {
        Get-WebContent -Url $url -OutFile $zipPath
    } catch {
        Write-Error-Custom "Download failed. Something went wrong, please check your connection."
    }
    
    # Extract archive
    try {
        Expand-Archive -Path $zipPath -DestinationPath $script:TMP_DIR -Force
    } catch {
        Write-Error-Custom "Failed to extract archive"
    }
}

function Install-Arturo {
    Write-Info "into: $BIN_DIR"
    
    # Create installation directory
    if (-not (Test-Path $BIN_DIR)) {
        try {
            New-Item -ItemType Directory -Path $BIN_DIR -Force | Out-Null
        } catch {
            Write-Error-Custom "Could not create installation directory"
        }
    }
    
    # Copy files
    $filesToCopy = @(
        @{ Source = "arturo.exe"; Required = $true }
        @{ Source = "cacert.pem"; Required = $false }
    )
    
    $foundBinary = $false
    
    foreach ($file in $filesToCopy) {
        $sourcePath = Join-Path $script:TMP_DIR $file.Source
        if (Test-Path $sourcePath) {
            try {
                Copy-Item -Path $sourcePath -Destination $BIN_DIR -Force
                if ($file.Source -eq "arturo.exe") {
                    $foundBinary = $true
                }
            } catch {
                Write-Error-Custom "Failed to copy $($file.Source)"
            }
        } elseif ($file.Required) {
            Write-Error-Custom "$($file.Source) not found in archive"
        }
    }
    
    # Copy DLL files if present
    $dllFiles = Get-ChildItem -Path $script:TMP_DIR -Filter "*.dll" -ErrorAction SilentlyContinue
    if ($dllFiles) {
        foreach ($dll in $dllFiles) {
            try {
                Copy-Item -Path $dll.FullName -Destination $BIN_DIR -Force
            } catch {
                Write-Error-Custom "Failed to copy DLL files"
            }
        }
    }
    
    if (-not $foundBinary) {
        Write-Error-Custom "Binary not found in archive"
    }
}

function Cleanup {
    if ($script:TMP_DIR -and (Test-Path $script:TMP_DIR)) {
        try {
            Remove-Item -Path $script:TMP_DIR -Recurse -Force -ErrorAction SilentlyContinue
        } catch {
            # Ignore cleanup errors
        }
    }
}

################################################
# MAIN
################################################

function Main {
    try {
        Show-Header
        
        Write-Section "Checking environment..."
        Detect-System
        
        Write-Section "Resolving version..."
        Get-Version
        
        Write-Section "Downloading..."
        Download-Arturo
        
        Write-Section "Checking dependencies..."
        Check-Dependencies
        
        Write-Section "Installing..."
        Install-Arturo
        
        Write-Section "Done!"
        Show-Footer
    } finally {
        Cleanup
    }
}

# Run main function
Main