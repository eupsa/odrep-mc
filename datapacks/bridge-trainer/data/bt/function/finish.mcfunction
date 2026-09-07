scoreboard players set @s bt.run 0
scoreboard players operation @s bt.last = @s bt.time

# recorde
execute unless score @s bt.best matches 1.. run scoreboard players operation @s bt.best = @s bt.time
execute if score @s bt.time < @s bt.best run scoreboard players operation @s bt.best = @s bt.time

tellraw @s ["",{"text":"✔ ","color":"green"},{"text":"tempo: ","color":"gray"},{"score":{"name":"@s","objective":"bt.last"},"color":"white"},{"text":" ticks","color":"gray"},{"text":"  |  melhor: ","color":"gray"},{"score":{"name":"@s","objective":"bt.best"},"color":"aqua"}]
title @s title {"text":"✔","color":"green"}
title @s subtitle [{"score":{"name":"@s","objective":"bt.last"},"color":"white"},{"text":" ticks","color":"gray"}]

# reinicia automatico
function bt:start
