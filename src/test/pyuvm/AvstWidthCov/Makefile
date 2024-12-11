CWD=$(shell pwd)
export COCOTB_REDUCED_LOG_FMT = 1
SIM ?= verilator
WAVES=1
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(CWD)/../../AvstCovtDemo/rtl/AvstCovtDemo.v
VERILOG_SOURCES +=$(CWD)/tb_avst_width_cov.v

ifeq ($(SIM), verilator)
    # Enable processing of #delay statements
    COMPILE_ARGS += --timing -sv
    EXTRA_ARGS +=  --trace-fst --trace-structs
endif
MODULE := tb_avst_width_cov
TOPLEVEL = AvstCovtDemo
GHDL_ARGS := --ieee=synopsys
COCOTB_HDL_TIMEUNIT = 1us
COCOTB_HDL_TIMEPRECISION = 1us
include $(shell cocotb-config --makefiles)/Makefile.sim
# include ../../checkclean.mk
