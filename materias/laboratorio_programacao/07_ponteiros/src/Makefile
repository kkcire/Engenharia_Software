# ======================================================
#  Makefile Inteligente 3.0 (Cross-platform + Smart Target)
# ======================================================

# Smart Target (main Ã© o padrao)
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


# Compile .c â†’ .o
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
