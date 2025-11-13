# 05_gerenciamento_armazenamento

📘 Descrição:
- # ======================================================
#  Makefile Inteligente 2.1 - Compatível com Linux e Windows
# ======================================================

# Nome do executável e pastas
TARGET = main
SRC_DIR = .
BUILD_DIR = build
BIN_DIR = bin

# Compilador e flags
CC = gcc
CFLAGS = -Wall -Wextra -std=c11

# Detecta todos os .c e gera nomes equivalentes .o em build/
SRC = $(wildcard $(SRC_DIR)/*.c)
OBJ = $(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SRC))

# Detecta SO (Windows = Windows_NT, caso contrário assume Linux)
ifeq ($(OS),Windows_NT)
    RM = del /Q
    MKDIR = if not exist
    SEP = \\
    EXE = .exe
else
    RM = rm -rf
    MKDIR = mkdir -p
    SEP = /
    EXE =
endif

# Regra padrão
all: prep $(BIN_DIR)$(SEP)$(TARGET)$(EXE)

# Criação das pastas
prep:
	@$(MKDIR) $(BUILD_DIR) $(SEP) $(BUILD_DIR)
	@$(MKDIR) $(BIN_DIR) $(SEP) $(BIN_DIR)

# Compilação incremental (.c -> .o)
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@echo Compilando $< ...
	@$(CC) $(CFLAGS) -c $< -o $@

# Link final (.o -> executável)
$(BIN_DIR)/$(TARGET)$(EXE): $(OBJ)
	@echo Ligando objetos...
	@$(CC) $(CFLAGS) -o $@ $(OBJ)
	@echo Compilado com sucesso em $(BIN_DIR)/$(TARGET)$(EXE)!

# Executar
run: all
	@echo Executando programa:
	@./$(BIN_DIR)/$(TARGET)$(EXE)

# Limpar
clean:
	@echo Limpando arquivos...
	@$(RM) $(BUILD_DIR) $(BIN_DIR)
	@echo Limpeza concluída.

