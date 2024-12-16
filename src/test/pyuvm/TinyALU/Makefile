CWD=$(shell pwd)
export COCOTB_REDUCED_LOG_FMT = 1
SIM ?= vcs#verilator
WAVES=1
TOPLEVEL_LANG ?= verilog
ifeq ($(TOPLEVEL_LANG),verilog)
	VERILOG_SOURCES =$(CWD)/hdl/verilog/tinyalu.sv
else ifeq ($(TOPLEVEL_LANG),vhdl)
	VHDL_SOURCES=$(CWD)/hdl/vhdl/single_cycle_add_and_xor.vhd \
				$(CWD)/hdl/vhdl/three_cycle_mult.vhd \
				$(CWD)/hdl/vhdl/tinyalu.vhd
else
    $(error "A valid value (verilog or vhdl) was not provided for TOPLEVEL_LANG=$(TOPLEVEL_LANG)")
endif
ifeq ($(SIM), verilator)
    # Enable processing of #delay statements
    COMPILE_ARGS += --timing -sv
    EXTRA_ARGS +=  --trace-fst --trace-structs
else ifeq ($(SIM), vcs)
	COMPILE_ARGS += +v2k \
		-full64 \
		-fsdb \
		+vcs+fsdbon \
		-sverilog \
		-debug_acc+all -debug_region+cell+encrypt \
		-LDFLAGS -Wl,--no-as-needed \
		-timescale=1ns/1ps \
		-debug_access+r+w+nomemcbk -debug_region+cell \
		+vpi \
		+lint=PCWM \
		-kdb \
		-lca \
		-l build.log \
		+lint=TFIPC-L \
		+error+10000
endif
MODULE := testbench
TOPLEVEL = tinyalu
GHDL_ARGS := --ieee=synopsys
COCOTB_HDL_TIMEUNIT = 1us
COCOTB_HDL_TIMEPRECISION = 1us
include $(shell cocotb-config --makefiles)/Makefile.sim
# include ../../checkclean.mk
