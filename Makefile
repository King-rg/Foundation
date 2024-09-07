# Variables
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES := $(shell find hdl -name "*.sv" -o -name "*.svh")  # Finds all .sv and .svh files in hdl directory and subdirectories
TOPLEVEL := main_tb  # Name of the top-level module
MODULE := main      # Main top-level file

include $(shell cocotb-config --makefiles)/Makefile.sim
