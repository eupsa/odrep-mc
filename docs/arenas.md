# Arenas — o "pool" estilo Hypixel/Mush

Nos practice grandes, cada modo tem **várias arenas** e a partida sorteia **uma
aleatória**. A mesma arena é reusada nas partidas seguintes — os blocos se
regeneram. É isso que dá a impressão de "trocou de mapa".

O **Duels Optimised** faz isso sozinho: várias arenas ligadas aos mesmos kits →
sorteio automático + regeneração de blocos por partida.

## Não precisa construir — usar um pack

**41 Practice PvP Arenas + 10 Sumo Arenas** (PlanetMinecraft, grátis, `.schem`):
https://www.planetminecraft.com/project/41-practice-pvp-arenas-10-sumo-arenas-download/

Outras fontes: PlanetMinecraft `tag/practice?share=schematic`, `tag/arena?share=schematic`;
BuiltByBit `tags/practice-arenas` (filtro Free).

## Passo a passo

1. Extraia os `.schem` para `run/plugins/WorldEdit/schematics/`.
2. No jogo (OP, creative), vá a uma área vazia e alta. Para cada arena:
   ```
   //schem load <nome>
   //paste
   ```
   Ande ~120 blocos e cole a próxima. Repita umas 10–15 vezes.
3. Registre no Duels — para cada arena colada:
   - `/duels create <nome>`
   - fique no ponto de spawn do player 1 e marque; idem player 2
   - ligue a arena aos kits (todas as arenas do mesmo tipo aos mesmos kits)
4. No `run/plugins/Duels/config.yml`, confirme:
   ```yaml
   arena:
     regenerate: true          # restaura os blocos depois de cada duelo
   ```
   (o nome exato da opção varia com a versão — procure "regen" no config)
5. Teste: `/duel` → escolha o kit → entre na fila com você mesmo em 2 clientes,
   ou `/duel <jogador>`. A cada partida deve cair numa arena diferente.

## MLG Rush

Mesma ideia: `/rush setup` várias vezes para criar várias arenas; o plugin
sorteia. Mínimo 2–3 pra não repetir sempre.

## Bridge trainer (datapack)

É treino solo, não partida — não precisa de pool. Se quiser variar o visual,
edite `datapacks/bridge-trainer/data/bt/function/setup.mcfunction` (troque o
bloco / distância) ou faça 2–3 versões da função.
