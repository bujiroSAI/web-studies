#!/bin/bash
# toei2 素材一括生成（6枚・逐次）。stop条件: 全件終了 or 1件でも3回失敗で中断
set -uo pipefail
DIR=~/web_gen_lab/drinkstill_replica/assets_toei2
IMG=/Users/soeno/soeno_master/_system/adapters/codex-img.sh
gen() { # name size
  local n=$1 s=$2 try=0
  while [ $try -lt 3 ]; do
    if "$IMG" --out "$DIR/$n.png" --prompt-file "$DIR/prompts/$n.txt" --size "$s"; then
      echo "OK $n"; return 0
    fi
    try=$((try+1)); echo "retry $n ($try)"; sleep 5
  done
  echo "FAIL $n"; return 1
}
gen win1_terraced 1600x1088 || exit 1
gen win2_coast    1600x1088 || exit 1
gen win3_town     1600x1088 || exit 1
gen bus_side      1536x1024 || exit 1
gen interior      1536x1024 || exit 1
gen sky           1920x800  || exit 1
echo ALL_DONE
