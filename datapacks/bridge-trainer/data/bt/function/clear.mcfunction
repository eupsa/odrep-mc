# limpa TODA a ponte colocada, nas 4 direcoes (independe do sentido da pista).
# cada fill fica abaixo do limite de 32768 blocos.
execute at @e[tag=bt.start,limit=1] run fill ~-1 ~-2 ~-4 ~53 ~24 ~4 minecraft:air replace minecraft:white_concrete
execute at @e[tag=bt.start,limit=1] run fill ~1 ~-2 ~-4 ~-53 ~24 ~4 minecraft:air replace minecraft:white_concrete
execute at @e[tag=bt.start,limit=1] run fill ~-4 ~-2 ~-1 ~4 ~24 ~53 minecraft:air replace minecraft:white_concrete
execute at @e[tag=bt.start,limit=1] run fill ~-4 ~-2 ~1 ~4 ~24 ~-53 minecraft:air replace minecraft:white_concrete
