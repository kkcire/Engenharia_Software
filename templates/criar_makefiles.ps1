param(
    [int]$DisciplinaIndex # opcional: 1, 2, 3...
)

function Pause-PS { Read-Host "`nPressione Enter para sair" }

Write-Host ""
Write-Host "=== CRIADOR DE MAKEFILES ==="
Write-Host ""

# Pasta atual deve ser 'materias'
$materiasPath = (Get-Location).Path
Write-Host "Pasta base: $materiasPath"
Write-Host ""

# Disciplinas = subpastas diretas
$disciplinas = Get-ChildItem -LiteralPath $materiasPath -Directory
if (-not $disciplinas -or $disciplinas.Count -eq 0) {
    Write-Host "Nenhuma disciplina encontrada."
    Pause-PS; exit
}

# Se DisciplinaIndex nao foi passado, abrir menu interativo
if (-not $DisciplinaIndex -or $DisciplinaIndex -lt 1 -or $DisciplinaIndex -gt $disciplinas.Count) {
    # Monta opcoes
    $choices = @()
    for ($i=0; $i -lt $disciplinas.Count; $i++) {
        $choices += New-Object System.Management.Automation.Host.ChoiceDescription "&$($i+1) $($disciplinas[$i].Name)"
    }
    $title = "Selecione a disciplina"
    $message = "Use as teclas numericas para escolher."
    $result = $Host.UI.PromptForChoice($title, $message, $choices, 0)
    $DisciplinaIndex = $result + 1
}

# Seleciona a disciplina
$disc = $disciplinas[$DisciplinaIndex - 1]
$discPath = $disc.FullName

Write-Host ""
Write-Host "Selecionado: $($disc.Name)"
Write-Host ""

# Encontrar todas as pastas 'src' (somente nas aulas)
$pastasSrc = Get-ChildItem -Path $discPath -Recurse -Directory | Where-Object { $_.Name -eq "src" }

if (-not $pastasSrc -or $pastasSrc.Count -eq 0) {
    Write-Host "Nenhuma pasta 'src' encontrada em $($disc.Name)."
    Pause-PS; exit
}

# Conteudo padrao do Makefile (versao limpa e funcional)
$makefileContent = @'
# ======================================================
#  Makefile Inteligente 2.6 - Smart Target via VS Code
# ======================================================

# Smart target: nome do arquivo atual ou "main"
TARGET ?= $(FILE)
ifeq ($(TARGET),)
	TARGET = main
endif

# Directories
SRC_DIR = .
BUILD_DIR = build
BIN_DIR = bin

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c11

# OS detection (Windows_NT = Windows)
ifeq ($(OS),Windows_NT)
	RM = del /Q
	MKDIR = cmd /C if not exist
	EXE = .exe
	RUN = $(BIN_DIR)\\$(TARGET)$(EXE)
else
	RM = rm -rf
	MKDIR = mkdir -p
	EXE =
	RUN = ./$(BIN_DIR)/$(TARGET)$(EXE)
endif

# Default rule
all: prep $(BIN_DIR)/$(TARGET)$(EXE)

# Folder creation (cross-platform)
prep:
ifeq ($(OS),Windows_NT)
	@$(MKDIR) $(BUILD_DIR) mkdir $(BUILD_DIR)
	@$(MKDIR) $(BIN_DIR) mkdir $(BIN_DIR)
else
	@$(MKDIR) $(BUILD_DIR)
	@$(MKDIR) $(BIN_DIR)
endif

# Compile single .c → .o (Smart Target)
$(BUILD_DIR)/$(TARGET).o: $(SRC_DIR)/$(TARGET).c
	@echo Compiling $(TARGET).c ...
	@$(CC) $(CFLAGS) -c $< -o $@

# Link object → executable
$(BIN_DIR)/$(TARGET)$(EXE): $(BUILD_DIR)/$(TARGET).o
	@echo Linking $(TARGET).o ...
	@$(CC) $(CFLAGS) -o $@ $<
	@echo Build complete: $@

# Run program
run: all
	@echo Running $(TARGET):
	@echo.
	@$(RUN)
	@echo.

# Clean up
clean:
	@echo Cleaning up...
	@$(RM) $(BUILD_DIR) $(BIN_DIR)
	@echo Done.
'@


# Criar ou atualizar Makefile em cada src
foreach ($src in $pastasSrc) {
    $mk = Join-Path $src.FullName "Makefile"

    # Sempre reescreve o Makefile (versao limpa)
    $makefileContent | Set-Content -Path $mk -Encoding UTF8
    Write-Host "[*] Atualizado: $mk"
}

Write-Host ""
Write-Host "Makefiles criados ou atualizados com sucesso!"
Pause-PS