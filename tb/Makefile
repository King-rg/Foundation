# Variables
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES := $(shell find ../hdl ../tb_interface -name "*.sv" -o -name "*.svh")  # Finds all .sv and .svh files in hdl directory and subdirectories
TOPLEVEL := dual_port_RAM_interface  # Name of the top-level module
MODULE := dual_port_RAM_tb      # Main top-level file
SIM_BUILD = ../build/

include $(shell cocotb-config --makefiles)/Makefile.sim