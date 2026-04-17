$output = Join-Path $PSScriptRoot 'project_hyperion_legacy_mod.zip'
$legacy = Join-Path $PSScriptRoot '..\legacy_web'
$docs = Join-Path $PSScriptRoot '..\docs\markdown'
if (Test-Path $output) { Remove-Item $output -Force }
Compress-Archive -Path $legacy, $docs -DestinationPath $output -Force
Write-Host "Pacote criado: $output"
