#!/bin/bash
# 独立编译 + 生成 CuckooHashTable RTL
# 背景：Coursier 缓存里混有多个 SpinalHDL/Scala 版本，按 find 顺序拼 classpath 会加载错版本；
#       这里锁定 SpinalHDL 1.10.2 + Scala 2.12.20，并补齐 affinity/slf4j/jna 等运行期依赖。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../../../.." && pwd)"
CD="$HOME/Library/Caches/Coursier/v1"
OUT="${OUT:-/tmp/cuckoo_out}"

findjar() {
  local rel="$1"
  local j
  j=$(find "$CD" -path "*/$rel" ! -name '*-sources.jar' ! -name '*-javadoc.jar' | head -1)
  if [[ -z "$j" ]]; then
    echo "missing jar: $rel" >&2
    exit 1
  fi
  echo "$j"
}

CP=""
add() { CP="${CP}:$1"; }

# scala 2.12.20
add "$(findjar org/scala-lang/scala-compiler/2.12.20/scala-compiler-2.12.20.jar)"
add "$(findjar org/scala-lang/scala-library/2.12.20/scala-library-2.12.20.jar)"
add "$(findjar org/scala-lang/scala-reflect/2.12.20/scala-reflect-2.12.20.jar)"
# spinalhdl 1.10.2
add "$(findjar com/github/spinalhdl/spinalhdl-core_2.12/1.10.2/spinalhdl-core_2.12-1.10.2.jar)"
add "$(findjar com/github/spinalhdl/spinalhdl-idsl-payload_2.12/1.10.2/spinalhdl-idsl-payload_2.12-1.10.2.jar)"
add "$(findjar com/github/spinalhdl/spinalhdl-lib_2.12/1.10.2/spinalhdl-lib_2.12-1.10.2.jar)"
add "$(findjar com/github/spinalhdl/spinalhdl-sim_2.12/1.10.2/spinalhdl-sim_2.12-1.10.2.jar)"
# runtime deps
add "$(findjar org/scalactic/scalactic_2.12/3.2.10/scalactic_2.12-3.2.10.jar)"
add "$(findjar org/scalatest/scalatest_2.12/3.2.16/scalatest_2.12-3.2.16.jar)"
add "$(findjar com/github/scopt/scopt_2.12/4.1.0/scopt_2.12-4.1.0.jar)"
add "$(findjar com/lihaoyi/sourcecode_2.12/0.3.0/sourcecode_2.12-0.3.0.jar)"
add "$(findjar commons-io/commons-io/2.11.0/commons-io-2.11.0.jar)"
add "$(findjar net/openhft/affinity/3.23.2/affinity-3.23.2.jar)"
add "$(findjar org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar)"
add "$(findjar net/java/dev/jna/jna/5.13.0/jna-5.13.0.jar)"
add "$(findjar net/java/dev/jna/jna-platform/5.13.0/jna-platform-5.13.0.jar)"
add "$(findjar org/scala-lang/modules/scala-xml_2.12/1.3.0/scala-xml_2.12-1.3.0.jar)"

CP="${CP#:}"
PLUGIN="$(findjar com/github/spinalhdl/spinalhdl-idsl-plugin_2.12/1.10.2/spinalhdl-idsl-plugin_2.12-1.10.2.jar)"
JBR="${JBR:-/Applications/IntelliJ IDEA CE.app/Contents/jbr/Contents/Home}"

rm -rf "$OUT"
mkdir -p "$OUT"

cd "$ROOT"
"$JBR/bin/java" -cp "$CP" scala.tools.nsc.Main \
  -Xplugin:"$PLUGIN" \
  -classpath "$CP" \
  -d "$OUT" \
  src/main/scala/hash/HashTable.scala \
  src/main/scala/hash/MultiHashTable.scala \
  src/main/scala/hash/CrcCore.scala \
  src/main/scala/hash/CuckooHashTable.scala \
  src/main/scala/tool/GeneralConfig.scala

"$JBR/bin/java" -cp "$OUT:$CP" hash.CuckooHashTableRTL

ls -l "$ROOT/verilogGen/CuckooHashTable.v"
