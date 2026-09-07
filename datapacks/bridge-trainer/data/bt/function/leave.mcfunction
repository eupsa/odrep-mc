scoreboard players set @s bt.run 0
tag @s remove bt.player
clear @s minecraft:white_concrete
effect clear @s minecraft:saturation
function bt:clear
execute at @e[tag=bt.start,limit=1] run tp @s ~ ~1 ~
spawnpoint @s
tellraw @s {"text":"[bridge-trainer] você saiu do treino.","color":"yellow"}
