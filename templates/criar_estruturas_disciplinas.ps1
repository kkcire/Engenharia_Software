# Impede erros silenciosos
$ErrorActionPreference = "Stop"

# Define codificação segura
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Função para pausar no final
function Pause-PS {
    Read-Host "`nPressione Enter para sair"
}

# Diretório atual (deve ser a pasta 'materias')
$materiasPath = (Get-Location).Path
Write-Host "`n=== GERADOR DE ESTRUTURA DE AULAS ===" -ForegroundColor Cyan
Write-Host "Pasta base: $materiasPath`n"

# Lista as disciplinas (subpastas de 'materias')
$disciplinas = Get-ChildItem -LiteralPath $materiasPath -Directory

if ($disciplinas.Count -eq 0) {
    Write-Host "Nenhuma disciplina encontrada nesta pasta." -ForegroundColor Red
    Pause-PS
    return
}

# Mostra lista numerada
Write-Host "Disciplinas encontradas:`n"
for ($i = 0; $i -lt $disciplinas.Count; $i++) {
    Write-Host "$($i + 1). $($disciplinas[$i].Name)"
}

# Usuário escolhe qual disciplina usar
$escolha = Read-Host "`nDigite o numero da disciplina desejada"
if ($escolha -notmatch "^\d+$" -or [int]$escolha -lt 1 -or [int]$escolha -gt $disciplinas.Count) {
    Write-Host "Escolha invalida." -ForegroundColor Red
    Pause-PS
    return
}

# Caminho da disciplina escolhida
$disciplina = $disciplinas[[int]$escolha - 1]
$disciplinaPath = $disciplina.FullName
Write-Host "`nSelecionado: $($disciplina.Name)" -ForegroundColor Yellow

# Lista as pastas de aulas dentro da disciplina
$aulas = Get-ChildItem -LiteralPath $disciplinaPath -Directory

if ($aulas.Count -eq 0) {
    Write-Host "Nenhuma aula encontrada dentro de $($disciplina.Name)." -ForegroundColor DarkYellow
    Pause-PS
    return
}

# Loop por cada aula
foreach ($aula in $aulas) {
    $aulaPath = $aula.FullName
    $src = Join-Path $aulaPath "src"
    $docs = Join-Path $aulaPath "docs"
    $main = Join-Path $src "main.c"
    $readme = Join-Path $aulaPath "README.md"

    # Evita criar dentro de src/docs existentes
    if ($aula.Name -eq "src" -or $aula.Name -eq "docs") {
        continue
    }

    # Cria pastas
    New-Item -ItemType Directory -Path $src  -Force | Out-Null
    New-Item -ItemType Directory -Path $docs -Force | Out-Null

    # Cria main.c se não existir
    if (-not (Test-Path -LiteralPath $main)) {
        $conteudoC = @'
#include <stdio.h>

int main(void) {
    printf("Hello, world!\n");
    return 0;
}
'@
        Set-Content -Path $main -Encoding UTF8 -Value $conteudoC
        Write-Host "[+] Criado: $($aula.Name)\src\main.c" -ForegroundColor Green
    }
    else {
        Write-Host "[=] main.c já existe em $($aula.Name)" -ForegroundColor DarkYellow
    }

    # Cria README.md se não existir
    if (-not (Test-Path -LiteralPath $readme)) {
        $titulo = Split-Path $aulaPath -Leaf
        Set-Content -Path $readme -Encoding UTF8 -Value ("# " + $titulo + "`r`n`r`nDescricao:`r`n- ")
        Write-Host "[+] Criado: $($aula.Name)\README.md" -ForegroundColor Green
    }

    Write-Host "[+] Pasta docs criada ou existente em $($aula.Name)" -ForegroundColor Cyan
}

Write-Host "`nEstrutura criada com sucesso na disciplina '$($disciplina.Name)'!" -ForegroundColor Yellow
Pause-PS
