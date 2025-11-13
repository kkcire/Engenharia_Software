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

# Compile single .c â†’ .o (Smart Target)
$(BUILD_DIR)/$(TARGET).o: $(SRC_DIR)/$(TARGET).c
	@echo Compiling $(TARGET).c ...
	@$(CC) $(CFLAGS) -c $< -o $@

# Link object â†’ executable
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
