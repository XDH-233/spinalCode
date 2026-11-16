#!/bin/bash
# spinalc.sh — 无 sbt 环境下编译/运行 SpinalHDL 源文件
# 用法:
#   spinalc.sh [--run MainClass] [--out DIR] file1.scala [file2.scala ...]
#   --run MainClass  编译后运行指定的 main 类（如 Verilog Gen object）
#   --out DIR        编译产物目录，默认 /tmp/spinal_out
set -euo pipefail

JBR="/Applications/IntelliJ IDEA CE.app/Contents/jbr/Contents/Home"
CACHE="$HOME/Library/Caches/Coursier/v1/https/repo1.maven.org/maven2"

[[ -x "$JBR/bin/java" ]] || { echo "错误: 未找到 IntelliJ JDK 21: $JBR" >&2; exit 1; }

RUN_CLASS=""
OUT="/tmp/spinal_out"
FILES=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --run) RUN_CLASS="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    *)     FILES+=("$1"); shift ;;
  esac
done
[[ ${#FILES[@]} -gt 0 ]] || { echo "用法: spinalc.sh [--run MainClass] [--out DIR] file.scala ..." >&2; exit 1; }

# 缓存里可能混有 scala-library 2.12.21/2.13/scala3 等其他版本,
# JVM 层类加载按 classpath 顺序取先者, 必须锁定 2.12.20 三件套并放在最前
SCALA_CORE="$CACHE/org/scala-lang"
CP="$SCALA_CORE/scala-compiler/2.12.20/scala-compiler-2.12.20.jar:$SCALA_CORE/scala-library/2.12.20/scala-library-2.12.20.jar:$SCALA_CORE/scala-reflect/2.12.20/scala-reflect-2.12.20.jar:"
CP+=$(find "$CACHE" -name "*.jar" \
  ! -name "*-sources.jar" ! -name "*-javadoc.jar" \
  ! -name "scala-compiler-*.jar" ! -name "scala-library-*.jar" ! -name "scala-reflect-*.jar" \
  | tr '\n' ':')
PLUGIN=$(find "$CACHE" -name 'spinalhdl-idsl-plugin_2.12-1.10.2.jar' | head -1)

mkdir -p "$OUT"
echo "== scalac 编译: ${FILES[*]} =="
"$JBR/bin/java" -cp "$CP" scala.tools.nsc.Main \
  -Xplugin:"$PLUGIN" \
  -classpath "$CP" \
  -d "$OUT" \
  "${FILES[@]}"

if [[ -n "$RUN_CLASS" ]]; then
  echo "== 运行: $RUN_CLASS =="
  "$JBR/bin/java" -cp "$OUT:$CP" "$RUN_CLASS"
fi
