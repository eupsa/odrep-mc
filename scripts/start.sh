#!/usr/bin/env bash
# Inicia o servidor com flags do Aikar. Uso: bash scripts/start.sh [heap_MB]
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/versions.env

RUN_DIR=run
HEAP="${1:-8192}"          # MB. VM Oracle 12GB -> 8192. Localhost -> 3072.
JAR="$RUN_DIR/paper.jar"

[ -f "$JAR" ] || { echo "paper.jar não encontrado. Rode: bash scripts/setup.sh"; exit 1; }
[ -f "$RUN_DIR/eula.txt" ] || { echo "Falta run/eula.txt. Rode: echo eula=true > run/eula.txt"; exit 1; }

cd "$RUN_DIR"
exec java \
  -Xms"${HEAP}M" -Xmx"${HEAP}M" \
  -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 \
  -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
  -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
  -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
  -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 \
  -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 \
  -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
  -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true \
  -jar paper.jar --nogui
