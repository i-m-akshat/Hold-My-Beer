<#
.SYNOPSIS
    Removes HoldMyBeer's skills/commands from one or more supported AI
    coding assistants. Only removes the exact set of files/folders HoldMyBeer
    installs - never wipes an entire skills/commands directory.

.PARAMETER Platform
    Which platform(s) to uninstall from: claude (default), gemini, codex, or all.

.PARAMETER TargetHome
    Override the home directory used to locate ~/.claude, ~/.gemini, and
    ~/.codex. Defaults to $HOME.

.EXAMPLE
    .\uninstall.ps1
    .\uninstall.ps1 -Platform all
#>

param(
    [ValidateSet("claude", "gemini", "codex", "all")]
    [string]$Platform = "claude",

    [string]$TargetHome = $HOME
)

$ErrorActionPreference = "Stop"
$SkillNames = @("holdmybeer-init", "holdmybeer-spec", "holdmybeer-plan", "holdmybeer-code", "holdmybeer-review")

$removedItems = @()
$notFoundItems = @()

function Remove-KnownFolder {
    param([string]$ParentDir, [string]$Name)

    $target = Join-Path $ParentDir $Name
    if (Test-Path $target) {
        Remove-Item -Path $target -Recurse -Force
        $script:removedItems += $target
    } else {
        $script:notFoundItems += $target
    }
}

function Remove-KnownFile {
    param([string]$ParentDir, [string]$FileName)

    $target = Join-Path $ParentDir $FileName
    if (Test-Path $target) {
        Remove-Item -Path $target -Force
        $script:removedItems += $target
    } else {
        $script:notFoundItems += $target
    }
}

function Uninstall-Claude {
    Write-Host "Uninstalling HoldMyBeer from Claude Code..." -ForegroundColor Cyan
    $claudeDir = Join-Path $TargetHome ".claude"
    $skillsDest = Join-Path $claudeDir "skills"
    $cmdDest = Join-Path $claudeDir "commands"
    foreach ($name in $SkillNames) {
        Remove-KnownFolder -ParentDir $skillsDest -Name $name
        Remove-KnownFile -ParentDir $cmdDest -FileName "$name.md"
    }
}

function Uninstall-Gemini {
    Write-Host "Uninstalling HoldMyBeer from Gemini CLI..." -ForegroundColor Cyan
    $geminiDir = Join-Path $TargetHome ".gemini"
    $cmdDest = Join-Path $geminiDir "commands"
    foreach ($name in $SkillNames) {
        Remove-KnownFile -ParentDir $cmdDest -FileName "$name.toml"
    }
}

function Uninstall-Codex {
    Write-Host "Uninstalling HoldMyBeer from Codex CLI..." -ForegroundColor Cyan
    $codexDir = Join-Path $TargetHome ".codex"
    $skillsDest = Join-Path $codexDir "skills"
    foreach ($name in $SkillNames) {
        Remove-KnownFolder -ParentDir $skillsDest -Name $name
    }
}

switch ($Platform) {
    "claude" { Uninstall-Claude }
    "gemini" { Uninstall-Gemini }
    "codex"  { Uninstall-Codex }
    "all"    { Uninstall-Claude; Uninstall-Gemini; Uninstall-Codex }
}

Write-Host ""
Write-Host "===== HoldMyBeer uninstall summary =====" -ForegroundColor Green
if ($removedItems.Count -gt 0) {
    Write-Host "Removed:" -ForegroundColor Green
    $removedItems | ForEach-Object { Write-Host "  - $_" }
} else {
    Write-Host "Nothing found to remove." -ForegroundColor Yellow
}
Write-Host ""
Write-Host "Note: this only removes HoldMyBeer's own files by exact name - any other skills/commands you have installed are untouched." -ForegroundColor Yellow
