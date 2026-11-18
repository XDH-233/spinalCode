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

DUT      = CuckooHashTable
TOPLEVEL = $(DUT)
COCOTB_TOPLEVEL = $(DUT)
# cocotb 1.x uses MODULE, cocotb 2.x uses COCOTB_TEST_MODULES; set both
MODULE = test_cuckoo_hash_table
COCOTB_TEST_MODULES = test_cuckoo_hash_table
VERILOG_SOURCES += $(PWD)/../../../../verilogGen/$(DUT).v

ifeq ($(SIM), verilator)
	COMPILE_ARGS += -Wno-SELRANGE -Wno-WIDTH -Wno-BLKANDNBLK -Wno-PINMISSING -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM

	ifeq ($(WAVES), 1)
		# cocotb 2.0 原生开关；--trace-fst 让 verilator.cpp 写 dump.fst
		VERILATOR_TRACE = 1
		COMPILE_ARGS += --trace-fst
	endif
endif

include $(shell cocotb-config --makefiles)/Makefile.sim
