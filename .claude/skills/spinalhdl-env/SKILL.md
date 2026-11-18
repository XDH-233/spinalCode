---
name: spinalhdl-env
description: 本机无 sbt 时编译、运行和验证 SpinalHDL 代码的完整流程（缓存 jar + IntelliJ JDK 21 + cocotb/Verilator 仿真），以及所有踩过的坑。当需要编译 .scala 源文件、生成 Verilog、或对 SpinalHDL 模块做 cocotb/pyuvm 功能仿真时使用。
---

# SpinalHDL 环境使用（无 sbt）

本机（macOS arm64）**没有安装 sbt CLI**，Scala 2.12.20 编译器不支持系统 JDK 24。
所有依赖 jar 已缓存在 Coursier 缓存中，IntelliJ CE 自带可用的 JDK 21。

## 快速用法

编译 + 运行（脚本已封装全部细节，见 `scripts/spinalc.sh`）：

```bash
# 仅编译，产物输出到 /tmp/spinal_out
.claude/skills/spinalhdl-env/scripts/spinalc.sh src/main/scala/PopulationCount.scala

# 编译并运行某个 Gen object（生成 Verilog 到 verilogGen/）
.claude/skills/spinalhdl-env/scripts/spinalc.sh --out /tmp/spinal_out --run PopCountTreeGen \
  src/main/scala/PopulationCount.scala src/main/scala/tool/GeneralConfig.scala
```

- 脚本**不做源码依赖解析**：引用了 `tool.GeneralConfig` 等项目内代码时，把依赖的
  .scala 文件一并列出（如上例）
- Verilog 生成约定：Gen object 内用
  `tool.GeneralConfig.rtlGenConfig("verilogGen/").generateVerilog(...)`，
  参考各模块文件末尾的 `object XxxRTL/xxxGen extends App` 写法

## 脚本内部机制（手动复现时照此）

1. **Java**：用 IntelliJ 自带 JDK 21（Scala 2.12.20 编译器不支持系统 JDK 24，
   会报 `object scala in compiler mirror not found`）：
   ```
   /Applications/IntelliJ IDEA CE.app/Contents/jbr/Contents/Home/bin/java
   ```
2. **classpath**：从 Coursier 缓存拼出（排除 sources/javadoc jar）。
   **坑：缓存里混有 scala-library 2.12.21 / 2.13.18 / scala3-library 等多版本**，
   JVM 层按 classpath 顺序类加载，`find` 顺序不确定时编译器初始化会报
   `AbstractMethodError ... GenericParCompanion companion()`。
   必须把 2.12.20 三件套（compiler/library/reflect）锁定放在最前，
   `find` 时排除这三种名字。
3. **编译**：直接调 scalac 入口类。两个关键点缺一不可：
   - `-Xplugin:` 显式加载 `spinalhdl-idsl-plugin_2.12-1.10.2.jar`
     （`32 bits` 这类后缀语法靠它在编译期改写 AST，缺失则编不过）
   - `-classpath "$CP"` 必须通过 **scalac 自己的标志**再传一次；
     scalac 不继承 JVM 层的 `java -cp`（`-Ylog-classpath` 可见搜索路径只有 `.`）

   ```bash
   "$JBR/bin/java" -cp "$CP" scala.tools.nsc.Main \
     -Xplugin:"$(find $CACHE -name 'spinalhdl-idsl-plugin_2.12-1.10.2.jar' | head -1)" \
     -classpath "$CP" -d "$OUT" <scala 文件...>
   ```
4. **运行**：`"$JBR/bin/java" -cp "$OUT:$CP" <MainClass>`

## cocotb / pyuvm 仿真

测试目录约定：`src/test/pyuvm/<DUT>/`，内含 Makefile（从 one_hot2bin /
slot_bitmap_proc 等现有 Makefile 复制改 `DUT` 和 `VERILOG_SOURCES`）
和 `test_<DUT>.py`；RTL 引用 `$(PWD)/../../../../verilogGen/$(DUT).v`。

```bash
export PATH="$HOME/Library/Python/3.9/bin:$PATH"   # 提供 cocotb-config
cd src/test/pyuvm/<DUT> && make SIM=verilator
```

环境：cocotb 2.0.1 + pyuvm 4.0.1 + cocotb-bus 0.3.0，装在系统 Python **3.9**
（`/Library/Developer/CommandLineTools/usr/bin/python3`），不在默认 PATH 里。
Verilator 需 ≥ **5.036**（cocotb 2.0 的硬性要求）；本机通过 Homebrew 历史 formula
（tap `local/verilator5036`）安装 5.036，不是最新的 5.054。
pyuvm 4.0.1 支持 cocotb 2.0，并保留 `utility_classes` 等旧 API；
cocotb-bus 0.3.0 兼容 cocotb 2.0。DataCache / AvstWidthCov 用例已验证通过。
`cocotb-coverage` 已卸载（仓库测试没有使用它），`pip check` 无冲突。

**坑（Python 3.9 / cocotb 2.0 适配）**：

- cocotb 2.0 不再暴露 `cocotb.triggers` 隐式属性，
  必须 `from cocotb.triggers import Timer`，否则
  `AttributeError: module 'cocotb' has no attribute 'triggers'`
- Python 3.9 没有 `int.bit_count()`（3.10+ 才有），用 `bin(v).count("1")`
- 纯组合逻辑 DUT（无 clk）不需要启动时钟，赋值后 `await Timer(1, unit="ns")` 再读
- cocotb 2.0 移除了 `cocotb.utils.hexdump`；老用例（如 AvstWidthCov）需换成本地实现
- `src/test/pyuvm/lib/__init__.py` 需要显式 `from enum import IntEnum`，不能依赖 pyuvm 的隐式导入
- Verilator 5.036 对旧 RTL 的 width warning 会直接报错；需要
  `-Wno-WIDTHEXPAND -Wno-WIDTHTRUNC`（或 `-Wno-fatal`）

## Verilator 独立仿真（不经 cocotb）

```bash
verilator --cc --build --top-module <模块名> <模块名>.v \
  --exe tb_<模块名>.cpp -o sim_<模块名>
./obj_dir/sim_<模块名>
```

- 不要同时用 `--binary` 和 `--exe`（`main` 重复符号链接错误），用 `--cc --build --exe`
- testbench 用 C++ 写，随机向量与参考实现比对
- 临时 testbench 和产物放 `/tmp` 下独立目录，不污染仓库

## 边界

- 此流程适合**验证单个或少量文件**；增量编译、scalatest、SpinalSim 后端仍需 sbt/IDE
- 若用户环境中 sbt 可用（`command -v sbt`），优先 `sbt "runMain ..."`
