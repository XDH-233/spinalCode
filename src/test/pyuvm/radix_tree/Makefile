TOPLEVEL_LANG = verilog

ifdef VCS_HOME
	SIM ?= vcs
else
	SIM ?= verilator
endif

PWD  = $(shell pwd)
REPO = $(PWD)/../../../..

export COCOTB_RANDOM_SEED=12345678

WAVES ?= 1

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

export PYTHONPATH := $(PWD)/../../:$(PYTHONPATH)

# ---------- 参数化 RTL 生成（cocotb 内嵌 Scala 编译） ----------
# 单参数: make ID_NUM=64          （自动调 gen_rtl.py 生成 rtl/RadixIdTree_64.v）
# 批量回归: make regress          （遍历 ID_NUMS 逐个仿真）
ID_NUM  ?= 256
ID_NUMS := 2 4 8 16 64 256 1024
RTL_DIR = $(PWD)/rtl
GEN_RTL = python3 $(PWD)/gen_rtl.py

DUT      = radix_tree
TOPLEVEL = RadixIdTree
COCOTB_TEST_MODULES    = test_$(DUT)
VERILOG_SOURCES += $(RTL_DIR)/RadixIdTree_$(ID_NUM).v

# 每个参数独立 build/results 目录，互不污染
SIM_BUILD    = $(PWD)/sim_build_$(ID_NUM)
RESULTS_FILE = $(PWD)/results_$(ID_NUM).xml

$(RTL_DIR)/RadixIdTree_%.v: $(PWD)/gen_rtl.py \
                            $(REPO)/src/main/scala/radix_tree.scala \
                            $(REPO)/src/main/scala/tool/GeneralConfig.scala
	$(GEN_RTL) --id-num $* --out $@

.PHONY: gen-rtl regress
gen-rtl:
	$(GEN_RTL) --id-num $(ID_NUMS) --out-dir $(RTL_DIR)

regress: gen-rtl
	@for n in $(ID_NUMS); do \
		echo "===== RadixIdTree id_num=$$n ====="; \
		$(MAKE) -s ID_NUM=$$n sim || exit 1; \
	done



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
		+error+10000

else ifeq ($(SIM), verilator)
	COMPILE_ARGS += -Wno-SELRANGE -Wno-WIDTH -Wno-BLKANDNBLK -Wno-PINMISSING
endif

# cocotb 2.0 用 VERILATOR_TRACE 控制 --trace(编译) + --trace(运行时 SIM_ARGS)；
# 这里只补 --trace-fst 使 dump 落成 fst 而非 vcd。
# 注意：ifeq 指令不能用 Tab 缩进，否则被当作 recipe 忽略（WAVES 开关会静默失效）
VERILATOR_TRACE ?= $(WAVES)
ifeq ($(SIM),verilator)
ifeq ($(WAVES),1)
COMPILE_ARGS += --trace-fst
endif
endif

include $(shell cocotb-config --makefiles)/Makefile.sim



clean::
	@rm -rf rtl sim_build_* results_*.xml dump.fst $(TOPLEVEL).fst
