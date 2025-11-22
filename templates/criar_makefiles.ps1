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
#  Makefile Inteligente 3.0 (Cross-platform + Smart Target)
# ======================================================

# Smart Target (main é o padrao)
TARGET = $(if $(FILE),$(FILE),main)

# Directories
SRC_DIR = .
BUILD_DIR = build
BIN_DIR = bin

# Tools
CC = gcc
CFLAGS = -Wall -Wextra -std=c11 -MMD -MP

# OS detection
ifeq ($(OS),Windows_NT)
	MKDIR = mkdir
	RM = rmdir /S /Q
	EXE = .exe
	RUN = $(BIN_DIR)\\$(TARGET)$(EXE)
else
	MKDIR = mkdir -p
	RM = rm -rf
	EXE =
	RUN = ./$(BIN_DIR)/$(TARGET)
endif

# Source/Object mapping
SRC = $(TARGET).c
OBJ = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC))
DEP = $(OBJ:.o=.d)

# Default rule
all: prep $(BIN_DIR)/$(TARGET)$(EXE)

# Create directories
prep:
ifeq ($(OS),Windows_NT)
	@if not exist "$(BUILD_DIR)" mkdir "$(BUILD_DIR)"
	@if not exist "$(BIN_DIR)" mkdir "$(BIN_DIR)"
else
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BIN_DIR)
endif


# Compile .c → .o
$(BUILD_DIR)/%.o: %.c
	@echo Compiling $<
	@$(CC) $(CFLAGS) -c $< -o $@

# Link
$(BIN_DIR)/$(TARGET)$(EXE): $(OBJ)
	@echo Linking $(TARGET) ...
	@$(CC) $(CFLAGS) -o $@ $^
	@echo Build complete: $@

# Run
run: all
	@echo Running $(TARGET):
	@echo.
	@$(RUN)

# Clean
clean:
	@echo Cleaning...
	@$(RM) $(BUILD_DIR) 2>nul || true
	@$(RM) $(BIN_DIR) 2>nul || true

# Auto-dependencies
-include $(DEP)
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