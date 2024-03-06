# Makefile for VHDL project with GTKWave

# Compiler and flags
VHDL_COMPILER = ghdl

# Get all VHDL files in the current directory
VHDL_FILES = $(wildcard *.vhdl)

# Extract testbench file name without extension
TESTBENCH = $(basename $(wildcard *_tb.vhdl))

# Testbench and waveform file
WAVEFORM_FILE = $(TESTBENCH).ghw

# Default target
all: compile simulate view

# Compile VHDL files
compile:
	$(VHDL_COMPILER) -a $(VHDL_FILES)

# Simulate the testbench
# Remember to add assertion to the testbench!
# E.g. "assert false report "End of test" severity note; wait;"
simulate:
	$(VHDL_COMPILER) -r $(TESTBENCH) --wave=$(WAVEFORM_FILE)

# View the waveform using GTKWave
view:
	gtkwave $(WAVEFORM_FILE)

# Clean generated files
clean:
	rm -f *.ghw *.cf
