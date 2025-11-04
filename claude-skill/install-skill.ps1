# Installation script for PDCA Framework Claude Skill (PowerShell)
# Installs the skill for use with Claude Code CLI on Windows

param(
    [Parameter(Position=0)]
    [ValidateSet("personal", "p", "project", "proj")]
    [string]$InstallType = "personal"
)

$ErrorActionPreference = "Stop"

# Colors for output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

# Determine installation type
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkillFile = Join-Path $ScriptDir "pdca-framework.skill"

Write-ColorOutput "`nPDCA Framework Skill Installer for Claude Code" "Cyan"
Write-ColorOutput ""

# Validate skill file exists
if (-not (Test-Path $SkillFile)) {
    Write-ColorOutput "Error: Skill file not found: $SkillFile" "Red"
    Write-ColorOutput "Please run .\build-skill.sh first to create the skill package." "Yellow"
    exit 1
}

# Determine installation directory
switch ($InstallType) {
    { $_ -in "personal", "p" } {
        $InstallDir = Join-Path $env:USERPROFILE ".claude\skills\pdca-framework"
        $Scope = "Personal"
        $ScopeDesc = "Available across all your projects"
    }
    { $_ -in "project", "proj" } {
        $InstallDir = Join-Path (Get-Location) ".claude\skills\pdca-framework"
        $Scope = "Project"
        $ScopeDesc = "Available in current project, shared via git"
    }
}

Write-ColorOutput "Installation Type: " "Cyan" -NoNewline
Write-ColorOutput $Scope
Write-ColorOutput "Installation Path: " "Cyan" -NoNewline
Write-ColorOutput $InstallDir
Write-ColorOutput "Scope: " "Cyan" -NoNewline
Write-ColorOutput $ScopeDesc
Write-ColorOutput ""

# Check if already installed
if (Test-Path $InstallDir) {
    Write-ColorOutput "Warning: Skill already installed at $InstallDir" "Yellow"
    $response = Read-Host "Overwrite existing installation? (y/N)"
    if ($response -notmatch "^[Yy]$") {
        Write-ColorOutput "Installation cancelled."
        exit 0
    }
    Write-ColorOutput "Removing existing installation..." "Cyan"
    Remove-Item -Path $InstallDir -Recurse -Force
}

# Create installation directory
Write-ColorOutput "Creating installation directory..." "Cyan"
New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null

# Extract skill package
Write-ColorOutput "Extracting skill package..." "Cyan"
try {
    # Use .NET to extract (works on all PowerShell versions)
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($SkillFile, $InstallDir)
}
catch {
    Write-ColorOutput "Error: Failed to extract skill package" "Red"
    Write-ColorOutput $_.Exception.Message "Red"
    exit 1
}

# Verify installation
if (-not (Test-Path (Join-Path $InstallDir "SKILL.md"))) {
    Write-ColorOutput "Error: Installation failed - SKILL.md not found" "Red"
    exit 1
}

Write-ColorOutput "`n✓ Installation complete!" "Green"
Write-ColorOutput ""

# Show what was installed
Write-ColorOutput "Installed files:" "Cyan"
Get-ChildItem -Path $InstallDir -Recurse -File | ForEach-Object {
    $relativePath = $_.FullName.Replace($InstallDir, "")
    Write-ColorOutput "  $relativePath"
}

Write-ColorOutput ""
Write-ColorOutput "Success! The PDCA framework skill is now available in Claude Code." "Green"
Write-ColorOutput ""

# Provide scope-specific next steps
if ($InstallType -in "personal", "p") {
    Write-ColorOutput "Next Steps:" "Cyan"
    Write-ColorOutput "1. The skill is automatically discovered by Claude Code"
    Write-ColorOutput "2. Start a coding session: claude-code"
    Write-ColorOutput "3. Claude will use the skill when appropriate"
    Write-ColorOutput ""
    Write-ColorOutput "Test it:" "Cyan"
    Write-ColorOutput "   claude-code 'Show me the PDCA analysis phase prompt'"
}
else {
    Write-ColorOutput "Next Steps:" "Cyan"
    Write-ColorOutput "1. Commit the skill to share with your team:"
    Write-ColorOutput "   git add .claude/skills/"
    Write-ColorOutput "   git commit -m 'Add PDCA framework skill'"
    Write-ColorOutput ""
    Write-ColorOutput "2. The skill is automatically discovered by Claude Code"
    Write-ColorOutput "3. Team members who pull will get the skill automatically"
    Write-ColorOutput ""
    Write-ColorOutput "Test it:" "Cyan"
    Write-ColorOutput "   claude-code 'Show me the PDCA analysis phase prompt'"
}

Write-ColorOutput ""
Write-ColorOutput "Documentation:" "Cyan"
Write-ColorOutput "  README: $ScriptDir\README.md"
Write-ColorOutput "  Build:  $ScriptDir\BUILD.md"
Write-ColorOutput ""
Write-ColorOutput "Uninstall:" "Cyan"
Write-ColorOutput "  Remove-Item -Path '$InstallDir' -Recurse -Force"
Write-ColorOutput ""
