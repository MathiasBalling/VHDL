# Makefile for VHDL project with GTKWave
.PHONY: format all compile simulate view clean lsp help

# Compiler and flags
VHD_COMPILER = ghdl

# Compiler flags
VHD_FLAGS = --std=08 -fsynopsys

# IP files
IP_FILES = $(wildcard ../../IP/*.vhd)

# Get all VHD files in the current directory
VHD_FILES = $(wildcard *.vhd)

# Extract testbench file name without extension
TESTBENCH = $(basename $(wildcard *_tb.vhd))

# Testbench and waveform file
WAVEFORM_FILE = $(TESTBENCH).ghw

# Default target
help:
	@echo "Usage: make [target]"
	@echo "Available targets:"
	@echo "  all       - Compile, simulate and view the waveform"
	@echo "  compile   - Compile the VHD files"
	@echo "  simulate  - Simulate the testbench"
	@echo "  view      - View the waveform using GTKWave"
	@echo "  format    - Format the VHD files"
	@echo "  lsp       - Generate Language Server Protocol configuration"
	@echo "  clean     - Clean generated files"
	@echo "  help      - Display this help message"

# Make all
all: compile simulate view

# Compile VHD files
compile:
	$(VHD_COMPILER) -a $(VHD_FLAGS) $(IP_FILES) $(VHD_FILES)

# Simulate the testbench
# Remember to add assertion or finish to the testbench!
# E.g. "assert false report "End of test" severity note; wait;"
# E.g. "report "End of test"; finish;"
simulate:
	$(VHD_COMPILER) -r $(VHD_FLAGS) $(TESTBENCH) --wave=$(WAVEFORM_FILE)

# View the waveform using GTKWave
view:
	gtkwave $(WAVEFORM_FILE)

format:
	for file in $(filter-out %_tb.vhd,$(VHD_FILES)); do \
		ghdl --format $$file > $${file%.*}_temp.vhd && mv $${file%.*}_temp.vhd $$file \
	done
	for file in $(filter %_tb.vhd,$(VHD_FILES)); do \
		ghdl --format $$file > $${file%.*}_temp.vhd && mv $${file%.*}_temp.vhd $$file \
	done

# Clean generated files
clean:
	rm -f *.ghw *.cf *_temp.vhd vhdl_ls.toml

lsp:
	@echo "[libraries]" > vhdl_ls.toml
	@echo "lib.files = [" >> vhdl_ls.toml
	@for file in $(VHD_FILES); do \
		echo "  \"$$file\"," >> vhdl_ls.toml; \
	done
	@echo "]" >> vhdl_ls.toml
	@echo "IP.files = [" >> vhdl_ls.toml
	@for file in $(IP_FILES); do \
		echo "  \"$$file\"," >> vhdl_ls.toml; \
	done
	@echo "]" >> vhdl_ls.toml

