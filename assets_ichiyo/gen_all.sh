#!/bin/bash
set -uo pipefail
DIR=~/web_gen_lab/drinkstill_replica/assets_ichiyo
IMG=/Users/soeno/soeno_master/_system/adapters/codex-img.sh
for n in h1_white h2_grey h3_beige h4_sage h5_navy h6_terra; do
  try=0
  while [ $try -lt 3 ]; do
    if "$IMG" --out "$DIR/$n.png" --prompt-file "$DIR/prompts/$n.txt" --size 1216x832; then echo "OK $n"; break; fi
    try=$((try+1)); echo "retry $n ($try)"; sleep 5
  done
  [ -f "$DIR/$n.png" ] || { echo "FAIL $n"; exit 1; }
done
echo ALL_DONE
