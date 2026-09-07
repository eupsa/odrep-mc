#!/usr/bin/env bash
# Baixa Paper + plugins do Modrinth nas versões de scripts/versions.env
# e monta a pasta run/. Requer: curl, jq
set -euo pipefail
cd "$(dirname "$0")/.."
source scripts/versions.env

RUN=run
PLUGINS="$RUN/plugins"
mkdir -p "$PLUGINS"

command -v jq >/dev/null || { echo "instale 'jq' (sudo apt install jq)"; exit 1; }

echo "==> Paper $MC_VERSION (Fill API v3)"
UA="odrep-mc/1.0 (+github)"
BUILDS=$(curl -fsSL -A "$UA" "https://fill.papermc.io/v3/projects/paper/versions/$MC_VERSION/builds")
# escolhe o último STABLE (fallback: primeiro da lista)
PAPER_URL=$(echo "$BUILDS" | jq -r '[.[] | select(.channel=="STABLE")][0].downloads."server:default".url // .[0].downloads."server:default".url')
PAPER_NAME=$(echo "$BUILDS" | jq -r '[.[] | select(.channel=="STABLE")][0].downloads."server:default".name // .[0].downloads."server:default".name')
[ -n "$PAPER_URL" ] && [ "$PAPER_URL" != "null" ] || { echo "falha ao resolver build do Paper"; exit 1; }
curl -fsSL -A "$UA" -o "$RUN/paper.jar" "$PAPER_URL"
echo "    ok ($PAPER_NAME)"

MINOR=$(echo "$MC_VERSION" | cut -d. -f1-2)   # ex: 1.21
for slug in $MODRINTH_PLUGINS; do
  [ -z "$slug" ] && continue
  echo "==> $slug"
  ALL=$(curl -fsSL -A "$UA" "https://api.modrinth.com/v2/project/$slug/version?loaders=%5B%22paper%22%2C%22spigot%22%2C%22bukkit%22%2C%22purpur%22%2C%22folia%22%5D")
  url=$(echo "$ALL" | jq -r --arg mc "$MC_VERSION" --arg minor "$MINOR" '
    ( [ .[] | select(.game_versions | index($mc)) ][0] )
    // ( [ .[] | select(.game_versions | map(startswith($minor)) | any) ][0] )
    // .[0]
    | (.files[] | select(.primary==true) | .url) // .files[0].url')
  if [ -z "$url" ] || [ "$url" = "null" ]; then
    echo "    !! falhou — baixe manualmente: https://modrinth.com/plugin/$slug"
    continue
  fi
  curl -fsSL -A "$UA" -o "$PLUGINS/$slug.jar" "$url"
  echo "    ok"
done

echo "==> Copiando configs versionadas"
cp -n server.properties "$RUN/server.properties" 2>/dev/null || true
mkdir -p "$RUN"
[ -d config ] && cp -n config/*.yml "$RUN/" 2>/dev/null || true
for f in plugins/*.example.yml; do
  [ -e "$f" ] || continue
  base=$(basename "$f" .example.yml)          # ex: OldCombatMechanics
  mkdir -p "$PLUGINS/$base"
  cp -n "$f" "$PLUGINS/$base/config.yml" 2>/dev/null || true
done

# datapacks -> run/world/datapacks/ (mundo precisa existir)
if [ -d datapacks ] && [ -d "$RUN/world" ]; then
  mkdir -p "$RUN/world/datapacks"
  cp -r datapacks/* "$RUN/world/datapacks/" 2>/dev/null || true
  echo "==> datapacks copiados (rode: datapack enable \"file/bridge-trainer\")"
fi

echo
echo "==> DOWNLOAD MANUAL (não têm API aberta) — salve os .jar em $PLUGINS/:"
for entry in $MANUAL_PLUGINS; do
  echo "    - ${entry%%|*}: ${entry#*|}"
done
echo
echo "Depois: echo eula=true > $RUN/eula.txt   &&   bash scripts/start.sh"
