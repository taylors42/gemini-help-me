#Requires -RunAsAdministrator

function Print-Error {
    param([string]$message)
    Write-Host "❌ Erro: $message" -ForegroundColor Red
    exit 1
}

function Print-Success {
    param([string]$message)
    Write-Host "✅ $message" -ForegroundColor Green
}

Write-Host "Este script irá adicionar o executável 'gemini-help-me' ao seu PATH."
$binaryPath = Read-Host "Por favor, insira o caminho completo para o executável 'gemini-help-me.exe'"

if (-not (Test-Path -Path $binaryPath -PathType Leaf)) {
    Print-Error "O arquivo não foi encontrado em '$binaryPath'."
}

$binaryDir = Split-Path -Path $binaryPath -Parent

Write-Host "Adicionando o diretório '$binaryDir' ao seu PATH..."

$currentUserPath = [System.Environment]::GetEnvironmentVariable("Path", "User")

if ($currentUserPath -notlike "*$binaryDir*") {
    $newPath = "$currentUserPath;$binaryDir"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Print-Success "O diretório de instalação foi adicionado ao seu PATH."
    Write-Host "Por favor, reinicie o seu terminal para que as alterações entrem em vigor."
} else {
    Print-Success "O diretório já está no seu PATH."
}

Write-Host "Instalação concluída!"