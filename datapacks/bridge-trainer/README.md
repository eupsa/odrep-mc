# bridge-trainer (datapack)

Trainer solo de ponte pro odrep-mc. Sem plugin. Funciona em qualquer 1.21.

`setup` copia esta pasta para `run/world/datapacks/bridge-trainer/`.
Depois, no console: `datapack enable "file/bridge-trainer"` e `reload`
(ou reinicie).

## Instalar a pista (1x, você OP)

1. Vá para uma área vazia e alta (ou o void do lobby) e **olhe na direção onde
   quer a pista** (qualquer um dos 4 lados — trava no cardeal mais próximo).
2. Rode: `/function bt:setup`
   - cria a largada, a plataforma de chegada 50 blocos à frente e os marcadores,
     no sentido pra onde você estava olhando.
3. Pra mover/re-orientar, rode `/function bt:setup` de novo noutro lugar.

O `/trigger bridge` já te vira de frente pro alvo — não precisa alinhar a mira.

## Jogar

| Ação | Comando |
|---|---|
| Entrar / reiniciar | `/trigger bridge` |
| Sair do treino | `/function bt:leave` |

- Caiu no void → volta pra largada e limpa a ponte, automático.
- Chegou na plataforma alvo → mostra o tempo em ticks (20 ticks = 1 s),
  guarda o recorde e já reinicia.
- Scoreboard lateral mostra o melhor tempo (`bt.best`).

## Ajustes

- **Distância / tamanho das plataformas**: edite `data/bt/function/setup.mcfunction`
  (os `fill` e a posição do marcador `bt.end`).
- **Altura de queda que conta como "caiu"**: em `tick.mcfunction`, a linha
  `scoreboard players remove #void bt.y 3` (3 blocos abaixo da largada).
- **Bloco da ponte**: `white_concrete` em todo lugar — se trocar, troque também
  no `replace` do `start.mcfunction` e `leave.mcfunction`.

## Nota sobre `pack_format`

`pack.mcmeta` usa `supported_formats` com faixa larga pra não quebrar entre
versões. Se o console reclamar de formato incompatível, ajuste o
`pack_format` pro número da sua versão (o log diz qual).
