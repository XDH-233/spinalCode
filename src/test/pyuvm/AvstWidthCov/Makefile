CWD=$(shell pwd)
export COCOTB_REDUCED_LOG_FMT = 1
SIM ?= verilator
WAVES=1

TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(CWD)/../../../../simWorkspace/AvstCovtDemo/rtl/AvstCovtDemo.v
VERILOG_SOURCES +=$(CWD)/tb_avst_width_cov.v

export PYTHONPATH := $(CWD)/../../../..:${PYTHONPATH}
ifeq ($(SIM), verilator)
    # Enable processing of #delay statements
    COMPILE_ARGS += --timing -sv
    EXTRA_ARGS +=  --trace-fst --trace-structs
endif
MODULE := test_avst_width_cov
TOPLEVEL := tb_avst_width_cov

GHDL_ARGS := --ieee=synopsys
COCOTB_HDL_TIMEUNIT = 1us
COCOTB_HDL_TIMEPRECISION = 1us

# include ../../checkclean.mk

all: clean sim

.PHONY:

sim:
    include $(shell cocotb-config --makefiles)/Makefile.sim

clean::
	rm -rf __pycache__ *.fst *.xml *.o *.log *key sim* *.fsdb novas* verdi* stack.info* *.fst


