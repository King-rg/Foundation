# Variables
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES := $(shell find ../hdl ../tb_interface -name "*.sv" -o -name "*.svh")  # Finds all .sv and .svh files in hdl directory and subdirectories
TOPLEVEL := full_adder_4b_interface  # Name of the top-level module
MODULE := full_adder_4b_tb      # Main top-level file

include $(shell cocotb-config --makefiles)/Makefile.sim