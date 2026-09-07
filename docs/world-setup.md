# Ajustes do mundo

## "Não quebrar blocos" — não é gamerule

Nenhum gamerule vanilla faz "proteção de blocos por jogador". As opções:

| Como | Efeito | Quando usar |
|---|---|---|
| `gamemode=adventure` + `force-gamemode=true` no `server.properties` | ninguém que não seja OP/creative quebra ou põe bloco, em lugar nenhum | **produção** — o mais simples |
| WorldGuard (plugin) com região no lobby: `block-break deny`, `block-place deny` | proteção por região; arenas ficam livres | quando quiser lobby travado + áreas abertas no mesmo mundo |
| Deixar pros plugins | Duels e MLGRush protegem/restauram a arena deles sozinhos e trocam o gamemode durante a partida | já funciona automático |

Recomendado agora: quando abrir ao público, no `server.properties` troque
`gamemode=creative` → `adventure` e `force-gamemode=false` → `true`, copie pro
`run/` e reinicie. Você (OP) continua construindo com `/gamemode creative`.

## Gamerules — rodar 1x no console (persistem no `level.dat`)

```
gamerule doDaylightCycle false
gamerule doWeatherCycle false
gamerule doMobSpawning false
gamerule doFireTick false
gamerule mobGriefing false
gamerule doTileDrops false
gamerule doEntityDrops false
gamerule doBlockDrops false
gamerule keepInventory true
gamerule showDeathMessages false
gamerule announceAdvancements false
gamerule doInsomnia false
gamerule doPatrolSpawning false
gamerule doTraderSpawning false
gamerule disableRaids true
gamerule randomTickSpeed 0
gamerule spawnRadius 0
```

Depois trave o horário: `time set day`.

> Deixe **fora** desta lista os gamerules de dano (`fallDamage`, `fireDamage`,
> `drowningDamage`): você tem um mundo só, e as arenas de duelo precisam de fall
> damage funcionando. Os plugins de practice cuidam do resto durante a partida.

## Ordem de setup do mundo

1. `op SEU_NICK` (console)
2. entra, `/gamemode creative`
3. cola o bloco de gamerules acima
4. voa até o lobby, `/setworldspawn` no ponto de spawn dos players
5. cria as arenas (`//paste` dos schematics) e registra no Duels
6. `/mlgrush setup`
7. quando for abrir: `server.properties` → `adventure` + `force-gamemode=true`
