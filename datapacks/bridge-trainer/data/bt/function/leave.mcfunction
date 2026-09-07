scoreboard players set @s bt.run 0
tag @s remove bt.player
clear @s minecraft:white_concrete
effect clear @s minecraft:saturation
spawnpoint @s
tp @s @e[type=marker,tag=bt.start,limit=1]
execute at @e[tag=bt.start,limit=1] run fill ~-1 ~-1 ~-3 ~52 ~20 ~3 minecraft:air replace minecraft:white_concrete
tellraw @s {"text":"[bridge-trainer] você saiu do treino.","color":"yellow"}
