# chamado com  execute at @e[tag=bt.end]  — solta fogos no alvo
summon minecraft:firework_rocket ~ ~1 ~ {LifeTime:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[{shape:"large_ball",colors:[I;16724787,16777045]},{shape:"star",colors:[I;3978132]}]}}}}
summon minecraft:firework_rocket ~2 ~1 ~1 {LifeTime:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[{shape:"burst",colors:[I;16777215],fade_colors:[I;65535]}]}}}}
summon minecraft:firework_rocket ~-2 ~1 ~-1 {LifeTime:0,FireworksItem:{id:"minecraft:firework_rocket",count:1,components:{"minecraft:fireworks":{explosions:[{shape:"large_ball",colors:[I;65280]}]}}}}
playsound minecraft:entity.firework_rocket.large_blast master @a ~ ~ ~ 3 1
playsound minecraft:entity.firework_rocket.twinkle master @a ~ ~ ~ 3 1
