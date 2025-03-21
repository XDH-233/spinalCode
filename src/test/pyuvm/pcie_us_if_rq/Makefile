
TOPLEVEL_LANG = verilog

SIM ?= icarus
WAVES ?= 1

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

DUT      = pcie_us_if_rq
TOPLEVEL = $(DUT)
MODULE   = test_$(DUT)
VERILOG_SOURCES += ../../rtl/$(DUT).v
VERILOG_SOURCES += ../../rtl/pcie_tlp_fifo.v
VERILOG_SOURCES += ../../rtl/pcie_tlp_fifo_raw.v

# module parameters
export PARAM_AXIS_PCIE_DATA_WIDTH := 64
export PARAM_AXIS_PCIE_KEEP_WIDTH := $(shell expr $(PARAM_AXIS_PCIE_DATA_WIDTH) / 32 )
export PARAM_AXIS_PCIE_RQ_USER_WIDTH := $(if $(filter-out 512,$(PARAM_AXIS_PCIE_DATA_WIDTH)),62,137)
export PARAM_RQ_STRADDLE := $(if $(filter-out 512,$(PARAM_AXIS_PCIE_DATA_WIDTH)),0,1)
export PARAM_RQ_SEQ_NUM_WIDTH := $(if $(filter-out 60,$(PARAM_AXIS_PCIE_RQ_USER_WIDTH)),6,4)
export PARAM_TLP_DATA_WIDTH := $(PARAM_AXIS_PCIE_DATA_WIDTH)
export PARAM_TLP_STRB_WIDTH := $(shell expr $(PARAM_TLP_DATA_WIDTH) / 32 )
export PARAM_TLP_HDR_WIDTH := 128
export PARAM_TLP_SEG_COUNT := 1
export PARAM_TX_SEQ_NUM_COUNT := $(if $(filter-out 512,$(PARAM_AXIS_PCIE_DATA_WIDTH)),1,2)
export PARAM_TX_SEQ_NUM_WIDTH := $(shell expr $(PARAM_RQ_SEQ_NUM_WIDTH) - 1 )

ifeq ($(SIM), icarus)
	PLUSARGS += -fst

	COMPILE_ARGS += $(foreach v,$(filter PARAM_%,$(.VARIABLES)),-P $(TOPLEVEL).$(subst PARAM_,,$(v))=$($(v)))

	ifeq ($(WAVES), 1)
		VERILOG_SOURCES += iverilog_dump.v
		COMPILE_ARGS += -s iverilog_dump
	endif
else ifeq ($(SIM), verilator)
	COMPILE_ARGS += -Wno-SELRANGE -Wno-WIDTH

	COMPILE_ARGS += $(foreach v,$(filter PARAM_%,$(.VARIABLES)),-G$(subst PARAM_,,$(v))=$($(v)))

	ifeq ($(WAVES), 1)
		COMPILE_ARGS += --trace-fst
	endif
endif

include $(shell cocotb-config --makefiles)/Makefile.sim

iverilog_dump.v:
	echo 'module iverilog_dump();' > $@
	echo 'initial begin' >> $@
	echo '    $$dumpfile("$(TOPLEVEL).fst");' >> $@
	echo '    $$dumpvars(0, $(TOPLEVEL));' >> $@
	echo 'end' >> $@
	echo 'endmodule' >> $@

clean::
	@rm -rf iverilog_dump.v
	@rm -rf dump.fst $(TOPLEVEL).fst
