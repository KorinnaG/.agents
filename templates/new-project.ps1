#Requires -Version 5.1
<#
.SYNOPSIS
  Scaffold a new web project wired to the shared AI blueprint (as a git submodule) in one command.

.DESCRIPTION
  Does everything: creates the folder, git init, adds the blueprint submodule at .agents,
  copies AGENTS.template.md -> AGENTS.md, drops .env.example / .gitignore, seeds decisions/,
  and makes the first commit.

  ONE-TIME SETUP: publish the blueprint contents (this .agents/ folder) as its own GitHub repo,
  then set $BlueprintUrl below (or pass -BlueprintUrl).

.EXAMPLE
  .\new-project.ps1 my-site
.EXAMPLE
  .\new-project.ps1 my-site -Path C:\Users\owlko\Desktop -BlueprintUrl https://github.com/you/agents-blueprint.git
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory, Position = 0)]
  [string] $Name,
  [string] $Path = (Get-Location).Path,
  [string] $BlueprintUrl = 'https://github.com/CHANGE-ME/agents-blueprint.git'
)

$ErrorActionPreference = 'Stop'
function Fail($m) { Write-Host "ERROR: $m" -ForegroundColor Red; exit 1 }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Fail 'git is not installed or not on PATH.' }
if ($BlueprintUrl -like '*CHANGE-ME*') { Fail 'Edit this script and set $BlueprintUrl to your published blueprint repo URL (or pass -BlueprintUrl).' }

$dest = Join-Path $Path $Name
if (Test-Path $dest) { Fail "Folder already exists: $dest" }

Write-Host "Creating $dest ..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path $dest | Out-Null
Set-Location $dest

git init | Out-Null
git submodule add $BlueprintUrl .agents
if ($LASTEXITCODE -ne 0) { Fail 'git submodule add failed - check the blueprint URL and your access.' }

# Project-specific files from the blueprint templates
Copy-Item '.agents/templates/AGENTS.template.md' 'AGENTS.md'
if (Test-Path '.agents/templates/env.example')        { Copy-Item '.agents/templates/env.example' '.env.example' }
if (Test-Path '.agents/templates/gitignore.template') { Copy-Item '.agents/templates/gitignore.template' '.gitignore' }
New-Item -ItemType Directory -Path 'decisions' | Out-Null
Set-Content 'decisions/README.md' "# Project Decisions (ADRs)`n`nProcess: .agents/docs/decisions.md - Template: .agents/templates/adr.template.md" -Encoding utf8

git add .
git commit -m 'Start project with AI blueprint submodule' | Out-Null

Write-Host ''
Write-Host "Done. Project ready at $dest" -ForegroundColor Green
Write-Host 'Next: open AGENTS.md and fill in the {{FIELDS}}, then start building.' -ForegroundColor Green
