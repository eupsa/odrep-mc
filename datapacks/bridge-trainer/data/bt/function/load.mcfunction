# odrep bridge-trainer — inicializacao
scoreboard objectives add bt.time dummy
scoreboard objectives add bt.best dummy {"text":"Melhor tempo (ticks)","color":"aqua"}
scoreboard objectives add bt.run dummy
scoreboard objectives add bt.y dummy
scoreboard objectives add bt.n dummy
scoreboard objectives add bt.last dummy
scoreboard objectives add bridge trigger

scoreboard objectives setdisplay sidebar bt.best

tellraw @a {"text":"[bridge-trainer] carregado. Fique no ponto de largada e rode: /function bt:setup","color":"green"}
