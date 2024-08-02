# Compiler and linker
CC = fasm

# Directories and files
MAIN = main
LIB_DIR = asmlib
LIB_SRC = $(wildcard ./$(LIB_DIR)/*.asm)
LIB_OBJ = $(wildcard ./$(LIB_DIR)/*.o)

# Target names
.PHONY: default compile build run clean

default: build run

compile:
	$(CC) $(LIB_SRC)

# Build rule: assemble all .asm files into a single executable
build:
	$(CC) ${MAIN}.asm
	ld ${MAIN}.o $(LIB_OBJ) -o ${MAIN}
 
# Run rule: execute the compiled program
run:
	./$(MAIN)

# Clean rule: remove generated files
clean:
	# rm -f $(MAIN)
	find . -name "*.bak" -type f
	# find . -name "*.bak" -type f -delete
	# rm */*.bak
