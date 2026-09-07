# libera o trigger e processa quem pediu para entrar
scoreboard players enable @a bridge
execute as @a[scores={bridge=1..}] run function bt:begin

# cronometro
execute as @a[tag=bt.player,scores={bt.run=1..}] run scoreboard players add @s bt.time 1

# reabastece blocos (clear com count 0 so conta, nao remove)
execute as @a[tag=bt.player,scores={bt.run=1..}] store result score @s bt.n run clear @s minecraft:white_concrete 0
execute as @a[tag=bt.player,scores={bt.run=1..}] if score @s bt.n matches ..8 run give @s minecraft:white_concrete 64

# altura de queda: 3 blocos abaixo da largada
execute store result score #void bt.y run data get entity @e[tag=bt.start,limit=1] Pos[1] 1
scoreboard players remove #void bt.y 3
execute as @a[tag=bt.player,scores={bt.run=1..}] store result score @s bt.y run data get entity @s Pos[1] 1
execute as @a[tag=bt.player,scores={bt.run=1..}] if score @s bt.y <= #void bt.y run function bt:fell

# chegou no alvo
execute as @a[tag=bt.player,scores={bt.run=1..}] at @s if entity @e[tag=bt.end,distance=..2.5] run function bt:finish
