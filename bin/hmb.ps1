[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$target = Get-Item .
$sddFiles = @(".holdmybeer", ".gsd", "specify.md", "plan.md", "tasks.md", "SPEC.md", "PLAN.md")
$found = @()
foreach ($file in $sddFiles) {
    if (Test-Path (Join-Path $target $file)) {
        $found += $file
    }
}

if ($found.Count -gt 0) {
    Write-Host "🍺 [HoldMyBeer] SDD structure already detected in this directory:" -ForegroundColor Yellow
    foreach ($f in $found) {
        Write-Host "  - $f" -ForegroundColor Yellow
    }
    Write-Host "Initialization aborted to prevent overwriting existing work." -ForegroundColor Yellow
    Exit 0
}

# No existing SDD files, proceed with initialization
Write-Host "🍺 Initializing HoldMyBeer SDD workspace..." -ForegroundColor Cyan

$specifyDir = Join-Path $target ".holdmybeer"
New-Item -ItemType Directory -Force -Path $specifyDir | Out-Null

$templateSource = "C:\Users\aksha\.gemini\config\skills\hmb\templates"
if (-not (Test-Path $templateSource)) {
    Write-Host "Error: Could not locate HoldMyBeer templates at $templateSource" -ForegroundColor Red
    Exit 1
}

Copy-Item -Path (Join-Path $templateSource "*") -Destination $specifyDir -Recurse -Force

# Print beautiful ASCII art and details
Write-Host ""
Write-Host '  _   _       _     _ __  __       ____                 ' -ForegroundColor Yellow
Write-Host ' | | | | ___ | | __| |  \/  |_   _| __ )  ___  ___ _ __ ' -ForegroundColor Yellow
Write-Host ' | |_| |/ _ \| |/ _` | |\/| | | | |  _ \ / _ \/ _ \ ''__|' -ForegroundColor Yellow
Write-Host ' |  _  | (_) | | (_| | |  | | |_| | |_) |  __/  __/ |   ' -ForegroundColor Yellow
Write-Host ' |_| |_|\___/|_|\__,_|_|  |_|\__, |____/ \___|\___|_|   ' -ForegroundColor Yellow
Write-Host '                             |___/                      ' -ForegroundColor Yellow
Write-Host ""
Write-Host "🍺 HoldMyBeer Workspace Initialized Successfully!" -ForegroundColor Green
Write-Host "Files created in .holdmybeer/:" -ForegroundColor Green
Write-Host "  + psm.json        (Project Semantic Model empty schema)" -ForegroundColor Green
Write-Host "  + constitution.md (Repository Standards & Rules)" -ForegroundColor Green
Write-Host ""
Write-Host "Run /hmb-crack to distill requirements and start building!" -ForegroundColor Cyan
