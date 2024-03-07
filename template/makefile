# Makefile for VHDL project with GTKWave

# Compiler and flags
VHDL_COMPILER = ghdl

# Compiler flags
VHDL_FLAGS = --std=08

# Get all VHDL files in the current directory
VHDL_FILES = $(wildcard *.vhdl)

# Extract testbench file name without extension
TESTBENCH = $(basename $(wildcard *_tb.vhdl))

# Testbench and waveform file
WAVEFORM_FILE = $(TESTBENCH).ghw

# Default target
all: compile simulate view

format:
	for file in $(filter-out %_tb.vhdl,$(VHDL_FILES)); do \
		ghdl --format $$file > $${file%.*}_temp.vhdl && mv $${file%.*}_temp.vhdl $$file && $(VHDL_COMPILER) -a $(VHDL_FLAGS) $$file; \
	done
	for file in $(filter %_tb.vhdl,$(VHDL_FILES)); do \
		ghdl --format $$file > $${file%.*}_temp.vhdl && mv $${file%.*}_temp.vhdl $$file && $(VHDL_COMPILER) -a $(VHDL_FLAGS) $$file; \
	done

# Compile VHDL files
compile:
	$(VHDL_COMPILER) -a $(VHDL_FLAGS) $(VHDL_FILES)

# Simulate the testbench
# Remember to add assertion or finish to the testbench!
# E.g. "assert false report "End of test" severity note; wait;"
# E.g. "report "End of test"; finish;"
simulate:
	$(VHDL_COMPILER) -r $(VHDL_FLAGS) $(TESTBENCH) --wave=$(WAVEFORM_FILE)

# View the waveform using GTKWave
view:
	gtkwave $(WAVEFORM_FILE)

# Clean generated files
clean:
	rm -f *.ghw *.cf
