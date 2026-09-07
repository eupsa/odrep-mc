# (re)inicia uma tentativa para @s
execute at @e[tag=bt.start,limit=1] run tp @s ~ ~ ~ facing entity @e[tag=bt.end,limit=1] feet
# limpa a ponte colocada (relativo ao marcador de largada)
execute at @e[tag=bt.start,limit=1] run fill ~-1 ~-1 ~-3 ~52 ~20 ~3 minecraft:air replace minecraft:white_concrete
gamemode survival @s
clear @s minecraft:white_concrete
give @s minecraft:white_concrete 64
scoreboard players set @s bt.time 0
scoreboard players set @s bt.run 1
tag @s add bt.player
effect give @s minecraft:saturation 99999 255 true
effect give @s minecraft:instant_health 1 20 true
title @s actionbar {"text":"GO!","color":"green","bold":true}
