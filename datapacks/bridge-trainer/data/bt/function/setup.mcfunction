# Gera a pista no sentido +X. Rode PARADO onde quer a largada.
# Nao importa pra onde voce olha — o /trigger bridge alinha sua mira no alvo.
# Bloco da pista: white_concrete (usado pra limpar no reset).

kill @e[tag=bt.start]
kill @e[tag=bt.end]

# largada 5x5 (topo em y-1 relativo aos pes)
fill ~-2 ~-1 ~-2 ~2 ~-1 ~2 minecraft:quartz_block
# alvo 7x7, 50 blocos a frente (+X)
fill ~48 ~-1 ~-3 ~54 ~-1 ~3 minecraft:quartz_block
# paredinha atras do alvo
fill ~55 ~-1 ~-3 ~55 ~3 ~3 minecraft:quartz_block

summon minecraft:marker ~ ~ ~ {Tags:["bt.start"]}
summon minecraft:marker ~51 ~ ~ {Tags:["bt.end"]}

tellraw @a {"text":"[bridge-trainer] pista criada. Entre com /trigger bridge","color":"green"}
