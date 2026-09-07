# Baixa Paper (Fill API v3) + plugins do Modrinth e monta run\.
# Uso:  powershell -ExecutionPolicy Bypass -File scripts\setup.ps1
$ErrorActionPreference = 'Stop'
Set-Location (Join-Path $PSScriptRoot '..')

$UA  = @{ 'User-Agent' = 'odrep-mc/1.0 (+github)' }
$run = 'run'
$plugdir = Join-Path $run 'plugins'
New-Item -ItemType Directory -Force -Path $plugdir | Out-Null

# --- ler versions.env ---
$env2 = @{}
Get-Content 'scripts/versions.env' | ForEach-Object {
  if ($_ -match '^\s*([A-Z_]+)=(.*)$') { $env2[$Matches[1]] = $Matches[2].Trim().Trim('"') }
}
$MC = $env2['MC_VERSION']
Write-Host "==> Paper $MC (Fill API v3)"

$builds = Invoke-RestMethod -Headers $UA `
  "https://fill.papermc.io/v3/projects/paper/versions/$MC/builds"
$b = ($builds | Where-Object { $_.channel -eq 'STABLE' } | Select-Object -First 1)
if (-not $b) { $b = $builds | Select-Object -First 1 }
$dl = $b.downloads.'server:default'
Invoke-WebRequest -Headers $UA -Uri $dl.url -OutFile (Join-Path $run 'paper.jar')
Write-Host "    ok $($dl.name)  (build $($b.id))"

# --- plugins Modrinth ---
$minor = ($MC -split '\.')[0..1] -join '.'    # ex: 1.21
$slugs = $env2['MODRINTH_PLUGINS'] -split '\s+' | Where-Object { $_ }
foreach ($slug in $slugs) {
  Write-Host "==> $slug"
  try {
    # todas as versões p/ loader paper; escolhe a que serve 1.21.8, senão a mais nova 1.21.x
    $all = Invoke-RestMethod -Headers $UA `
      "https://api.modrinth.com/v2/project/$slug/version?loaders=%5B%22paper%22%2C%22spigot%22%2C%22bukkit%22%2C%22purpur%22%2C%22folia%22%5D"
    $pick = $all | Where-Object { $_.game_versions -contains $MC } | Select-Object -First 1
    if (-not $pick) { $pick = $all | Where-Object { ($_.game_versions | Where-Object { $_ -like "$minor*" }) } | Select-Object -First 1 }
    if (-not $pick) { $pick = $all | Select-Object -First 1 }
    $file = $pick.files | Where-Object { $_.primary } | Select-Object -First 1
    if (-not $file) { $file = $pick.files | Select-Object -First 1 }
    if (-not $file) { throw 'sem arquivo' }
    Invoke-WebRequest -Headers $UA -Uri $file.url -OutFile (Join-Path $plugdir "$slug.jar")
    Write-Host "    ok ($($pick.version_number), MC $($pick.game_versions -join ','))"
  } catch {
    Write-Host "    !! falhou -> baixe manual: https://modrinth.com/plugin/$slug"
  }
}

# --- copiar configs versionadas (sem sobrescrever) ---
function CopyNew($src,$dst){ if ((Test-Path $src) -and -not (Test-Path $dst)) { Copy-Item $src $dst } }
CopyNew 'server.properties' (Join-Path $run 'server.properties')
if (Test-Path 'config') { Get-ChildItem 'config\*.yml' | ForEach-Object { CopyNew $_.FullName (Join-Path $run $_.Name) } }
Get-ChildItem 'plugins\*.example.yml' -ErrorAction SilentlyContinue | ForEach-Object {
  $base = $_.Name -replace '\.example\.yml$',''
  $d = Join-Path $plugdir $base
  New-Item -ItemType Directory -Force -Path $d | Out-Null
  CopyNew $_.FullName (Join-Path $d 'config.yml')
}

Write-Host ''
Write-Host '==> DOWNLOAD MANUAL (salve os .jar em run\plugins\):'
($env2['MANUAL_PLUGINS'] -split '\s+' | Where-Object { $_ }) | ForEach-Object {
  $p = $_ -split '\|',2; Write-Host "    - $($p[0]): $($p[1])"
}

Write-Host ''
Write-Host 'Aceite a EULA da Mojang (https://aka.ms/MinecraftEULA) e rode:'
Write-Host "    Set-Content run\eula.txt 'eula=true' -Encoding ascii"
Write-Host '    scripts\start.bat'
