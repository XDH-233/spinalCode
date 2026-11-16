#!/usr/bin/env python3
"""按参数批量生成 RadixIdTree 的 Verilog，供 cocotb 测试不同参数组合。

复用 spinalhdl-env 的无 sbt 编译流程（classpath 组装逻辑与
.claude/skills/spinalhdl-env/scripts/spinalc.sh 保持一致，注意两端需同步维护）：
一次 scalac 编译所有参数的 Gen object，再逐个运行 elaboration。

用法:
  python3 gen_rtl.py --id-num 256 --out rtl/RadixIdTree_256.v     # 单参数（Makefile 规则用）
  python3 gen_rtl.py --id-num 2 4 8 16 --out-dir rtl              # 批量（regress 用）
  python3 gen_rtl.py --id-num 256 --out ... --force               # 忽略缓存强制重生成
"""
import argparse
import glob
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
SOURCES = [
    os.path.join(REPO, "src/main/scala/radix_tree.scala"),
    os.path.join(REPO, "src/main/scala/tool/GeneralConfig.scala"),
]
JBR = "/Applications/IntelliJ IDEA CE.app/Contents/jbr/Contents/Home"
CACHE = os.path.expanduser(
    "~/Library/Caches/Coursier/v1/https/repo1.maven.org/maven2")

GEN_TEMPLATE = """import spinal.core._
object GenRadixIdTree{n} extends App {{
  tool.GeneralConfig.rtlGenConfig("{outdir}/").generateVerilog(RadixIdTree({n}))
}}
"""


def classpath():
    scala = os.path.join(CACHE, "org/scala-lang")
    trio = [f"{scala}/scala-{p}/2.12.20/scala-{p}-2.12.20.jar"
            for p in ("compiler", "library", "reflect")]
    jars = glob.glob(os.path.join(CACHE, "**", "*.jar"), recursive=True)
    others = [j for j in jars
              if not j.endswith(("-sources.jar", "-javadoc.jar"))
              and "/scala-" + "/".join("") not in j
              and all(f"scala-{p}-2.12.20.jar" not in j
                      for p in ("compiler", "library", "reflect"))]
    return ":".join(trio + sorted(others))


def check_env():
    if not os.path.exists(os.path.join(JBR, "bin/java")):
        sys.exit(f"[gen_rtl] 未找到 IntelliJ JDK 21: {JBR}")
    for s in SOURCES:
        if not os.path.exists(s):
            sys.exit(f"[gen_rtl] 找不到源文件: {s}")


def gen_batch(id_nums, out_dir, force=False):
    check_env()
    os.makedirs(out_dir, exist_ok=True)
    outs = {n: os.path.join(out_dir, f"RadixIdTree_{n}.v") for n in id_nums}
    todo = [n for n in id_nums if force or not os.path.exists(outs[n])]
    if not todo:
        print("[gen_rtl] 全部命中缓存，跳过编译")
        return
    cp = classpath()
    plugin = glob.glob(os.path.join(
        CACHE, "**/spinalhdl-idsl-plugin_2.12-1.10.2.jar"), recursive=True)[0]
    with tempfile.TemporaryDirectory(prefix="radixidtree_gen_") as td:
        classes = os.path.join(td, "classes")
        os.makedirs(classes, exist_ok=True)  # scalac 要求 -d 目录必须已存在
        gen_file = os.path.join(td, "GenAll.scala")
        with open(gen_file, "w") as f:
            for n in todo:
                f.write(GEN_TEMPLATE.format(n=n, outdir=out_dir))
        print(f"[gen_rtl] scalac 编译 {len(todo)} 个 Gen object ...")
        subprocess.run([
            os.path.join(JBR, "bin/java"), "-cp", cp, "scala.tools.nsc.Main",
            f"-Xplugin:{plugin}", "-classpath", cp, "-d", classes, gen_file,
            *SOURCES], check=True)
        for n in todo:
            print(f"[gen_rtl] elaborate RadixIdTree({n}) ...")
            subprocess.run([
                os.path.join(JBR, "bin/java"), "-cp", f"{classes}:{cp}",
                f"GenRadixIdTree{n}"], check=True)
            os.replace(os.path.join(out_dir, "RadixIdTree.v"), outs[n])
            print(f"[gen_rtl]   -> {outs[n]}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--id-num", type=int, nargs="+", required=True)
    ap.add_argument("--out", help="单参数输出文件（--out-dir 二选一）")
    ap.add_argument("--out-dir", help="批量输出目录，文件名 RadixIdTree_<n>.v")
    ap.add_argument("--force", action="store_true", help="忽略已存在的输出强制重生成")
    a = ap.parse_args()
    if a.out:
        gen_batch(a.id_num, os.path.dirname(os.path.abspath(a.out)), a.force)
    elif a.out_dir:
        gen_batch(a.id_num, os.path.abspath(a.out_dir), a.force)
    else:
        ap.error("需要 --out 或 --out-dir")


if __name__ == "__main__":
    main()
