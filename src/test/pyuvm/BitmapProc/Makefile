TOPLEVEL_LANG = verilog

ifdef VCS_HOME
	SIM ?= vcs
else
	SIM ?= verilator
endif

PWD = $(shell pwd)

export COCOTB_RANDOM_SEED=12345678

WAVES ?= 1

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

export PYTHONPATH := $(PWD)/../../:$(PYTHONPATH)

DUT      = BitmapProc
TOPLEVEL = $(DUT)
COCOTB_TEST_MODULES    = test_$(DUT)
VERILOG_SOURCES += $(PWD)/../../../../verilogGen/BitmapProc.v



ifeq ($(SIM), vcs)
	COMPILE_ARGS = +v2k \
		-full64 \
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
		+define+DUMP_FSDB_WITH_STRUCT \
		+define+DUMP_FSDB_WITH_STRUCT \
		+define+BITS_MEM_SIMLIB \
		+error+10000

else ifeq ($(SIM), icarus)
	PLUSARGS += -fst


	ifeq ($(WAVES), 1)
		VERILOG_SOURCES += iverilog_dump.v
		COMPILE_ARGS += -s iverilog_dump
	endif
else ifeq ($(SIM), verilator)
	COMPILE_ARGS += -Wno-SELRANGE -Wno-WIDTH -Wno-BLKANDNBLK -Wno-PINMISSING

	ifeq ($(WAVES), 1)
		EXTRA_ARGS += --trace --trace-fst --trace-structs
	endif
endif

include $(shell cocotb-config --makefiles)/Makefile.sim



clean::
	@rm -rf iverilog_dump.v
	@rm -rf dump.fst $(TOPLEVEL).fst