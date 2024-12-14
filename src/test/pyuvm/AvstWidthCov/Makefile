CWD=$(shell pwd)
export COCOTB_REDUCED_LOG_FMT = 1
SIM ?= verilator
WAVES=1

export RANDOM_SEED := 123456789

TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES +=$(CWD)/../../../../simWorkspace/AvstCovtDemo/rtl/AvstCovtDemo.v
VERILOG_SOURCES +=$(CWD)/tb_avst_width_cov.v

export PYTHONPATH := $(CWD)/../../../..:${PYTHONPATH}
ifeq ($(SIM), verilator)
    # Enable processing of #delay statements
    COMPILE_ARGS += --timing -sv
    EXTRA_ARGS +=  --trace-fst --trace-structs
else ifeq ($(SIM), vcs)
	COMPILE_ARGS = +v2k \
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


