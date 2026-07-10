[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$target = Get-Item .
$sddFiles = @(".specify", ".gsd", "specify.md", "plan.md", "tasks.md", "SPEC.md", "PLAN.md")
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

$specifyDir = Join-Path $target ".specify"
New-Item -ItemType Directory -Force -Path $specifyDir | Out-Null

$templateSource = "C:\Users\aksha\.gemini\config\skills\holdmybeer-init\templates"
if (-not (Test-Path $templateSource)) {
    Write-Host "Error: Could not locate HoldMyBeer templates at $templateSource" -ForegroundColor Red
    Exit 1
}

Copy-Item -Path (Join-Path $templateSource "*") -Destination $specifyDir -Recurse -Force

# Print beautiful ASCII art and details
Write-Host ""
Write-Host "  _    _       _     _ __  __       ____" -ForegroundColor Yellow
Write-Host " | |  | |     | |   | |  \/  |     |  _ \"" -ForegroundColor Yellow
Write-Host " | |__| | ___ | | __| | \  / | ___ | |_) | ___  ___ _ __" -ForegroundColor Yellow
Write-Host " |  __  |/ _ \| |/ _` | |\/| |/ _ \|  _ < / _ \/ _ \ '__|" -ForegroundColor Yellow
Write-Host " | |  | | (_) | | (_| | |  | |  __/| |_) |  __/  __/ |" -ForegroundColor Yellow
Write-Host " |_|  |_|\___/|_|\__,_|_|  |_|\___||____/ \___|\___|_|" -ForegroundColor Yellow
Write-Host ""
Write-Host "🍺 HoldMyBeer Workspace Initialized Successfully!" -ForegroundColor Green
Write-Host "Files created in .specify/:" -ForegroundColor Green
Write-Host "  + specify.md      (Requirement Specification Template)" -ForegroundColor Green
Write-Host "  + plan.md         (Technical Phased Roadmap)" -ForegroundColor Green
Write-Host "  + tasks.md        (Implementation Task Checklist)" -ForegroundColor Green
Write-Host "  + constitution.md (Repository Standards & Rules)" -ForegroundColor Green
Write-Host "  + dashboard.html  (Interactive HTML Workspace View)" -ForegroundColor Green
Write-Host ""
Write-Host "Open .specify/dashboard.html in your browser to view your SDD workspace dashboard!" -ForegroundColor Cyan
