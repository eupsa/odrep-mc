# Gera a pista. Rode PARADO onde quer a plataforma de largada, olhando para +X.
# A pista vai no sentido +X: largada em ~, alvo ~50 blocos a frente.
# Bloco da pista: white_concrete (usado para limpar no reset).

# limpa instalacao anterior
kill @e[tag=bt.start]
kill @e[tag=bt.end]

# plataforma de largada 5x5 (topo em y-1 relativo aos pes)
fill ~-1 ~-1 ~-2 ~2 ~-1 ~2 minecraft:quartz_block
# plataforma alvo 7x7
fill ~48 ~-1 ~-3 ~54 ~-1 ~3 minecraft:quartz_block
# paredinha no alvo pra nao passar direto
fill ~55 ~-1 ~-3 ~55 ~2 ~3 minecraft:quartz_block

# marcadores
summon minecraft:marker ~ ~ ~ {Tags:["bt.start"]}
summon minecraft:marker ~51 ~ ~ {Tags:["bt.end"]}

tellraw @a {"text":"[bridge-trainer] pista criada. Entre com /trigger bridge","color":"green"}
