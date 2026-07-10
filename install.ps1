<#
.SYNOPSIS
    Installs HoldMyBeer into the config directory of one or more supported
    AI coding assistants (Claude Code, Gemini CLI, Codex CLI).

.PARAMETER Platform
    Which platform(s) to install for: claude (default), gemini, codex, or all.
    Cursor is not installed by this script - its rules are project-scoped by
    convention; copy cursor/rules/*.mdc into your project's own
    .cursor/rules/ directory manually.

.PARAMETER Force
    Overwrite files that already exist at the destination. Without this
    switch, existing files are left untouched and reported as skipped.

.PARAMETER TargetHome
    Override the home directory used to locate ~/.claude, ~/.gemini, and
    ~/.codex. Defaults to $HOME.

.EXAMPLE
    .\install.ps1
    .\install.ps1 -Platform all
    .\install.ps1 -Platform gemini -Force
#>

param(
    [ValidateSet("claude", "gemini", "codex", "all")]
    [string]$Platform = "claude",

    [switch]$Force,

    [string]$TargetHome = $HOME
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

$installedItems = @()
$skippedItems = @()

function Copy-SkillFolder {
    param([string]$SourceDir, [string]$DestParentDir, [string]$Name)

    $destDir = Join-Path $DestParentDir $Name
    if ((Test-Path $destDir) -and (-not $Force)) {
        $script:skippedItems += "$destDir (already exists, use -Force to overwrite)"
        return
    }
    New-Item -ItemType Directory -Force -Path $DestParentDir | Out-Null
    Copy-Item -Path $SourceDir -Destination $destDir -Recurse -Force
    $script:installedItems += $destDir
}

function Copy-SingleFile {
    param([string]$SourceFile, [string]$DestDir)

    $fileName = Split-Path -Leaf $SourceFile
    $destFile = Join-Path $DestDir $fileName
    if ((Test-Path $destFile) -and (-not $Force)) {
        $script:skippedItems += "$destFile (already exists, use -Force to overwrite)"
        return
    }
    New-Item -ItemType Directory -Force -Path $DestDir | Out-Null
    Copy-Item -Path $SourceFile -Destination $destFile -Force
    $script:installedItems += $destFile
}

function Install-Claude {
    Write-Host "Installing HoldMyBeer for Claude Code..." -ForegroundColor Cyan
    $claudeDir = Join-Path $TargetHome ".claude"
    if (-not (Test-Path $claudeDir)) {
        Write-Host "  Note: $claudeDir does not exist yet - creating it." -ForegroundColor Yellow
    }

    $skillsSrc = Join-Path $RepoRoot "claude\skills"
    $skillsDest = Join-Path $claudeDir "skills"
    Get-ChildItem -Path $skillsSrc -Directory | ForEach-Object {
        Copy-SkillFolder -SourceDir $_.FullName -DestParentDir $skillsDest -Name $_.Name
    }

    $cmdSrc = Join-Path $RepoRoot "claude\commands"
    $cmdDest = Join-Path $claudeDir "commands"
    Get-ChildItem -Path $cmdSrc -Filter "*.md" | ForEach-Object {
        Copy-SingleFile -SourceFile $_.FullName -DestDir $cmdDest
    }
}

function Install-Gemini {
    Write-Host "Installing HoldMyBeer for Gemini CLI..." -ForegroundColor Cyan
    $geminiDir = Join-Path $TargetHome ".gemini"
    $cmdSrc = Join-Path $RepoRoot "gemini\commands"
    $cmdDest = Join-Path $geminiDir "commands"
    Get-ChildItem -Path $cmdSrc -Filter "*.toml" | ForEach-Object {
        Copy-SingleFile -SourceFile $_.FullName -DestDir $cmdDest
    }
}

function Install-Codex {
    Write-Host "Installing HoldMyBeer for Codex CLI..." -ForegroundColor Cyan
    $codexDir = Join-Path $TargetHome ".codex"
    $skillsSrc = Join-Path $RepoRoot "codex\skills"
    $skillsDest = Join-Path $codexDir "skills"
    Get-ChildItem -Path $skillsSrc -Directory | ForEach-Object {
        Copy-SkillFolder -SourceDir $_.FullName -DestParentDir $skillsDest -Name $_.Name
    }
}

function Install-CLI {
    Write-Host "Installing HoldMyBeer global CLI command..." -ForegroundColor Cyan
    $localBinDir = Join-Path $TargetHome ".local\bin"
    Copy-SingleFile -SourceFile (Join-Path $RepoRoot "bin\holdmybeer-init.ps1") -DestDir $localBinDir
    Copy-SingleFile -SourceFile (Join-Path $RepoRoot "bin\holdmybeer-init.cmd") -DestDir $localBinDir
}

switch ($Platform) {
    "claude" { Install-Claude; Install-CLI }
    "gemini" { Install-Gemini; Install-CLI }
    "codex"  { Install-Codex; Install-CLI }
    "all"    { Install-Claude; Install-Gemini; Install-Codex; Install-CLI }
}

Write-Host ""
Write-Host "===== HoldMyBeer install summary =====" -ForegroundColor Green
if ($installedItems.Count -gt 0) {
    Write-Host "Installed:" -ForegroundColor Green
    $installedItems | ForEach-Object { Write-Host "  + $_" }
} else {
    Write-Host "Nothing new installed." -ForegroundColor Yellow
}
if ($skippedItems.Count -gt 0) {
    Write-Host "Skipped (use -Force to overwrite):" -ForegroundColor Yellow
    $skippedItems | ForEach-Object { Write-Host "  - $_" }
}
Write-Host ""
Write-Host "Done. Restart your CLI session if it was already running so it picks up the new skills/commands." -ForegroundColor Green

