# Personalizar o lobby

O mapa você já baixou. "Personalizar" aqui = deixar funcional e com a cara do
servidor **sem construir bloco** — com plugins. O que muda blocos de verdade
(cores, estruturas novas) é WorldEdit, feito por você no criativo (recipes no
fim).

Plugins baixados pelo `setup` pra isso: **DecentHolograms**, **FancyNpcs**,
**DeluxeMenus** (+ PlaceholderAPI, já tinha).

---

## 1. Nome / branding — holograma

No lugar onde quer o título (olhando pra ele):

```
/dh create spawn
/dh line spawn 1 &b&lODREP &f&lPRACTICE
/dh line spawn 2 &7play.odrep.gg
/dh addline spawn &aOnline: %server_online%
```

- Move: fica no ponto onde você rodou `create`. Pra reposicionar: `/dh movehere spawn`.
- `%server_online%` atualiza sozinho (precisa PlaceholderAPI + `/papi ecloud download Server`).

## 2. Leaderboard — holograma com placeholder

```
/dh create topelo
/dh line topelo &6&lTOP ELO
/dh addline topelo &7#1 %duels_top_name_elo_1% &f- %duels_top_elo_1%
/dh addline topelo &7#2 %duels_top_name_elo_2% &f- %duels_top_elo_2%
/dh addline topelo &7#3 %duels_top_name_elo_3% &f- %duels_top_elo_3%
```

Confira os nomes reais com `/papi ecloud download Duels` e `/papi parse me %duels_...%`.

## 3. NPCs pra entrar nas filas

```
/npc create Duelos --type player
/npc skin <nick_ou_url>
```

Depois liga o clique a um comando (FancyNpcs):

```
/npc action add Duelos player_command "duel"
```

Repita pra cada modo: um NPC "1v1", um "MLG Rush" (`mlgrush join`), etc.
Posiciona cada NPC andando até o lugar e `/npc teleport <nome> @s` (ou o comando
de mover do FancyNpcs).

## 4. Bússola que abre o menu (item ao entrar)

`run/plugins/DeluxeMenus/config.yml` já tem um menu `filas`. Pra dar a bússola
ao entrar e abrir com clique, adicione em `gui_menus` do DeluxeMenus um
`open_command` e um `bind_item`, ou use o `join-items` do EssentialsX. Abrir na
mão: `/dm open filas`.

## 5. Void — não cair pra sempre

Se o lobby é ilha flutuante: WorldGuard com `/rg flag __global__ -w world
passthrough deny` é exagero. Simples: barreira de `barrier` embaixo (WorldEdit)
ou um plugin de "anti-void" que teleporta pro spawn. Ou deixa o
`gamerule fallDamage` ligado e põe um `//walls` de vidro na borda.

---

## Editar o mapa de verdade (WorldEdit, você faz)

```
//wand                     pega o machado de seleção
//pos1 / //pos2            ou clica os 2 cantos
//set <bloco>              preenche
//walls <bloco>            só as paredes
//replace <de> <para>      troca cor
//copy  //paste            duplica pedaço
//schem load <nome>  //paste   cola decoração baixada
```

Schematics de decoração grátis: PlanetMinecraft (filtro *Downloadable
Schematic*), BuiltByBit (tag free).
